
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

**Disclaimer: this repo is just a Proof of Concept and should not be
used.**

# cyphersugar

{cyphersugar} is intended to bring syntactic sugar to Neo4J cypher
langugage, so you can write cypher queries in a more natural way if you
come from R.

## Convention

Every cypher function is in uppercase (`MATCH`, `RETURN`, `LIMIT`…). The
wrappers are in lower case (`node`, `to`, `from`…)

## Example

``` r
library(cyphersugar)
MATCH() %>%
  node(n = "Person", labels = c(name = "Colin")) %>%
  to(k = "KNOWS") %>%
  node("Person") %>%
  RETURN(person = "n", knows = "k") %>%
  LIMIT(25)
#> MATCH (n:Person {name : 'Colin'}) -[k:KNOWS]-> (:Person) RETURN n, k LIMIT 25
```

The end idea is, of course, to be able to use it with `neo4r`, or other
Neo4J R Drivers.

``` r
library(neo4r)
con <- neo4j_api$new(url = "http://localhost:7474", 
                     user = "neo4j", password = "neo4j")
con$ping()

MATCH() %>%
  node('n') %>%
  RETURN(node = "n") %>%
  LIMIT(25) %>%
  call_api(con)
```

## Examples

``` r
CREATE(node(adam = "User", labels = c(name = "Adam")), 
       node(pernilla = "User", labels = c(name = "pernilla")), 
       node(david = "User", labels = c(name = "david")))
#> CREATE  (adam:User {name : 'Adam'}),  (pernilla:User {name : 'pernilla'}),  (david:User {name : 'david'})
```

``` r
MATCH() %>%
  node(r = "record") %>%
  to("WAS_RECORDED") %>% 
  node(b = "Band") %>% 
  RETURN("r AS band")
#> MATCH (r:record) -[:WAS_RECORDED]-> (b:Band) RETURN r AS band
```
