source('Tabs.R')
myUI <- shinyUI({
  fluidPage(navbarPage("Scottish election visualisation", id = "navbar",
                       
                       Tab1,
                       Tab2,
                       Tab3,
                       Tab4))
})