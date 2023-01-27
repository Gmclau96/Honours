#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(rgdal)
library(broom)
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggiraph)
library(googlesheets4)

source('myUI.R', local = TRUE)
source('myServer.R')


shinyApp(ui = myUI,
         server = myserver)