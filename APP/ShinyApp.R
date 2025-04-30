# Import packages
library(shiny)
library(shinythemes)
library(leaflet)
library(ggplot2)
library(plotly)
library(maps)
library(forecast)

# Import data (example structure - you'll need actual data files)
economy_data <- data.frame(
  Year = 2000:2023,
  GDP = c(10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33),
  Growth_Rate = c(5.0, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8, 5.9, 6.0, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 6.9, 7.0, 7.1, 7.2, 7.3)
)

cpi_data <- data.frame(
  Year = 1985:2023,
  CPI = seq(30, 150, length.out = 39),
  INFLATION = runif(39, 1, 5)
)

comparison_data <- list(
  social = data.frame(
    Indicator = c("Population (2023)", "Population Growth (%)", "Life Expectancy (Years)", 
                  "Population Density (per km²)", "Human Development Index (HDI)", "Sex Ratio (M/F)"),
    `Lord Howe Island` = c("382", "0.2%", "82.5", "3.2", "0.895", "102.1"),
    `Norfolk Island` = c("1,748", "-0.5%", "80.2", "61", "0.851", "98.7"),
    `Tasmania` = c("572,800", "0.8%", "81.3", "8.3", "0.921", "98.2"),
    `New Zealand` = c("5.1 Million", "1.1%", "82.0", "19", "0.931", "97.8")
  ),
  economic = data.frame(
    Indicator = c("GDP (2023, USD Million)", "GDP Growth Rate (%)", "Inflation Rate (%)", 
                  "Unemployment Rate (%)", "Tourism Contribution to GDP (%)"),
    `Lord Howe Island` = c("25.7", "2.1%", "2.5%", "3.2%", "75.2%"),
    `Norfolk Island` = c("68.3", "1.8%", "3.1%", "4.5%", "65.8%"),
    `Tasmania` = c("32,456", "3.2%", "4.2%", "5.1%", "12.3%"),
    `New Zealand` = c("247,000", "3.5%", "5.9%", "4.3%", "9.8%")
  )
)

# Define UI
ui <- fluidPage(
  theme = shinytheme("cerulean"),
  
  tags$head(tags$style(HTML("
    body {
      background-color: #E6F2FF !important; /* Light blue background */
    }
    .header {
      background-color: #B3D9FF; /* Lighter blue header */
      color: black;
      padding: 0 15px;
      height: 60px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      border-bottom: 3px solid #00509E;
    }
    .header h1 {
      font-size: 36px;
      font-weight: bold;
      margin: 0;
      line-height: 60px;
    }
    .sidebar {
      background-color: transparent !important;
      color: white !important;
      height: 100vh;
      padding: 0;
    }
    .sidebar .nav-title {
      background-color: transparent;
      color: #00509E;
      font-size: 18px;
      font-weight: bold;
      text-align: center;
      padding: 12px 0;
      margin: 0;
    }
    .content-section {
      background-color: white;
      border-radius: 10px;
      padding: 20px;
      margin-top: 10px;
      box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }
    h3 {
      font-size: 22px;
      color: #00509E;
      border-bottom: 2px solid #00509E;
      padding-bottom: 10px;
      margin-top: 0;
    }
  "))),
  
  div(class = "header",
      h1("Lord Howe Island"),
      tags$img(
        src = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Lord_Howe_Island_flag.svg/1200px-Lord_Howe_Island_flag.svg.png",
        height = "55px", style = "margin-right: 10px;")
  ),
  
  fluidRow(
    column(
      2,
      div(class = "sidebar",
          div(class = "nav-title", "Navigation"),
          navlistPanel(
            id = "nav",
            tabPanel("Overview"),
            tabPanel("Prediction"),
            tabPanel("Comparison"),
            tabPanel("SWOT Analysis"),
            tabPanel("Reference"),
            widths = c(12, 10)
          )
      )
    ),
    
    column(
      10,
      div(class = "content-section", uiOutput("main_content"))
    )
  )
)

# Server
server <- function(input, output, session) {
  
  # Render UI for Overview
  output$main_content <- renderUI({
    if (input$nav == "Overview") {
      fluidPage(
        h3("Lord Howe Island Overview"),
        tabsetPanel(
          tabPanel("Island Map", 
                   tags$div(
                     h4("Map Description:"),
                     p("This map provides a detailed view of Lord Howe Island, showing its unique geography with Mount Gower and Mount Lidgbird. Users can select different map types from the dropdown menu."),
                     leafletOutput("island_map", height = "500px")
                   )
          ),
          tabPanel("Regional Position", 
                   tags$div(
                     h4("Map Description:"),
                     p("This map shows Lord Howe Island's position in the Tasman Sea, approximately 600 km east of mainland Australia."),
                     leafletOutput("regional_map", height = "500px")
                   )
          ),
          tabPanel("Economy", 
                   tags$div(
                     h4("Economy Overview"),
                     p("This section provides insights into Lord Howe Island's economy, which is primarily based on tourism and conservation."),
                     
                     radioButtons("economy_plot_choice", "Select a Chart to Display:",
                                  choices = c("Economic Indicators" = "gdp", 
                                              "Price Trends" = "cpi"),
                                  selected = "gdp", inline = TRUE),
                     
                     conditionalPanel(
                       condition = "input.economy_plot_choice == 'gdp'",
                       sliderInput("gdp_slider", "Select Year Range:",
                                   min = 2000, max = 2023, value = c(2000, 2023), step = 1)
                     ),
                     conditionalPanel(
                       condition = "input.economy_plot_choice == 'cpi'",
                       sliderInput("cpi_slider", "Select Year Range:",
                                   min = 1985, max = 2023, value = c(1985, 2023), step = 1)
                     ),
                     
                     plotlyOutput("economy_plot", height = "500px")
                   )
          ),
          tabPanel("Demographics", 
                   p("Lord Howe Island has a permanent population of around 380 people, with tourism numbers restricted to 400 visitors at any time to protect the island's fragile ecosystem. The population is primarily of European descent, with a mix of Australian and New Zealand residents."),
                   tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Lord_Howe_Island_-_view_from_Mt_Gower.jpg/800px-Lord_Howe_Island_-_view_from_Mt_Gower.jpg", 
                            height = "500px", width = "100%", 
                            style = "display: block; margin: 10px auto; border-radius: 10px;")
          ),
          tabPanel("Geography", 
                   p("Lord Howe Island is an irregularly crescent-shaped volcanic remnant in the Tasman Sea between Australia and New Zealand. The island is approximately 10 km long and between 0.3 and 2.0 km wide with an area of 14.55 km². The island's most famous landmarks are the volcanic mountains Mount Gower (875 m) and Mount Lidgbird (777 m). The island has a diverse ecosystem with many endemic species, and about 75% of the island's original natural vegetation remains."),
                   tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Lord_Howe_Island_NASA.jpg/800px-Lord_Howe_Island_NASA.jpg", 
                            height = "500px", width = "100%", 
                            style = "display: block; margin: 10px auto; border-radius: 10px;")),
          tabPanel("History", 
                   p("Lord Howe Island was discovered on 17 February 1788 by Lieutenant Henry Lidgbird Ball, commander of the Armed Tender HMS Supply, which was on its way from Botany Bay to found a penal settlement on Norfolk Island. The island was first settled in 1834 when three Englishmen arrived to establish a supply station for whaling ships. The island was governed as part of New South Wales until 1855 when it was officially designated as part of Tasmania. In 1876, the island was placed under the administration of the Governor of New South Wales. The island was declared a UNESCO World Heritage Site in 1982 in recognition of its unique geology and biodiversity.")
          )
        )
      )
    }
    
    # Render UI for Prediction
    else if(input$nav == "Prediction") {
      tabPanel("Prediction", 
               tags$div(
                 h4("Economic Indicators Prediction"),
                 p("This section presents predictions for economic indicators in Lord Howe Island using Linear Regression (LM) and Time Series (TS) models."),
                 
                 h5("Economic Activity Prediction: LM vs Time Series"),
                 plotlyOutput("gdp_combined_plot", height = "400px"),
                 
                 h5("Growth Rate Prediction: LM vs Time Series"),
                 plotlyOutput("growth_combined_plot", height = "400px"),
                 
                 tags$hr(),
                 
                 h5("Growth Rate Comparison: Calculated vs Predicted"),
                 p("This chart compares growth rates derived from predicted economic values (LM and TS) with directly predicted growth rates."),
                 plotlyOutput("combined_growthrate_plot", height = "500px"),
                 
                 tags$ul(
                   tags$li("1. **Different Modeling Approaches**: The calculated Growth Rate is derived from predicted economic values while directly predicted Growth Rate is modeled independently."),
                   tags$li("2. **Error Accumulation**: Calculated Growth Rates are sensitive to errors in the predicted values."),
                   tags$li("3. **Data Characteristics**: Economic data follows a smoother trend while Growth Rate data exhibits more variability."),
                   tags$li("4. **Model Assumptions**: Linear regression assumes linear trends while time series models capture patterns like seasonality."),
                   tags$li("5. **Historical Fluctuations**: Anomalies in historical data influence calculated Growth Rates differently than direct predictions.")
                 )
               )
      )
    }
    
    # Render UI for Comparison
    else if (input$nav == "Comparison"){
      tabPanel("Comparison", 
               tags$div(
                 h4("Comparison Between Pacific Island Regions"),
                 p("This section provides a comparative analysis of key social and economic indicators between Lord Howe Island and similar regions."),
                 
                 # Strengths and Weaknesses Summary
                 tags$div(
                   style = "margin-bottom: 20px; padding: 10px; background-color: #f2f2f2; border: 1px solid #ccc; border-radius: 5px;",
                   h5("Strengths and Weaknesses of Lord Howe Island"),
                   tags$p(
                     "Lord Howe Island stands out in several areas compared to other island regions."
                   ),
                   tags$ul(
                     tags$li(tags$b("Strengths:"),
                             " The island has the highest life expectancy (82.5 years) and HDI (0.895) in the comparison."),
                     tags$li("Tourism contributes a significant portion (75.2%) to its GDP, demonstrating its appeal as an exclusive destination."),
                     tags$li("The island's UNESCO World Heritage status ensures strong environmental protections.")
                   ),
                   tags$ul(
                     tags$li(tags$b("Weaknesses:"),
                             " Limited economic diversity with heavy reliance on tourism."),
                     tags$li("Small population (382) limits local services and infrastructure."),
                     tags$li("Geographic isolation increases costs for goods and services.")
                   )
                 ),
                 
                 # Dropdown menu for selecting comparison indicators
                 selectInput("comparison_type", "Select Indicator Type for Comparison:",
                             choices = c("Social Indicators" = "social", 
                                         "Economic Indicators" = "economic"),
                             selected = "social"),
                 
                 # Comparison Table
                 tableOutput("comparison_table"),
                 
                 tags$hr(),
                 
                 # Flags Section Below Table
                 tags$div(
                   style = "display: flex; justify-content: center; gap: 50px; margin-top: 20px;",
                   
                   # Lord Howe Island Flag
                   tags$div(
                     style = "text-align: center;",
                     tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Lord_Howe_Island_flag.svg/1200px-Lord_Howe_Island_flag.svg.png", 
                              height = "100px", style = "border: 3px solid black;"),
                     tags$p("Lord Howe Island")
                   ),
                   
                   # Norfolk Island Flag
                   tags$div(
                     style = "text-align: center;",
                     tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Flag_of_Norfolk_Island.svg/1200px-Flag_of_Norfolk_Island.svg.png", 
                              height = "100px", style = "border: 3px solid black;"),
                     tags$p("Norfolk Island")
                   ),
                   
                   # Tasmania Flag
                   tags$div(
                     style = "text-align: center;",
                     tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Flag_of_Tasmania.svg/1200px-Flag_of_Tasmania.svg.png", 
                              height = "100px", style = "border: 3px solid black;"),
                     tags$p("Tasmania")
                   ),
                   
                   # New Zealand Flag
                   tags$div(
                     style = "text-align: center;",
                     tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Flag_of_New_Zealand.svg/1200px-Flag_of_New_Zealand.svg.png", 
                              height = "100px", style = "border: 3px solid black;"),
                     tags$p("New Zealand")
                   )
                 )
               )
      )
    }
    
    # Render UI for SWOT Analysis
    else if (input$nav == "SWOT Analysis") {
      tabPanel("SWOT Analysis", 
               tags$div(
                 h3("SWOT Analysis of Lord Howe Island"),
                 p("This section highlights the Strengths, Weaknesses, Opportunities, and Threats related to Lord Howe Island."),
                 tabsetPanel(
                   tabPanel("Strengths",
                            tags$div(
                              h4("Strengths"),
                              p("1. UNESCO World Heritage status recognizing its unique biodiversity and geology."),
                              p("2. Exclusive tourism model with limited visitor numbers ensuring high-value tourism."),
                              p("3. Pristine natural environment with many endemic species."),
                              p("4. Strong community with high quality of life indicators."),
                              tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Lord_Howe_Island_-_view_from_Mt_Gower.jpg/800px-Lord_Howe_Island_-_view_from_Mt_Gower.jpg", 
                                       height = "500px", width = "100%", 
                                       style = "display: block; margin: 10px auto; border-radius: 10px;")
                            )
                   ),
                   tabPanel("Weaknesses",
                            tags$div(
                              h4("Weaknesses"),
                              p("1. Extreme geographic isolation increasing costs and limiting accessibility."),
                              p("2. Very small population limiting services and economic diversity."),
                              p("3. Heavy reliance on tourism making the economy vulnerable to external shocks."),
                              p("4. Limited infrastructure due to environmental protections."),
                              tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Lord_Howe_Island_NASA.jpg/800px-Lord_Howe_Island_NASA.jpg", 
                                       height = "500px", width = "100%", 
                                       style = "display: block; margin: 10px auto; border-radius: 10px;")
                            )
                   ),
                   tabPanel("Opportunities",
                            tags$div(
                              h4("Opportunities"),
                              p("1. Expansion of high-end eco-tourism and scientific research tourism."),
                              p("2. Development of sustainable energy solutions to reduce dependence on imported fuels."),
                              p("3. Increased conservation research partnerships with universities."),
                              p("4. Digital nomad programs leveraging the island's natural beauty."),
                              tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Lord_Howe_Island_02.jpg/800px-Lord_Howe_Island_02.jpg", 
                                       height = "500px", width = "100%", 
                                       style = "display: block; margin: 10px auto; border-radius: 10px;")
                            )
                   ),
                   tabPanel("Threats",
                            tags$div(
                              h4("Threats"),
                              p("1. Climate change impacts including sea level rise and increased storm intensity."),
                              p("2. Invasive species threatening endemic flora and fauna."),
                              p("3. Global economic conditions affecting tourism demand."),
                              p("4. Limited air access with only one small airport."),
                              tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Lord_Howe_Island_ball%27s_pyramid.jpg/800px-Lord_Howe_Island_ball%27s_pyramid.jpg", 
                                       height = "500px", width = "100%", 
                                       style = "display: block; margin: 10px auto; border-radius: 10px;")
                            )
                   )
                 )
               )
      )
    }
    
    # Render UI for Reference
    else if (input$nav == "Reference"){
      tabPanel("Reference", 
               tags$div(
                 h4("References"),
                 p("Below is the list of references used for data, images, and information in this app:"),
                 tags$ul(
                   tags$li(tags$a(href = "https://en.wikipedia.org/wiki/Lord_Howe_Island", "Lord Howe Island - Wikipedia", target = "_blank")),
                   tags$li(tags$a(href = "https://www.lordhoweisland.info/", "Lord Howe Island Official Site", target = "_blank")),
                   tags$li(tags$a(href = "https://whc.unesco.org/en/list/186/", "UNESCO World Heritage Listing", target = "_blank")),
                   tags$li(tags$a(href = "https://www.abs.gov.au/", "Australian Bureau of Statistics", target = "_blank")),
                   tags$li(tags$a(href = "https://www.environment.nsw.gov.au/topics/parks-reserves-and-protected-areas/park-management/lord-howe-island", "NSW Environment Department", target = "_blank")),
                   tags$li(tags$a(href = "https://www.bbc.com/travel/article/20200927-lord-howe-island-australias-secret-paradise", "BBC Travel Feature", target = "_blank")),
                   tags$li(tags$a(href = "https://www.theguardian.com/travel/2020/jan/18/lord-howe-island-australia-travel-guide", "The Guardian Travel Guide", target = "_blank")),
                   tags$li(tags$a(href = "https://www.lhib.nsw.gov.au/", "Lord Howe Island Board", target = "_blank"))
                 )
               )
      )
    }
  })
  
  # Leaflet Map for Lord Howe Island
  output$island_map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$OpenStreetMap.Mapnik, group = "Standard Map") %>%
      addProviderTiles(providers$Esri.WorldImagery, group = "Satellite Map") %>%
      addProviderTiles(providers$Esri.WorldTopoMap, group = "Topo Map") %>%
      setView(lng = 159.085, lat = -31.555, zoom = 12) %>%
      addMarkers(lng = 159.077, lat = -31.524, popup = "Mount Gower (875m)") %>%
      addMarkers(lng = 159.067, lat = -31.535, popup = "Mount Lidgbird (777m)") %>%
      addMarkers(lng = 159.078, lat = -31.538, popup = "Lord Howe Island Airport") %>%
      addMarkers(lng = 159.085, lat = -31.555, popup = "Settlement (Main Village)") %>%
      addLayersControl(
        baseGroups = c("Standard Map", "Satellite Map", "Topo Map"),
        options = layersControlOptions(collapsed = FALSE)
      )
  })
  
  # Leaflet Map for Regional Position
  output$regional_map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$OpenStreetMap.Mapnik) %>%
      setView(lng = 159.085, lat = -31.555, zoom = 5) %>%
      addMarkers(lng = 159.085, lat = -31.555, popup = "Lord Howe Island") %>%
      addMarkers(lng = 151.2093, lat = -33.8688, popup = "Sydney") %>%
      addMarkers(lng = 167.9547, lat = -29.0566, popup = "Norfolk Island") %>%
      addMarkers(lng = 174.7762, lat = -36.8509, popup = "Auckland, NZ")
  })
  
  # Economy Plot
  output$economy_plot <- renderPlotly({
    if (input$economy_plot_choice == "gdp") {
      req(economy_data)
      
      filtered_gdp <- subset(economy_data, Year >= input$gdp_slider[1] & Year <= input$gdp_slider[2])
      
      plot_ly(filtered_gdp, x = ~Year) %>%
        add_bars(y = ~GDP, name = "Economic Activity", marker = list(color = "steelblue")) %>%
        add_lines(y = ~Growth_Rate, name = "Growth Rate (%)", 
                  line = list(color = "red", width = 3), yaxis = "y2") %>%
        layout(title = "Lord Howe Island Economic Indicators",
               xaxis = list(title = "Year"),
               yaxis = list(title = "Economic Activity Index", side = "left"),
               yaxis2 = list(title = "Growth Rate (%)", side = "right", overlaying = "y"),
               barmode = "group")
    } else if (input$economy_plot_choice == "cpi") {
      req(cpi_data)
      
      filtered_cpi <- subset(cpi_data, Year >= input$cpi_slider[1] & Year <= input$cpi_slider[2])
      
      plot_ly(filtered_cpi, x = ~Year) %>%
        add_bars(y = ~CPI, name = "Price Index", marker = list(color = "green")) %>%
        add_lines(y = ~INFLATION, name = "Inflation Rate (%)", 
                  line = list(color = "orange", width = 3), yaxis = "y2") %>%
        layout(title = "Lord Howe Island Price Trends",
               xaxis = list(title = "Year"),
               yaxis = list(title = "Price Index", side = "left"),
               yaxis2 = list(title = "Inflation Rate (%)", side = "right", overlaying = "y"),
               barmode = "group")
    }
  })
  
  output$gdp_combined_plot <- renderPlotly({
    req(economy_data)
    
    # Linear Regression Model
    gdp_lm_model <- lm(GDP ~ Year, data = economy_data)
    future_years <- data.frame(Year = seq(2024, 2030, by = 1))
    gdp_lm_forecast <- predict(gdp_lm_model, newdata = future_years)
    
    # Time Series Forecast
    gdp_ts <- ts(economy_data$GDP, start = min(economy_data$Year), frequency = 1)
    gdp_forecast <- forecast(auto.arima(gdp_ts), h = 7)
    
    # Combine Data
    gdp_combined <- data.frame(
      Year = c(economy_data$Year, future_years$Year),
      Actual_GDP = c(economy_data$GDP, rep(NA, length(future_years$Year))),
      LM_Prediction = c(rep(NA, nrow(economy_data)), gdp_lm_forecast),
      TS_Prediction = c(rep(NA, nrow(economy_data)), gdp_forecast$mean)
    )
    
    # Plot Combined Results
    plot_ly(gdp_combined, x = ~Year) %>%
      add_lines(y = ~Actual_GDP, name = "Actual", line = list(color = "black")) %>%
      add_lines(y = ~LM_Prediction, name = "LM Prediction", line = list(color = "blue", dash = "dot")) %>%
      add_lines(y = ~TS_Prediction, name = "TS Prediction", line = list(color = "red", dash = "solid")) %>%
      layout(title = "Economic Activity Predictions: LM vs Time Series",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Economic Activity Index"))
  })
  
  # Growth Rate Predictions: Combined LM and TS
  output$growth_combined_plot <- renderPlotly({
    req(economy_data)
    
    # Linear Regression Model
    growth_lm_model <- lm(Growth_Rate ~ Year, data = economy_data)
    future_years <- data.frame(Year = seq(2024, 2030, by = 1))
    growth_lm_forecast <- predict(growth_lm_model, newdata = future_years)
    
    # Time Series Forecast
    growth_ts <- ts(economy_data$Growth_Rate, start = min(economy_data$Year), frequency = 1)
    growth_forecast <- forecast(auto.arima(growth_ts), h = 7)
    
    # Combine Data
    growth_combined <- data.frame(
      Year = c(economy_data$Year, future_years$Year),
      Actual_Growth = c(economy_data$Growth_Rate, rep(NA, length(future_years$Year))),
      LM_Prediction = c(rep(NA, nrow(economy_data)), growth_lm_forecast),
      TS_Prediction = c(rep(NA, nrow(economy_data)), growth_forecast$mean)
    )
    
    # Plot Combined Results
    plot_ly(growth_combined, x = ~Year) %>%
      add_lines(y = ~Actual_Growth, name = "Actual Growth Rate", line = list(color = "black")) %>%
      add_lines(y = ~LM_Prediction, name = "LM Prediction", line = list(color = "blue", dash = "dot")) %>%
      add_lines(y = ~TS_Prediction, name = "TS Prediction", line = list(color = "red", dash = "solid")) %>%
      layout(title = "Growth Rate Predictions: LM vs Time Series",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Growth Rate (%)"))
  })
  
  # Combined Growth Rate Plot
  output$combined_growthrate_plot <- renderPlotly({
    req(economy_data)
    
    # 1. LM Model for GDP Prediction
    gdp_lm_model <- lm(GDP ~ Year, data = economy_data)
    future_years <- data.frame(Year = seq(2024, 2030, by = 1))
    gdp_lm_forecast <- predict(gdp_lm_model, newdata = future_years)
    
    # 2. Time Series Model for GDP Prediction
    gdp_ts <- ts(economy_data$GDP, start = min(economy_data$Year), frequency = 1)
    gdp_ts_forecast <- forecast(auto.arima(gdp_ts), h = 7)$mean
    
    # 3. Calculate Growth Rate from LM-predicted GDP
    gdp_lm_combined <- c(tail(economy_data$GDP, 1), gdp_lm_forecast)
    lm_growth_calculated <- diff(gdp_lm_combined) / head(gdp_lm_combined, -1) * 100
    
    # 4. Calculate Growth Rate from TS-predicted GDP
    gdp_ts_combined <- c(tail(economy_data$GDP, 1), gdp_ts_forecast)
    ts_growth_calculated <- diff(gdp_ts_combined) / head(gdp_ts_combined, -1) * 100
    
    # 5. Directly Predicted Growth Rates
    growth_lm_model <- lm(Growth_Rate ~ Year, data = economy_data)
    growth_lm_forecast <- predict(growth_lm_model, newdata = future_years)
    
    growth_ts <- ts(economy_data$Growth_Rate, start = min(economy_data$Year), frequency = 1)
    growth_ts_forecast <- forecast(auto.arima(growth_ts), h = 7)$mean
    
    # 6. Combine All Results
    combined_growth <- data.frame(
      Year = future_years$Year,
      LM_Growth_Calculated = lm_growth_calculated,
      TS_Growth_Calculated = ts_growth_calculated,
      LM_Growth_Predicted = growth_lm_forecast,
      TS_Growth_Predicted = growth_ts_forecast
    )
    
    # 7. Plot All Four Growth Rates
    plot_ly(combined_growth, x = ~Year) %>%
      add_lines(y = ~LM_Growth_Calculated, name = "LM Growth (from Economic Activity)", 
                line = list(color = "blue", dash = "solid")) %>%
      add_lines(y = ~TS_Growth_Calculated, name = "TS Growth (from Economic Activity)", 
                line = list(color = "red", dash = "solid")) %>%
      add_lines(y = ~LM_Growth_Predicted, name = "LM Predicted Growth", 
                line = list(color = "blue", dash = "dot")) %>%
      add_lines(y = ~TS_Growth_Predicted, name = "TS Predicted Growth", 
                line = list(color = "red", dash = "dot")) %>%
      layout(title = "Growth Rate Comparison: Calculated vs Predicted",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Growth Rate (%)"))
  })
  
  # Render comparison table
  output$comparison_table <- renderTable({
    req(input$comparison_type)
    comparison_data[[input$comparison_type]]
  }, striped = TRUE, bordered = TRUE, hover = TRUE, align = "c")
}

# Run App
shinyApp(ui, server)