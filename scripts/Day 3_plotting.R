library(ggplot2)

plt <- ggplot (
  data = surveys_complete,
  mapping = aes(x = weight, y = hindfoot_length)
)

str(plt) # We see that no layers where added

# Add layers by adding via +
plt +
  geom_point() +
  ggtitle("My first plot")

# More elaborated
plt <- ggplot(data = surveys_complete, 
              mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point()

# Additions to plt
plt +
  ggtitle("Weight vs hindfoot length")

# Install and import new package
install.packages("hexbin")
library(hexbin)

# Better distribution of dots in respect to dot density
ggplot(data = surveys_complete,  mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_hex()

# Improvement of plot
plt_blue <- ggplot(data = surveys_complete, 
                   mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.1, color = "blue") # Influence transparency of dots

plt_species_id <- ggplot(data = surveys_complete, 
                         mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point(alpha = 0.1, aes(color = species_id)) 

plt_more <- ggplot(data = surveys_complete, 
                   mapping = aes(
                     x = weight, 
                     y = hindfoot_length,
                     color = species_id)) +
  geom_point(alpha = 0.25)

# Challenge 
ggplot(data = surveys_complete, 
       mapping = aes(
         x = species_id, 
         y = weight,
         color = plot_type)) +
  geom_point()

# Boxplots for better plots
ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y = weight,)) +
  geom_boxplot()

# Combining boxplots and dotplots
ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y = weight,)) +
  geom_boxplot(outlier.shape = NA) + # do not show outlier dots
  geom_jitter(alpha = 0.1, color = "salmon") # Adding a little value for each x coordinate

# Change order of plots in layers 
ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y = weight,)) +
  geom_jitter(alpha = 0.1, color = "salmon") + 
  geom_boxplot(outlier.shape = NA, fill = NA)  

# Challenge
ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y = weight)) +
  geom_violin() +  # Make violin plot
  scale_y_log10() +  # Transform scale
  ylab("Weight log10")

# Challenge: Make a boxplot + jittered scatterplot of hindfoot_length by species_id. Boxplot should be in front of dots
# and filled with white

ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y = hindfoot_length)) +
  geom_jitter(alpha = 0.1, color = "aquamarine3") + # Take alternatively rgb()
  geom_boxplot(outlier.shape = NA) 

ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y = hindfoot_length)) +
  geom_jitter(alpha = 0.1, aes(color = plot_id)) + 
  geom_boxplot(outlier.shape = NA) 

ggplot(
  data = surveys_complete, 
  mapping = aes(
    x = species_id, 
    y = hindfoot_length)) +
  geom_jitter(alpha = 0.1, aes(color = factor(plot_id))) +  # Change color per specied_id by making a factor (with levels)
  geom_boxplot(outlier.shape = NA) 

# Make some new plots
yearly_count <- surveys_complete %>% 
  count(year, genus)

ggplot(data = yearly_count, 
       mapping = aes(
         x = year, 
         y = n, 
         color = genus)) +
  geom_line()

# Using pipeline and ggplot function together
yearly_count %>% 
  ggplot(mapping = aes(
    x = year, 
    y = n, 
    color = genus)) +
  geom_line()

yearly_count_graph <- surveys_complete %>% 
  count(year, genus) %>% 
  ggplot(mapping = aes(x = year, y = n, color = genus))+
  geom_line()

# Facetting: Creating a matrix of plots
surveys_complete %>% 
  count(year, genus, sex) %>% 
  ggplot(mapping = aes(
    x = year,
    y = n,
    color = sex
  )) +
  geom_line() +
  facet_wrap(facets = vars(genus))
 
#Changing layout and display of matrix
surveys_complete %>% 
  count(year, genus, sex) %>% 
  ggplot(mapping = aes(
    x = year,
    y = n,
    color = sex
  )) +
  geom_line() +
  facet_grid(
    rows = vars(sex),
    cols = vars(genus))
  

surveys_complete %>% 
  count(year, genus, sex) %>% 
  ggplot(mapping = aes(
    x = year,
    y = n,
    color = sex
  )) +
  geom_line() +
  facet_grid(
    rows = vars(genus),    # This does not to be specified mandatorily! e.g. cols = vars(genus)
    )

# Themes
plt <- surveys_complete %>% 
  count(year, genus, sex) %>% 
  ggplot(mapping = aes(
    x = year,
    y = n,
    color = sex
  )) +
  geom_line() +
  facet_wrap(facets = vars(genus)) +
  xlab("Year of observation")+
  ylab("Number of individuals")+
  ggtitle("Observed genera over time")+
theme_bw(base_size = 18)  +                  #Theme, presentation size 18
  theme(
    legend.position = "bottom",  # Removal via "none"
        aspect.ratio = 1,
        axis.text.x = element_text(angle = 45,
        hjust = 1) , #vjust
    plot.title = element_text(hjust = 0.5),
    panel.grid = element_blank())

plt
ggsave(filename = "data/plot3.pdf",            # Saves current plot to dis
       plot = plt,
       width = 20,
       height = 20)                                        



