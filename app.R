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

#gs4_auth(cache = ".secrets")
gs4_auth(cache = ".secrets",
         email = TRUE,
         use_oob = TRUE)

source('myUI.R')
source('myServer.R')

shinyApp(ui = myUI,
         server = myserver)