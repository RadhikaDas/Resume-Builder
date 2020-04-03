# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
# Developed with R version 3.3.2 (64-bit)
library(dplyr)
library(stringr)
library(png)
library(shinyjs)
library(DT)
library(visNetwork)
library(rintrojs)

library(officer)
library(mschart)
library(pagedown)
library(htmltools)



source("carouselPanel.R")

# Panel div for visualization
# override the currently broken definition in shinyLP version 1.1.0
panel_div <- function(class_type, content) {
  div(class = sprintf("panel panel-%s", class_type),
      div(class = "panel-body", content)
  )
}


shinyUI(navbarPage(title = "", id = "navBar",
                   theme = "./www/paper.css",
                   collapsible = TRUE,
                   inverse = TRUE,
                   windowTitle = "Ready Resume",
                   position = "fixed-top",
                   
                   header = tags$style(
                     ".navbar-right {
                       float: right !important;
                       }",
                     "body {padding-top: 50px;}"),
                   
                   tabPanel("HOME", value = "home",
                            
                            shinyjs::useShinyjs(),
                            
                            tags$head(tags$script(HTML('
                                                       var fakeClick = function(tabName) {
                                                       var dropdownList = document.getElementsByTagName("a");
                                                       for (var i = 0; i < dropdownList.length; i++) {
                                                       var link = dropdownList[i];
                                                       if(link.getAttribute("data-value") == tabName) {
                                                       link.click();
                                                       };
                                                       }
                                                       };
                                                       '))),
                            fluidRow(
                              HTML("

                                     <img src='Home.png' width='1350px' height='600px'>
                                     
                                     </section>
                                     ")
                            ),
                            
                           
                            fluidRow(
                              column(3),
                              column(6,
                                     shiny::HTML("<br><br><center> <h1>What you'll find here</h1> </center><br>"),
                                     shiny::HTML("<h5>Ready Resume is obsessed with helping people create the perfect resume they need to land the job of their dreams. With our easy to follow tool, we will guide you step by step through the resume building process, giving you resume tips and advice along the way.</h5>")
                              ),
                              column(3)
                            ),
                            br(),br(),
                            
                            fluidRow(
                              style="background-color:#FAFAFA",
                            
                            fluidRow(
                              shiny::HTML("<br><br><center> <h2>Steps To Create Your Perfect Resume</h2> </center>
                                            <br>")
                              
                            ),
                            
                            fluidRow(
                              column(3),
                              
                              column(2,
                                     div(class="panel panel-default", 
                                         div(class="panel-body",  width = "600px",
                                             align = "center",
                                             div(
                                               tags$img(src = "icon1.svg", 
                                                        width = "50px", height = "50px")
                                             ),
                                             br(),
                                             div(
                                               h5(
                                                 "CHOOSE YOUR
RESUME TEMPLATE"
                                               ),
                                               h6("Our professional resume templates are designed strictly following all industry guidelines and best practices
                                                      employers are looking for.")
                                             )
                                         )
                                     )
                              ),
                              column(2,
                                     div(class="panel panel-default",
                                         div(class="panel-body",  width = "600px", 
                                             align = "center",
                                             div(
                                               tags$img(src = "icon2.svg", 
                                                        width = "50px", height = "50px")
                                             ),
                                             br(),
                                             div(
                                               h5(
                                                 "SHOW WHAT
YOU'RE MADE OF"
                                               ),
                                               h6("Not finding the right words to showcase yourself? We have added thousands of pre-written examples and resume samples.
As easy as a click.")
                                             )
                                         )
                                     )
                              ),
                              column(2,
                                     div(class="panel panel-default",
                                         div(class="panel-body",  width = "600px", 
                                             align = "center",
                                             div(
                                               tags$img(src = "icon3.svg", 
                                                        width = "50px", height = "50px")),
                                             br(),
                                             div(
                                               h5(
                                                 "DOWNLOAD
YOUR RESUME "
                                               ),
                                               h6("Start impressing employers.Download your awesome resume and land the job you are looking for, effortlessly now.")
                                             )
                                         )
                                     )
                              ),
                              column(3)
                              
                            ),
                            
                            
                            fluidRow(
                              column(3),
                              column(6,
                                     tags$div(align = "center", 
                                              tags$a("Start", 
                                                     onclick="fakeClick('template')", 
                                                     class="btn btn-success btn-lg")
                                     )
                              ),
                              column(3)
                            ),
                            fluidRow(style = "height:25px;"
                            )
                            
                   )), # Closes the first tabPanel called "Home"
                   
                   tabPanel("TEMPLATES", value = "template",
                            br(),
                            sidebarLayout( 
                              
                              sidebarPanel( width = 3,
                                            introjsUI(),
                                            
                                            tags$div(
                                              actionButton("help", "Take a Quick Tour",class="btn btn-primary btn-lg"),
                                              style = "height:50px;"
                                            ),
                                            useShinyjs(),
                                            
                                            
                              ),  # Closes sidebarPanel
                              mainPanel( width = 9,
                                         fluidRow(
                                           
                                         tags$style(type="text/css",
                                                    ".shiny-output-error { visibility: hidden; }",
                                                    ".shiny-output-error:before { visibility: hidden; }"
                                         ),
                                           introBox(
                                             panel_div(class_type = "default",
                                                       content = tags$div(
                                                         
                                                         htmlTemplate("./www/Home.html"),
                                                         


                                                       )
                                             ),
                                             data.step = 4,
                                             data.intro = "Template using for creating resume."
                                           )
                                         
                                         ),
                                         
                                         fluidRow(
                                           div(class="panel panel-default",
                                               div(class="panel-body",  width = "600px",
                                                   tags$div(class = "wrap",
                                                            div(class = "left", 
                                                                style="display: inline-block;vertical-align:top; width: 150px;",
                                                                uiOutput("stepNo")
                                                            ),
                                                            
                                                            div(class = "center",
                                                                style="display: inline-block;vertical-align:top; width: 350px;",
                                                                introBox(
                                                                  actionButton("goBack", 
                                                                               label = "Back", 
                                                                               icon = icon("arrow-circle-left", class = "fa-2x"),
                                                                               width= "250px", height= "40px",
                                                                               class = "btn-primary",
                                                                               onclick="fakeClick('home')"),
                                                                  data.step = 3,
                                                                  data.intro = "Go back a step to Home Page."
                                                                )
                                                            ),
                                                               
                                                            div(class = "center",
                                                                style="display: inline-block;vertical-align:top; width: 150px;",
                                                                introBox(
                                                                  actionButton("btn1", 
                                                                               label = "Use This Template", 
                                                                               icon = icon("arrow-circle-right", class = "fa-2x"),
                                                                               width= "250px", height= "40px",
                                                                               class = "btn-primary",
                                                                               onclick="fakeClick('about')"),
                                                                  data.step = 2,
                                                                  data.intro = "Template will be Selected"
                                                                )
                                                            )
                                                   ),
                                                   
                                               )
                                           ),
                                           
                                         )
                              )  # Closes the mainPanel
                            )  # Closes the sidebarLayout
                   ),  
                   
                   tabPanel("BUILD", value = "about",
                            br(),
                            mainPanel( width = 6,
                                       fluidRow(
                                         
                                         tags$style(type="text/css",
                                                    ".shiny-output-error { visibility: hidden; }",
                                                    ".shiny-output-error:before { visibility: hidden; }"
                                         ),
                                         introBox(
                                           panel_div(class_type = "default",
                                                     content = tags$div(
                                                       
                                                       
                                                       id = "form",
                                                       
                                                   
                                                       textInput("name", "Name", value=""),
                                                       textInput("role", "Role", value=""),

                                                       textAreaInput("address", "Address"),
                                                       shiny::HTML("<h6>Are you a student</h6>"),
                                                       column(2,checkboxInput("yes", "Yes", FALSE)),column(2,checkboxInput("exp", "No", FALSE)),
                                                       textInput("phone", "Phone Number"),
                                                       textInput("email", "Email"),
                                                       selectInput("gender", "Gender",
                                                                   c("" ,"Male", "Female")),
                                                       
                                                       textAreaInput("skills", "Skills", value="",rows="4"),
                                                       
                                                       textAreaInput("education", "Education", value=""),
                                                       textAreaInput("certification", "Certification", value=""),
                                                       textAreaInput("interest", "Interest", value=""),
                                                       textAreaInput("summary", "Summary", value=""),
                                                       actionButton("preview", "Preview", class = "btn-primary") ,
                                                       downloadButton("document", "Download Resume"),
                                                       
                                                      
                                                     )
                                           )))),
                            br(),br(),br(),br(),
                            sidebarPanel( width = 5,
                                          introjsUI(),
                                          
                                          tags$div(
                                           
                                            img(src="srz1.png", height = "500px", width="450px")
                                          ),
                                          useShinyjs()
                            )
                            
                           
                            
                            
                   ) , 
                   tabPanel(" ", value = "new",
                            br(),br(),br(),br(),br(),br()
                            
                            )
                   
)

)