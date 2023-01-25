constituencies <- c(
  read_excel(
    "/Users/gordonmclaughlin/Library/CloudStorage/OneDrive-GLASGOWCALEDONIANUNIVERSITY/uni/4th year/Honours/election Csv/Honors master csv.xlsx",
    sheet = 3,
    range = "C2:C60",
    col_names = FALSE
  )
)

Tab1 <-   tabPanel("2019",
                   sidebarLayout(sidebarPanel(
                     selectInput(
                       inputId = "nineteen",
                       label = "Choose a constituency",
                       selected = "Scotland",
                       choices = c("Scotland", constituencies)
                     ), plotOutput("selected2019")
                   ),
                   mainPanel(girafeOutput("scotland_map2019"), tableOutput("table19"))))
Tab2 <- tabPanel("2017",
                 sidebarLayout(sidebarPanel(
                   selectInput(
                     inputId = "seventeen",
                     label = "Choose a constituency",
                     selected = "Scotland",
                     choices = c("Scotland", constituencies)
                   )
                 ),
                 mainPanel(girafeOutput("scotland_map2017"), tableOutput("table17"))))
Tab3 <- tabPanel("2015",
                 sidebarLayout(sidebarPanel(
                   selectInput(
                     inputId = "fifteen",
                     label = "Choose a constituency",
                     selected = "Scotland",
                     choices = c("Scotland", constituencies)
                   )
                 ),
                 mainPanel(girafeOutput("scotland_map2015"), tableOutput("table15"))))