myserver <- function(input, output, session) {
  #read shapefiles
  Constituencies <-
    readOGR(dsn = "/Users/gordonmclaughlin/Library/CloudStorage/OneDrive-GLASGOWCALEDONIANUNIVERSITY/uni/4th year/Honours/shapefiles/New folder",
            layer = "westminster_const_region")
  
  #tidy shapeframe to dataframe
  Constituencies_tidy <- tidy(Constituencies)
  
  #add back data
  Constituencies$id <- row.names(Constituencies)
  Constituencies_tidy <-
    left_join(Constituencies_tidy, Constituencies@data)
  
  #remove suffix on certain constituencies
  Constituencies_tidy$NAME <-
    gsub(' Co Const', '', Constituencies_tidy$NAME)
  Constituencies_tidy$NAME <-
    gsub(' Boro Const', '', Constituencies_tidy$NAME)
  Constituencies_tidy$NAME <-
    gsub(' Burgh Const', '', Constituencies_tidy$NAME)
  
  #rename column name to constituancy_name
  Constituencies_tidy <- Constituencies_tidy %>%
    rename(constituency_name = NAME)
  #read electoral data to dataframe
  election_stats15 <- read_sheet(
    "https://docs.google.com/spreadsheets/d/1XayqjKFVilKgFuSW23LqtNN7Kv3Uexpvzwx2CVKz6Bc/edit#gid=0",
    sheet = 1
  )
  election_stats17 <- read_sheet(
    "https://docs.google.com/spreadsheets/d/1XayqjKFVilKgFuSW23LqtNN7Kv3Uexpvzwx2CVKz6Bc/edit#gid=1279722934",
    sheet = 2
  )
  election_stats19 <- read_sheet(
    "https://docs.google.com/spreadsheets/d/1XayqjKFVilKgFuSW23LqtNN7Kv3Uexpvzwx2CVKz6Bc/edit#gid=1542284684",
    sheet = 3
  )
  
  #drop unnecessary columns
  Constituencies_tidy <- Constituencies_tidy[,-c(3:5, 7, 9:22)]
  
  #combine dataframes
  Constituencies_tidy19 <-
    left_join(Constituencies_tidy, election_stats19, by = "constituency_name")
  Constituencies_tidy17 <-
    left_join(Constituencies_tidy, election_stats17, by = "constituency_name")
  Constituencies_tidy15 <-
    left_join(Constituencies_tidy, election_stats15, by = "constituency_name")
  
  #Remove all but scottish data
  Constituencies_tidy19 <-
    subset(Constituencies_tidy19,
           country_name == 'Scotland')
  Constituencies_tidy17 <-
    subset(Constituencies_tidy17,
           country_name == 'Scotland')
  Constituencies_tidy15 <-
    subset(Constituencies_tidy15,
           country_name == 'Scotland')
  
  #remove suffixes from result
  Constituencies_tidy19$result <-
    gsub(' .*', '', Constituencies_tidy19$result)
  Constituencies_tidy17$result <-
    gsub(' .*', '', Constituencies_tidy17$result)
  Constituencies_tidy15$result <-
    gsub(' .*', '', Constituencies_tidy15$result)
  #add constituency info column and remove unrequired columns (first and surnames)
  Constituencies_tidy19 <- Constituencies_tidy19 %>%
    mutate(
      constituency_info = paste(
        constituency_name,
        "\n",
        "MP",
        mp_firstname,
        mp_surname,
        "\n",
        "Result",
        result
      )
    )
  Constituencies_tidy17 <- Constituencies_tidy17 %>%
    mutate(
      constituency_info = paste(
        constituency_name,
        "\n",
        "MP",
        mp_firstname,
        mp_surname,
        "\n",
        "Result",
        result
      )
    )
  Constituencies_tidy15 <- Constituencies_tidy15 %>%
    mutate(
      constituency_info = paste(
        constituency_name,
        "\n",
        "MP",
        mp_firstname,
        mp_surname,
        "\n",
        "Result",
        result
      )
    )
  #filter reactive variables
  filterConst19 <- reactive({
    if (input$nineteen == "Scotland") {
      filter(Constituencies_tidy19, country_name == 'Scotland')
    } else {
      filter(Constituencies_tidy19,
             constituency_name == input$nineteen)
    }
  })
  filterConst17 <- reactive({
    if (input$seventeen == "Scotland") {
      filter(Constituencies_tidy17, country_name == 'Scotland')
    } else {
      filter(Constituencies_tidy17,
             constituency_name == input$seventeen)
    }
  })
  
  filterConst15 <- reactive({
    if (input$fifteen == "Scotland") {
      filter(Constituencies_tidy15, country_name == 'Scotland')
    } else {
      filter(Constituencies_tidy15,
             constituency_name == input$fifteen)
    }
  })
  
  #create new dataframe with key election info for viewing & make reactive
  election15_tidy <- election_stats15[,-c(1:2, 4:8, 11, 13, 19:32)]
  election15_tidy <- election15_tidy %>%
    mutate(MP = paste(mp_firstname,
                      mp_surname))
  election15_tidy <- election15_tidy [,-c(2:3)]
  election15_tidy <-
    election15_tidy %>% relocate(MP, .before = result)
  election15_tidy <- election15_tidy %>% rename(
    "Constituency" = "constituency_name",
    "Result" = "result",
    "Second Party" = "second_party",
    "Electorate" = "electorate",
    "Valid Votes" = "valid_votes",
    "Invalid Votes" = "invalid_votes",
    "Majority" = "majority"
  )
  tableConst15 <- reactive({
    if (input$fifteen == "Scotland") {
      election15_tidy
    } else {
      election15_tidy <-
        filter(election15_tidy, constituency_name == input$fifteen)
    }
  })
  election17_tidy <- election_stats17[,-c(1:2, 4:8, 11, 13, 19:32)]
  election17_tidy <- election17_tidy %>%
    mutate(MP = paste(mp_firstname,
                      mp_surname))
  election17_tidy <- election17_tidy [,-c(2:3)]
  election17_tidy <-
    election17_tidy %>% relocate(MP, .before = result)
  election17_tidy <- election17_tidy %>% rename(
    "Constituency" = "constituency_name",
    "Result" = "result",
    "Second Party" = "second_party",
    "Electorate" = "electorate",
    "Valid Votes" = "valid_votes",
    "Invalid Votes" = "invalid_votes",
    "Majority" = "majority"
  )
  tableConst17 <- reactive({
    if (input$seventeen == "Scotland") {
      election17_tidy
    } else {
      election17_tidy <-
        filter(election17_tidy, constituency_name == input$seventeen)
    }
  })
  election19_tidy <- election_stats19[,-c(1:2, 4:8, 11, 13, 19:32)]
  election19_tidy <- election19_tidy %>%
    mutate(MP = paste(mp_firstname,
                      mp_surname))
  election19_tidy <- election19_tidy [,-c(2:3)]
  election19_tidy <-
    election19_tidy %>% relocate(MP, .before = result)
  election19_tidy <- election19_tidy %>% rename(
    "Constituency" = "constituency_name",
    "Result" = "result",
    "Second Party" = "second_party",
    "Electorate" = "electorate",
    "Valid Votes" = "valid_votes",
    "Invalid Votes" = "invalid_votes",
    "Majority" = "majority"
  )
  tableConst15 <- reactive({
    if (input$fifteen == "Scotland") {
      election15_tidy
    } else {
      election15_tidy <-
        filter(election15_tidy, Constituency == input$fifteen)
    }
  })
  tableConst17 <- reactive({
    if (input$seventeen == "Scotland") {
      election17_tidy
    } else {
      election17_tidy <-
        filter(election17_tidy, Constituency == input$seventeen)
    }
  })
  tableConst19 <- reactive({
    if (input$nineteen == "Scotland") {
      election19_tidy
    } else {
      election19_tidy <-
        filter(election19_tidy, Constituency == input$nineteen)
    }
  })
  
  #output information table below plot
  output$table15 <- renderTable(tableConst15())
  output$table17 <- renderTable(tableConst17())
  output$table19 <- renderTable(tableConst19())
  
  #plot map
  output$scotland_map2019 <- renderGirafe({
    gg <-
      ggplot(filterConst19(), aes(x = long, y = lat , group = group)) +
      geom_polygon_interactive(
        aes(fill = result, tooltip = constituency_info),
        color = "black",
        size = 0.1
      ) +
      scale_fill_manual(values = c(
        "Con" = "deepskyblue",
        "Lab" = "red",
        "LD" = "orange",
        "SNP" = "yellow"
      )) +
      coord_equal() +
      labs(title = "2019 General election results in Scotland",
           caption = "Data from the House of Commons Library") +
      theme_void()
    ggiraph(code = print(gg))
  })
  output$scotland_map2017 <- renderGirafe({
    gg <-
      ggplot(filterConst17(), aes(x = long, y = lat , group = group)) +
      geom_polygon_interactive(
        aes(fill = result, tooltip = constituency_info),
        color = "black",
        size = 0.1
      ) +
      scale_fill_manual(values = c(
        "Con" = "deepskyblue",
        "Lab" = "red",
        "LD" = "orange",
        "SNP" = "yellow"
      )) +
      coord_equal() +
      labs(title = "2017 General election results in Scotland",
           caption = "Data from the House of Commons Library") +
      theme_void()
    ggiraph(code = print(gg))
  })
  output$scotland_map2015 <- renderGirafe({
    gg <-
      ggplot(filterConst15(), aes(x = long, y = lat , group = group)) +
      geom_polygon_interactive(
        aes(fill = result, tooltip = constituency_info),
        color = "black",
        size = 0.1
      ) +
      scale_fill_manual(values = c(
        "Con" = "deepskyblue",
        "Lab" = "red",
        "LD" = "orange",
        "SNP" = "yellow"
      )) +
      coord_equal() +
      labs(title = "2015 General election results in Scotland",
           caption = "Data from the House of Commons Library") +
      theme_void()
    ggiraph(code = print(gg))
  })
  
  output$selected2015 <- renderPlot({
    gg <-
      ggplot(Constituencies_tidy15, aes(x = long, y = lat , group = group)) +
      geom_polygon_interactive(aes(
        fill = ifelse(
          constituency_name == input$fifteen,
          constituency_name,
          "white"
        )
      ),
      color = "black",
      size = 0.01) +
      scale_fill_manual(values = c("magenta", "white"))  +
      coord_equal() +
      labs(title = "Selected Constituency") +
      theme_void() +
      theme(legend.position = "none")
    gg
  })
  
  output$selected2017 <- renderPlot({
    gg <-
      ggplot(Constituencies_tidy17, aes(x = long, y = lat , group = group)) +
      geom_polygon_interactive(aes(
        fill = ifelse(
          constituency_name == input$seventeen,
          constituency_name,
          "white"
        )
      ),
      color = "black",
      size = 0.01) +
      scale_fill_manual(values = c("magenta", "white"))  +
      coord_equal() +
      labs(title = "Selected Constituency") +
      theme_void() +
      theme(legend.position = "none")
    gg
  })
  
  output$selected2019 <- renderPlot({
    gg <-
      ggplot(Constituencies_tidy19, aes(x = long, y = lat , group = group)) +
      geom_polygon_interactive(aes(
        fill = ifelse(
          constituency_name == input$nineteen,
          constituency_name,
          "white"
        )
      ),
      color = "black",
      size = 0.01) +
      scale_fill_manual(values = c("magenta", "white"))  +
      coord_equal() +
      labs(title = "Selected Constituency") +
      theme_void() +
      theme(legend.position = "none")
    gg
  })
  
}