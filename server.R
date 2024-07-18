setwd("C:/Users/Hp/Desktop/Sail Class-20240629T191341Z-001/Sail Class2/Iris folder")

library(shiny)

if(!require(pacman)) install.packages("pacman")

pacman::p_load(
  tidyverse,
  caret,
  kernlab,
  ggplot2,
  ISLR,
  Hmisc,
  gridExtra,
  manipulate,
  broom,
  BSDA,
  rsample,
  tidymodels,
  ranger
)



# Load the iris dataset
data(iris)

# Split the data
set.seed(123)
split_data <- initial_split(iris, prop = 0.7, strata = Species)
training_data <- training(split_data)
testing_data <- testing(split_data)

# Model specification
iris_spec <- rand_forest() %>% 
  set_engine('ranger') %>% 
  set_mode('classification')

# Create the recipe
iris_recipe <- recipe(Species ~ ., data = training_data) %>% 
  step_impute_median() %>% 
  step_dummy(all_nominal_predictors())

# Create the workflow
iris_workflow <- workflow() %>% 
  add_model(iris_spec) %>% 
  add_recipe(iris_recipe)

# Fit the model
iris_fit <- iris_workflow %>% 
  fit(data = training_data)

shinyServer(function(input, output) {
  output$oid1 <- renderPrint({ input$id1 })
  output$oid2 <- renderPrint({ input$id2 })
  output$oid3 <- renderPrint({ input$id3 })
  output$oid4 <- renderPrint({ input$id4 })
  
  output$prediction <- renderPrint({
    # Create a data frame from user inputs
    new_data <- data.frame(
      Sepal.Length = as.numeric(input$id1),
      Sepal.Width = as.numeric(input$id2),
      Petal.Length = as.numeric(input$id3),
      Petal.Width = as.numeric(input$id4)
    )
    
    # Make a prediction
    prediction <- predict(iris_fit, new_data)
    
    # Display the prediction result
    as.character(prediction$.pred_class)
  })
})

