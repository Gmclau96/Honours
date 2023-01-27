constituencies <- c(
  read_sheet(
    "https://docs.google.com/spreadsheets/d/1XayqjKFVilKgFuSW23LqtNN7Kv3Uexpvzwx2CVKz6Bc/edit#gid=0",
    range = "C2:C60",
    col_names = FALSE
  )
)
Tab1 <-
  tabPanel(
    "Information",
    verticalLayout(
      h2("What is the purpose of this site"),
      (
        "This website is a university project to gauge if there is a correlation between data visualisation and influencing electoral turnout in Scotland"
      ),
      h2("How to use this website"),
      (
        "There are three different general elections that you can choose to view, 2019, 2017 and 2015 which are all viewable from the respective links at the top of the page. From there you are shown a map of Scotland, colour coded by what each constituency voted for. You can hover your mouse, or tap on your screen on a constituency to reveal more information. Below this map is a table of election data. The side menu on the left of your screen gives you the option to view each scottish constituency individually for each election. Clicking this will change the map below to highlight what constituency you have chosen from the menu. This will also change the main map and table to show that one constituency. This can be changed back at anytime by selecting Scotland from the menu. Information may take a moment to load, so please be patient while the website fetches the information."
      ),
      h2("Register to vote"),
      ("If you have not done so already, you can register to vote at"),
      a(
        href = "https://www.gov.uk/register-to-vote",
        "https://www.gov.uk/register-to-vote",
        target = "_blank"
      ),
      h2("Manifestos and party information"),
      (
        "Listed below in alphabetical order are the 4 parties that had a seat in the last 3 general elections in Scotland. Here you can find information on them and thier manifestos. There are more parties to vote for other than these which can be found at"
      ),
      p(
        a(
          href = "https://www.parliament.uk/about/mps-and-lords/members/parties/",
          "https://www.parliament.uk/about/mps-and-lords/members/parties/",
          target = "_blank"
        )
      ),
      p(strong("The Conservative Party:")),
      a(
        href = "https://www.scottishconservatives.com",
        "https://www.scottishconservatives.com",
        target = "_blank"
      ),
      ("Policies and manifestos:"),
      p(
        a(
          href = "https://www.scottishconservatives.com/policy-area/",
          "https://www.scottishconservatives.com/policy-area/",
          target = "_blank"
        )
      ),
      p(strong("The Labour Party:")),
      a(
        href = "https://scottishlabour.org.uk",
        "https://scottishlabour.org.uk",
        target = "_blank"
      ),
      ("Policies and manifestos:"),
      p(
        a(
          href = "https://scottishlabour.org.uk/where-we-stand/",
          "https://scottishlabour.org.uk/where-we-stand/",
          target = "_blank"
        )
      ),
      p(strong("The Liberal Democrats:")),
      a(
        href = "https://www.scotlibdems.org.uk",
        "https://www.scotlibdems.org.uk",
        target = "_blank"
      ),
      ("Policies and manifestos:"),
      p(
        a(
          href = "https://www.scotlibdems.org.uk/about-us/our-policy",
          "https://www.scotlibdems.org.uk/about-us/our-policy",
          target = "_blank"
        )
      ),
      p(strong("The Scottish National Party:")),
      a(href = "https://www.snp.org", "https://www.snp.org", target =
          "_blank"),
      ("Policies and manifestos:"),
      a(
        href = "https://www.snp.org/policies/",
        "https://www.snp.org/policies/",
        target = "_blank"
      )
    )
  )
Tab2 <-   tabPanel("2019",
                   sidebarLayout(
                     sidebarPanel(
                       selectInput(
                         inputId = "nineteen",
                         label = "Choose a constituency",
                         selected = "Scotland",
                         choices = c("Scotland", constituencies)
                       ),
                       plotOutput("selected2019")
                     ),
                     mainPanel(girafeOutput("scotland_map2019"), tableOutput("table19"))
                   ))
Tab3 <- tabPanel("2017",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput(
                       inputId = "seventeen",
                       label = "Choose a constituency",
                       selected = "Scotland",
                       choices = c("Scotland", constituencies)
                     ),
                     plotOutput("selected2017")
                   ),
                   mainPanel(girafeOutput("scotland_map2017"), tableOutput("table17"))
                 ))
Tab4 <- tabPanel("2015",
                 sidebarLayout(
                   sidebarPanel(
                     selectInput(
                       inputId = "fifteen",
                       label = "Choose a constituency",
                       selected = "Scotland",
                       choices = c("Scotland", constituencies)
                     ),
                     plotOutput("selected2015")
                   ),
                   mainPanel(girafeOutput("scotland_map2015"), tableOutput("table15"))
                 ))
