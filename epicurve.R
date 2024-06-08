## Epicurve


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
    y        = "Weekly incident cases reported"
  )
