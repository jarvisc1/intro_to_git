
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


# Define and save the vector
ebola_weeks <- seq.Date(
  from = floor_date(min(combined$date_onset, na.rm=T), unit = "week", week_start = 1),
  to =   ceiling_date(max(combined$date_onset, na.rm=T), unit = "week", week_start = 1),
  by =   "week")


fig_epicurve_all_caption <- stringr::str_glue("{nrow(combined)} confirmed cases; ",
                                              "Onsets range from {format(min_date_onset, format = '%a %d %b %Y')}",
                                              " to ",
                                              "{format(max_date_onset, format = '%a %d %b %Y')}. ",
                                              "{nrow(combined %>% filter(is.na(date_onset)))} ",
                                              "missing date of onset and not shown")


# Make epidemic curve
fig_epicurve_all <- ggplot(data = combined)+
  geom_histogram(
    mapping = aes(x = date_onset),
    breaks = ebola_weeks,
    closed = "left")+
  
  # x-axis labels
  scale_x_date(
    expand            = c(0,0),           # remove excess x-axis space before and after case bars
    date_breaks       = "4 weeks",        # date labels and major vertical gridlines appear every 3 Monday weeks
    date_minor_breaks = "week",           # minor vertical lines appear every Monday week
    labels = scales::label_date_short())+ # automatically efficient date labels
  
  # y-axis
  scale_y_continuous(
    expand = c(0,0))+             # remove excess y-axis space below 0 (align histogram flush with x-axis)
  
  # aesthetic themes
  theme_minimal()+                # simplify plot background
  
  theme(
    plot.caption = element_text(hjust = 0,        # caption on left side
                                face = "italic"), # caption in italics
    axis.title = element_text(face = "bold"))+    # axis titles in bold
  
  # labels including dynamic caption
  labs(
    title    = "Weekly incidence of cases (Monday weeks)",
    subtitle = "",
    x        = "Week of symptom onset",
    y        = "Weekly incident cases reported",
    caption  = fig_epicurve_all_caption)

