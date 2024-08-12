library(shiny)

generate_story <- function(noun, verb, adjective, adverb) {
  glue::glue("
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!
  ")
}

ui <- fluidPage(
  titlePanel("Mad Libs Game"),
  sidebarLayout(
    sidebarPanel(
      textInput("noun1", "Enter a noun:", ""),
      textInput("verb", "Enter a verb:", ""),
      textInput("adjective", "Enter an adjective:", ""),
      textInput("adverb", "Enter an adverb:", "")
    ),
    mainPanel(
      h3("Your Mad Libs Story:"),
      textOutput("story")
    )
  )
)

server <- function(input, output) {
  story <- reactive({
    noun <- input$noun1
    verb <- input$verb
    adj <- input$adjective
    adv <- input$adverb
    cat(
      glue::glue("Attempting to write story about {noun}, {verb}, {adj}, and {adv}."),
      file = stderr()
    )
    if (!isTruthy(noun) | !isTruthy(verb) | !isTruthy(adj) | !isTruthy(adv)) {
      "(input terms for madlib)"
    } else {
      generate_story(noun, verb, adj, adv)
    }
  })
  output$story <- renderText({
    story()
  })
}

shinyApp(ui = ui, server = server)
