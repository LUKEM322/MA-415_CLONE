library(readxl)
library(writexl)

excel_path <- "Data/Lord_Howe_Data.xlsx"  

sheet_names <- excel_sheets(excel_path)

# Loop through each sheet and save it as a CSV file
for (sheet in sheet_names) {
  data <- read_excel(excel_path, sheet = sheet)
  file_name <- paste0(sheet, ".csv")
  write.csv(data, file = file_name, row.names = FALSE)
}

library(ggplot2)
library(dplyr)
library(esquisse)

path <- "Data/Lord_Howe_Data.xlsx"

pop_years <- 2018:2023
pop_values <- as.numeric(pop[pop$`Measure code` == "ERP_P_20", 7:12])

pop_df <- data.frame(
  Year = pop_years,
  Population = pop_values
)

# Plot and save separately
pop_plot <- ggplot(pop_df, aes(x = Year, y = Population)) +
  geom_line(color = "steelblue", linewidth = 1.2) +
  geom_point() +
  theme_minimal() +
  ggtitle("Estimated Resident Population (2016–2023)")
pop_plot

ggsave("population_growth.png", plot = pop_plot, width = 8, height = 5)

inc <- read_excel(path, sheet = "INC", skip = 2)

income_total <- as.numeric(inc[inc$`Measure code` == "INCOME_3", 5:8]) * 1e6
income_earners <- as.numeric(inc[inc$`Measure code` == "INCOME_4", 5:8])

median_income <- income_total / income_earners
income_df <- data.frame(
  Year = 2016:2019,
  MedianIncome = median_income
)

ggplot(income_df, aes(x = Year, y = MedianIncome)) +
  geom_line(color = "darkgreen", size = 1.2) +
  geom_point() +
  theme_minimal() +
  ggtitle("Estimated Median Employee Income (2016–2019)") +
  ylab("Income ($AUD)")
  
ggsave("median_income.png", width = 8, height = 5)

library(kableExtra)
POP <- read_csv("Data/POP.csv")
POP
selected_rows <- POP %>%
  filter(POP[[3]] %in% c(
    "Estimated resident population (no.)",
    "Population density (persons/km2)",
    "Estimated resident population - males (no.)",
    "Estimated resident population - females (no.)",
    "Median age - males (years)",
    "Median age - females (years)",
    "Median age - persons (years)",
    "Working age population (aged 15-64 years) (no.)",
    "Working age population (aged 15-64 years) (%)"
  ))

filtered_rows <- selected_rows %>%
  select(-1, -2, -4, -5, -6)  

filtered_rows %>%
  kable("html", caption = "Selected Population Data") %>%
  kable_styling(bootstrap_options = c("striped", "hover"))

colnames(filtered_rows) <- c("Description", "2018", "2019", "2020", "2021", "2022", "2023")

filtered_rows %>%
  kable("html", caption = "Selected Population Data") %>%
  kable_styling(bootstrap_options = c("striped", "hover")) %>%
  save_kable("Data/population_data_table.html")

ECON <- read_csv("Data/ECON.csv")
ECON

ECON_filtered <- ECON %>%
  filter(ECON[[2]] == "Industry of employment - Persons aged 15 years and over - Census")
ECON_filtered

selected_rows <- ECON_filtered %>%
  select(-1,-2,-4,-5,-6,-7,-8,-9,-11,-12,-13)
colnames(selected_rows) <- c("Description", "2021")
selected_rows %>%
  kable("html", caption = "Industry of employment Data") %>%
  kable_styling(bootstrap_options = c("striped", "hover"))


IOEG <-ggplot(selected_rows %>%
         filter(selected_rows[[1]] != "Total persons employed aged 15 years and over (no.)", !is.na(`2021`)),
      aes(x = reorder(Description, `2021`), y = `2021`)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  coord_flip() +  # Flip the chart for better readability
  labs(title = "Industry of Employment - 2021",
       x = "Industry",
       y = "Percentage of Employment (%)") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 8))

ggsave("Industry_of_Employment.png", plot = IOEG, width = 8, height = 5)


