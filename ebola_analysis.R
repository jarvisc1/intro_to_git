
library(here)
library(rio)
library(apyramid)
library(ggplot2)




# Load in data ------------------------------------------------------------

combined <- import(here("data", "linelist_combined_20141201.rds"))



# Create age sex pyramid --------------------------------------------------

fig_agesex_all <- age_pyramid(
  data = combined,
  age_group = "age_cat",
  split_by = "sex",
  proportional = TRUE,
  show_midpoint = FALSE)+
  
  theme_minimal()+
  
  scale_fill_brewer(type = "qual", palette = 2)+
  
  labs(title = "RAge and sex of confirmed cases",
       x = "Proportion of all cases",
       y = "Age group") +
  theme(
    plot.caption = element_text(hjust = 0) # Center align the caption
  )

## Print figure
fig_agesex_all






