% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/code-trim-shinyapp.R
\name{trim_shinyApp}
\alias{trim_shinyApp}
\title{Trim code after shinyApp() call}
\usage{
trim_shinyApp(x)
}
\arguments{
\item{x}{code or expression to strip of code at the shinyApp() call}
}
\value{
the code or expression with all code at and beyond the shinyApp()
  call removed.
}
\description{
Replaces shinyApp() call with \code{NULL} and removes all
  following code from a block of code. This is particularly useful to
  recreate the server state as none of the code after a shinyApp() call will
  be reached.
}
\examples{
code <- quote({
  ui <- fluidPage(
    selectInput('x', 'x axis', choices = names(mtcars)),
    selectInput('y', 'y axis', choices = names(mtcars)),
    plotOutput('plot'),
  )
  
  srv <- function(input, output, session) {
    output$plot <- renderPlot({
      plot(x = mtcars[[input$x]],
        y = mtcars[[input$y]])
    })
  }

  shinyApp(ui, srv)

  print('this is some code after the shinyApp() call')
  
  a <- 1
  b <- 2
})

scriptgloss:::trim_shinyApp(code)



code2 <- quote({
  ui <- fluidPage(
    selectInput('x', 'x axis', choices = names(mtcars)),
    selectInput('y', 'y axis', choices = names(mtcars)),
    plotOutput('plot'),
  )
  
  srv <- function(input, output, session) {
    output$plot <- renderPlot({
      plot(x = mtcars[[input$x]],
        y = mtcars[[input$y]])
    })
  }

  a <- 1

  if (a == 1) {
    shinyApp(ui, srv)
  } else {
    print("This app never got launched!")
  }

  print('this is some code after the shinyApp() call')
  
  b <- 2
})

scriptgloss:::trim_shinyApp(code2)


}
