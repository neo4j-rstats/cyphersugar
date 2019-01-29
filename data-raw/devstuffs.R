library(usethis)
library(desc)
library(glue)
library(purrr)


unlink("DESCRIPTION")
my_desc <- description$new("!new")
my_desc$set("Package", "cyphersugar")
my_desc$set("Authors@R", "person('Colin', 'Fay', email = 'colin@thinkr.fr', role = c('cre', 'aut'))")
my_desc$del("Maintainer")
my_desc$set_version("0.0.0.9000")
my_desc$set(Title = "A Neo4J Cypher Query Language Syntactic Sugar")
my_desc$set(Description = "An Implementation of Neo4J Cypher Query Language inside R.")
my_desc$set("URL", "https://github.com/neo4j-rstats/cyphersugar")
my_desc$set("BugReports", "https://github.com/neo4j-rstats/cyphersugar/issues")
my_desc$write(file = "DESCRIPTION")

use_mit_license(name = "ThinkR")
use_readme_rmd()
use_code_of_conduct()
use_lifecycle_badge("Experimental")
use_news_md()

use_package("glue")
use_package("purrr")
use_package("rlang")

use_roxygen_md()
use_pipe()

use_testthat()
use_test("cypherization")
use_test("examples")

use_vignette("cypher-translation")
