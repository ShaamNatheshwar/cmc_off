library(shiny)
library(ggplot2)
dataset <- diamonds
shinyUI(navbarPage(title = "CHRISTIAN MEDICAL COLLEGE", 
                   footer = includeHTML('footer.html'),
                   
                   tabPanel("About Page", 
                            h4("This app uses navbar for layout & mtcars dataset for demo")
                   ),
                   
                   
                   tabPanel("Data Management", sidebarLayout(
                     
                     # Sidebar panel for inputs ----
                     sidebarPanel(
                       
                       # Input: Select a file ----
                       fileInput("file1", "Choose CSV File",
                                 multiple = FALSE,
                                 accept = c("text/csv",
                                            "text/comma-separated-values,text/plain",
                                            ".csv")),
                       
                       # Horizontal line ----
                       tags$hr(),
                       
                       # Input: Checkbox if file has header ----
                       checkboxInput("header", "Header", TRUE),
                       
                       # Input: Select separator ----
                       radioButtons("sep", "Separator",
                                    choices = c(Comma = ",",
                                                Semicolon = ";",
                                                Tab = "\t"),
                                    selected = ","),
                       
                       # Input: Select quotes ----
                       radioButtons("quote", "Quote",
                                    choices = c(None = "",
                                                "Double Quote" = '"',
                                                "Single Quote" = "'"),
                                    selected = '"'),
                       
                       # Horizontal line ----
                       tags$hr(),
                       
                       # Input: Select number of rows to display ----
                       radioButtons("disp", "Display",
                                    choices = c(Head = "head",
                                                All = "all"),
                                    selected = "head")
                       
                     ),
                     
                     # Main panel for displaying outputs ----
                     mainPanel(
                       
                       # Output: Data file ----
                       tableOutput("contents")
                       
                     )
                     
                   )),
                   
                   
                   tabPanel("overview",
                            sidebarLayout(
                              sidebarPanel(
                                sliderInput("b", "Select no. of BINs", min = 5, max = 20,value = 10)
                              ),
                              mainPanel(
                                plotOutput("plot")
                              )
                            )
                   ),
                   
                   
                   
                   
                   tabPanel("follow up", sidebarLayout(
                     sidebarPanel(
                       selectInput(inputId = "var1", label = "Select the X variable", choices = c("Sepal.Length" = 1, "Sepal.Width" = 2, "Petal.Length" = 3, "Petal.Width" = 4)),
                       selectInput(inputId = "var2", label = "Select the Y variable", choices = c("Sepal.Length" = 1, "Sepal.Width" = 2, "Petal.Length" = 3, "Petal.Width" = 4), selected = 2),
                       radioButtons(inputId = "var3", label = "Select the file type", choices = list("png", "pdf"))
                     ),
                     mainPanel(
                       plotOutput("dplot"),
                       downloadButton(outputId = "down", label = "Download the plot")
                     )
                   )),
                   tabPanel("HAI", sidebarLayout(
                     sidebarPanel(
                       selectInput("dataset", "Select the dataset", choices = c("iris", "mtcars", "trees")),
                       br(),
                       helpText(" Select the download format"),
                       radioButtons("type", "Format type:",
                                    choices = c("Excel (CSV)", "Text (TSV)","Text (Space Separated)", "Doc")),
                       br(),
                       helpText(" Click on the download button to download the dataset observations"),
                       downloadButton('downloadData', 'Download')
                       
                     ),
                     mainPanel(
                       
                       tableOutput('table')
                     )
                   )),
                   tabPanel("Microbiology", sidebarPanel(
                     # selectInput widget for the selection of dataset
                     selectInput("dataset", "Choose a dataset:", 
                                 choices = c("iris", "pressure", "mtcars")),
                     
                     # numericInput for selection of the number of observation that user wants to view
                     numericInput("obs", "Number of observations:", 6),
                     # submitButton to create dependency of the reactivity on the event of pressing of the submitbutton. 
                     submitButton("Update!"),
                     p("In this example, changing the user input (datset or number of observation) will not reflect in the output until the Update button is clicked"),
                     p("submitButton is used to control the reactiveness of the change in the user input")
                   ),
                   mainPanel(
                     # just a header for the heading
                     h4(textOutput("dataname")),
                     # display the structure of the selected dataset is dependent of the submit button
                     verbatimTextOutput("structure"),
                     
                     # just a header for the heading
                     h4(textOutput("observation")),
                     # display the observations of the selected dataset is dependent of the submit button
                     tableOutput("view")
                   )),
                   tabPanel("AMR",fluidRow(
                     # column allocation for widgets
                     column(4,
                            
                            sliderInput('sampleSize', 'Sample Size', 
                                        min=1, max=nrow(dataset), value=min(1000, nrow(dataset)), 
                                        step=500, round=0),
                            br(),
                            checkboxInput('jitter', 'Jitter'),
                            checkboxInput('smooth', 'Smooth')
                     ),
                     column(4,
                            selectInput('x', 'X', names(dataset)),
                            selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
                            selectInput('color', 'Color', c('None', names(dataset)))
                     ),
                     column(4,
                            selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
                            selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
                     )
                   ), ## End of the fluidRow and grid
                   hr(),
                   plotOutput("fplot")),
                   tabPanel("FAQ", h1('This is FAQ')),
                   
))