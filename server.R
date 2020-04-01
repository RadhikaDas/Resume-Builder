# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

# Work PC uses: rsconnect 0.4.3 






shinyServer(function(input, output, session) {
    
    # Navbar ------------------------------------------------------------------
    shinyjs::addClass(id = "navBar", class = "navbar-right")
    
    # DT Options --------------------------------------------------------------
    options(DT.options = list( lengthMenu = c(10, 20),
                               dom = 'tl'
    ))  # table and lengthMenu options
    
    # Intro JS ----------------------------------------------------------------
    observeEvent(input$help,
                 introjs(session, options = list("nextLabel"="Next",
                                                 "prevLabel"="Back",
                                                 "skipLabel"="Exit"))
    )
    
    
    # Initialize a variable to count how many times "btn1" is clicked.
    values <- reactiveValues(data = 1) 
    
    # Btn1 ---------------------------------------------------------------------
    # React to "btn1" being pressed by adding 1 to the values$data variable
    observeEvent( input$btn1, {
        
    })
    
    # Go Back Button -----------------------------------------------------------
    
    observeEvent( input$goBack, {
       
    
    
    })
    
    
    # Start Button -------------------------------------------------------------
    observeEvent(input$startBtn, {
        updateNavbarPage(session, "navBar",
                         selected = "careerPF"
        )
    })
    
    
    
   
    
    
    #inputing data........
    output$your<- renderText({
        
        input$name
    })
    output$role<- renderText({

        input$role
    })
    output$address<- renderText({

        input$address
    })
    output$phone<- renderText({

        input$phone
    })
    output$email<- renderText({

        input$email
    })
    output$skills<- renderText({

        input$skills
    })
    output$education<- renderText({
      
      input$education
    })
    output$interest<- renderText({
      
      input$interest
    })
    output$certification<- renderText({
      
      input$certification
    })
    output$summary<- renderText({
      
      input$summary
    })
    output$job<- renderText({
      
      input$job
    })
    output$company<- renderText({
      
      input$company
    })
    output$state<- renderText({
      
      input$state
    })
    output$jobline<- renderText({
      
      input$jobline
    })

  
    template<-htmlTemplate("input.html",your=textOutput("your"),role=textOutput("role"),address=textOutput("address"),phone=textOutput("phone"),
                           email=textOutput("email"),skills=textOutput("skills"),experience=textOutput("experience"),education=textOutput("education"),certification=textOutput("certification"),
                           interest=textOutput("interest"),summary=textOutput("summary"),job=textOutput("job"),company=textOutput("company"),state=textOutput("state")
                           ,jobline=textOutput("jobline"))
    observeEvent(input$preview, {
      showModal(modalDialog(
        footer = "",
        title = "Preview",
        template,
        
        size =  "l",
        easyClose = TRUE
      ))
    })
    
    observeEvent(input$exp, {
      if(input$exp==TRUE){
      showModal(modalDialog(
        title = "Experience",
        textInput("job", "JobTitle"),
        textInput("company", "Company", value = ""),
        textInput("state", "State", value = ""),
        textAreaInput("jobline", "JobLine", value = ""),
        size =  "m",
        easyClose = TRUE
      ))
      }
      else {
        removeModal()
      }
        
    })


output$document <- downloadHandler(
  filename = function(){paste(template, '.pdf', sep = '')},

  content = function(file){
    cairo_pdf(filename = file,
              width = 18, height = 10, pointsize = 12, family = "sans", bg = "transparent",
              antialias = "subpixel",fallback_resolution = 300)


  }
# 
#  contentType = "application/pdf"
 )
#}

    
})
