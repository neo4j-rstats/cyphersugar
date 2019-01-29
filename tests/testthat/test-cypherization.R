context("test-cypherization.R")

test_that("MATCH works", {
  expect_equal(MATCH(), "MATCH")
})

test_that("nodes works", {
  expect_equal(MATCH() %>%
                 node(n = "Person", labels = c(name = "Colin")),
               "MATCH (n:Person {name : 'Colin'})")
})

test_that("relates works", {
  expect_equal(MATCH() %>%
                 node(n = "Person", labels = c(name = "Colin")) %>%
                 relates(k = "KNOWS", direction = "to") ,
               "MATCH (n:Person {name : 'Colin'}) -[k:KNOWS]->")
})

test_that("RETURN works", {
  expect_equal(MATCH() %>%
                 node(n = "Person", labels = c(name = "Colin")) %>%
                 relates(k = "KNOWS", direction = "to") %>%
                 node("Person") %>%
                 RETURN(n, k, p) ,
               "MATCH (n:Person {name : 'Colin'}) -[k:KNOWS]-> (Person) RETURN n, k, p")
})

test_that("LIMIT works", {
  expect_equal(MATCH() %>%
                 node('n') %>%
                 RETURN(node = n) %>%
                 LIMIT(25) ,
               "MATCH (n) RETURN n AS node LIMIT 25")
})
