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
    output$designation<- renderText({
      
      input$designation
    })
    output$jobline<- renderText({
      
      input$jobline
    })
    output$job1<- renderText({
      
      input$job1
    })
    output$company1<- renderText({
      
      input$company1
    })
    output$designation1<- renderText({
      
      input$designation1
    })
    output$jobline1<- renderText({
      
      input$jobline1
    })

  
    template<-htmlTemplate("input.html",your=textOutput("your"),role=textOutput("role"),address=textOutput("address"),phone=textOutput("phone"),
                           email=textOutput("email"),skills=textOutput("skills"),experience=textOutput("experience"),education=textOutput("education"),certification=textOutput("certification"),
                           interest=textOutput("interest"),summary=textOutput("summary"),job=textOutput("job"),company=textOutput("company"),designation=textOutput("designation")
                           ,jobline=textOutput("jobline"),job1=textOutput("job1"),company1=textOutput("company1"),designation1=textOutput("designation1")
                           ,jobline1=textOutput("jobline1"))
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
        textInput("designation", "Designation", value = ""),
        textAreaInput("jobline", "JobLine", value = ""),
        actionButton('add',"+"),
        size =  "m",
        easyClose = TRUE
      ))
      }
      else {
        removeModal()
      }
        
    })
    observeEvent(input$add, {
      
      showModal(modalDialog(
        title = "Experience",
        textInput("job1", "JobTitle"),
        textInput("company1", "Company", value = ""),
        textInput("designation1", "Designation", value = ""),
        textAreaInput("jobline1", "JobLine", value = ""),
        
        size =  "m",
        easyClose = TRUE
      ))
      
      
    })

    output$document <- downloadHandler( 
      #filename = function() paste0("doc_", Sys.Date(), ".docx"), 
      filename = 'Resume.pdf',
      content = function(file) {
        save_html(htmlTemplate("input.html",your=input$name,role=input$role,address=input$address,phone=input$phone,
                               email=input$email,skills=input$skills,experience=input$experience,education=input$education,certification=input$certification,
                               interest=input$interest,summary=input$summary,job=input$job,company=input$company,designation=input$designation
                               ,jobline=input$jobline,job1=input$job1,company1=input$company1,designation1=input$designation1
                               ,jobline1=input$jobline1),'input2.html')
        chrome_print('input2.html',output = file)


  }

 )


    
})
