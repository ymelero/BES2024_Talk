################################
##### This script generates species performance plots for globally and locally adapted species 
##### in relation to climatic anomalies.
################################

# Load required libraries
library(tidyverse)    # For data manipulation and visualization
library(ggplot2)      # For creating plots
library(ggnewscale)   # For adding multiple color scales in ggplot2

# -------------------------------
# Global Adapted Species: Ochlodes sylvanus
# -------------------------------

# Load the residuals data for Ochlodes sylvanus
Osylvanys <- read.csv("Data/O_sylvanus.csv", sep = ",")

# Load the predicted data for Ochlodes sylvanus
predicted <- read.delim2("Data/O_sylvanus_predicted.txt", sep = ";")

# Convert the first 5 columns of the predicted dataset to numeric
predicted <- predicted %>%
  mutate(across(c(1:5), as.numeric))

# Create a scatter plot for residuals vs local anomaly
Os_pts <- ggplot(data = Osylvanys, aes(y = resid, x = local.anomaly)) +
  theme_bw() +                                          # Apply a black-and-white theme
  theme(legend.position = "none",                       # Remove the legend
        panel.grid.minor = element_blank(),             # Remove minor grid lines
        panel.border = element_blank(),                 # Remove the panel border
        axis.line = element_line(colour = "black")) +   # Add black axis lines
  geom_point(aes(colour = res.color), alpha = 0.3) +   # Plot points with transparency
  scale_colour_identity(name = "points") +              # Use color directly from the data
  ylim(c(-2, 2.2)) +                                    # Set y-axis limits
  xlim(c(-3, 4))                                        # Set x-axis limits

# Add predicted lines to the scatter plot
Os_plt <- Os_pts +
  new_scale_color() +                                   # Add a new color scale for the lines
  geom_line(predicted, mapping = aes(x, predicted, colour = group), size = 0.5) +  # Plot predicted lines
  scale_color_manual(name = "lines", values = rev(c(   # Define a custom color palette
    "#FF0000FF", "#FF0000FF", "#FF2A00FF", "#FF5500FF", "#FF8000FF", "#FFAA00FF",
    "#FFD500FF", "#FFFF00FF", "#FFFF40FF", "#FFFFBFFF", "#FFFFBFFF", "#F7FBFF",
    "#DEEBF7", "#C6DBEF", "#9ECAE1", "#6BAED6", "#4292C6", "#2171B5", "#08519C",
    "#08306B", "#08306B"))) +
  annotate("text", x = -7, y = 2.2, label = expression(italic("Ochlodes sylvanus")), vjust = 0.3, hjust = 0) +  # Add species label
  ylab("Population change") +                           # Add y-axis label
  xlab("Climatic anomaly of the year") +                # Add x-axis label
  theme_bw() +                                          # Apply black-and-white theme again
  theme(legend.position = "none",                       # Remove the legend
        panel.grid.minor = element_blank(),             # Remove minor grid lines
        panel.grid = element_blank(),                   # Remove major grid lines
        panel.border = element_blank(),                 # Remove panel border
        axis.line = element_line(colour = "black"))     # Add black axis lines

# Display the plot
Os_plt

# -------------------------------
# Local Adapted Species: Brenthis ino
# -------------------------------

# Load the residuals data for Brenthis ino
Bino <- read.csv("Data/B_ino.csv", sep = ",")

# Load the predicted data for Brenthis ino
predictedB <- read.csv("Data/B_ino_predicted.csv")

# Ensure the 'group' column is a character type
predictedB$group <- as.character(predictedB$group)

# Create a scatter plot for residuals vs local anomaly
B_pts <- ggplot(data = Bino, aes(y = resid, x = local.anomaly)) +
  theme_bw() +                                          # Apply a black-and-white theme
  theme(legend.position = "none",                       # Remove the legend
        panel.border = element_blank(),                 # Remove the panel border
        axis.line = element_line(colour = "black")) +   # Add black axis lines
  geom_point(aes(colour = res.color), alpha = 0.3) +   # Plot points with transparency
  scale_colour_identity(name = "points") +              # Use color directly from the data
  ylim(c(-2, 2.2)) +                                    # Set y-axis limits
  xlim(c(-7, 3))                                        # Set x-axis limits

# Add predicted lines to the scatter plot
B_plt <- B_pts +
  new_scale_color() +                                   # Add a new color scale for the lines
  geom_line(predictedB, mapping = aes(x, predicted, colour = group), size = 0.5) +  # Plot predicted lines
  scale_color_manual(name = "lines", values = rev(c(   # Define a custom color palette
    "#FF0000FF", "#FF0000FF", "#FF2A00FF", "#FF5500FF", "#FF8000FF", "#FFAA00FF",
    "#FFD500FF", "#FFFF00FF", "#FFFF40FF", "#FFFFBFFF", "#FFFFBFFF", "#F7FBFF",
    "#DEEBF7", "#C6DBEF", "#9ECAE1", "#6BAED6", "#4292C6", "#2171B5", "#08519C",
    "#08306B", "#08306B"))) +
  annotate("text", x = -7, y = 2.2, label = expression(italic("Brenthis ino")), vjust = 0.3, hjust = 0) +  # Add species label
  ylab("Population change") +                           # Add y-axis label
  xlab("Climatic anomaly of the year") +                # Add x-axis label
  theme_bw() +                                          # Apply black-and-white theme again
  theme(legend.position = "none",                       # Remove the legend
        panel.grid.minor = element_blank(),             # Remove minor grid lines
        panel.grid = element_blank(),                   # Remove major grid lines
        panel.border = element_blank(),                 # Remove panel border
        axis.line = element_line(colour = "black"))     # Add black axis lines

# Display the plot
B_plt
