library(leaflet)

beaches <- data.frame(
  name = c("Ned's Beach", "Blinky Beach", "Lagoon Beach", "Old Settlement Beach", 
           "Middle Beach", "Lovers Bay", "North Bay", "Cobbys Corner"),
  lat = c(-31.5132, -31.5363, -31.5403, -31.5289, 
          -31.5308, -31.5546, -31.5175, -31.5514),
  lng = c(159.0679, 159.0825, 159.0577, 159.0520, 
          159.0731, 159.0739, 159.0645, 159.0578),
  description = c(
    "Famous for fish feeding and snorkeling. Crystal clear waters with colorful fish that can be hand-fed.",
    "Known for surfing and body boarding. Beautiful white sand beach on the eastern side of the island.",
    "The main beach on the western side with calm waters perfect for swimming and kayaking.",
    "A sheltered beach where turtles are often spotted in the shallows.",
    "A secluded beach on the eastern side with dramatic cliffs.",
    "A small, secluded beach with beautiful sunset views.",
    "Accessible only by boat or walking track, offering excellent snorkeling.",
    "Great spot for families with safe swimming areas."
  )
)

beach_icons <- awesomeIcons(
  icon = 'umbrella-beach',
  iconColor = 'black',
  library = 'fa',
  markerColor = 'blue'
)

beach_map <- leaflet(beaches) %>%
  # Add base tile layers with options to switch between them
  addProviderTiles(providers$Esri.WorldImagery, group = "Satellite") %>%
  addProviderTiles(providers$OpenStreetMap, group = "Street Map") %>%
  addProviderTiles(providers$Stamen.Terrain, group = "Terrain") %>%
  
  # Set the initial view to cover all of Lord Howe Island
  setView(lng = 159.0650, lat = -31.5350, zoom = 13) %>%
  
  # Add markers for each beach with popups
  addAwesomeMarkers(
    ~lng, ~lat,
    icon = beach_icons,
    label = ~name,
    popup = ~paste("<strong>", name, "</strong><br>", description)
  ) %>%
  
  addScaleBar(position = "bottomleft") %>%

  addLegend(
    position = "bottomright",
    colors = "blue",
    labels = "Beaches",
    opacity = 0.7
  ) %>%
  
  addLayersControl(
    baseGroups = c("Satellite", "Street Map", "Terrain"),
    options = layersControlOptions(collapsed = FALSE)
  )

beach_map
