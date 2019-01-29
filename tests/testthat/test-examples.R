context("test-examples.R")

library(cyphersugar)

test_that("online examples works", {
  # Cypher 3.1
  expect_equal(MATCH() %>%
                 node("john", labels = c(name = "John")) %>%
                 relates("friend", direction = "to") %>%
                 node() %>%
                 relates("friend", direction = "to") %>%
                 node("fof") %>%
                 RETURN(john.name, fof.name) %>%
                 as.character(),
               "MATCH (john {name : 'John'}) -[:friend]-> () -[:friend]-> (fof) RETURN john.name, fof.name")

  expect_equal(MATCH() %>%
                 node("john", labels = c(name = "John")) %>%
                 relates("friend", direction = "to") %>%
                 node() %>%
                 relates("friend", direction = "to") %>%
                 node("fof") %>%
                 RETURN(john.name, fof.name) %>%
                 as.character(),
               "MATCH (john {name : 'John'}) -[:friend]-> () -[:friend]-> (fof) RETURN john.name, fof.name")
})
