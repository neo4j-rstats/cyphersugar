#' MATCH
#'
#' @return MATCH()
#' @export
#'

MATCH <- function(){
  set_class(glue("MATCH"), "neo")
}


#' Create a WHERE clause
#'
#' @inheritParams node
#' @param rhs the content of the condition
#'
#' @return WHERE()
#' @export
#'

WHERE <- function(lhs, rhs){
  rhs <- rlang::enexprs(rhs)
  rhs <- translate_four_j(!! rhs)
  glue("{lhs} {rhs}")
}

#' RETURN
#'
#' @param lhs the left-hand side of the cypher query. Typically, the output of a pipe %>%
#' @param ... what to return
#'
#' @importFrom rlang enexprs
#'
#' @return RETURN
#' @export
#'

RETURN <- function(lhs, ...){
  objet <- names_to_as(list(...))
  glue("{lhs} RETURN {objet}")
}

#' LIMIT
#'
#' @inheritParams node
#' @param limit the limit threshold
#'
#' @return LIMIT
#' @export
#'

LIMIT <- function(lhs, limit){
  glue("{lhs} LIMIT {limit}")
}


#' WITH
#'
#' Create a WITH clause
#'
#' @inheritParams node

WITH <- function(lhs, ...){
  #browser()
  objet <- names_to_as(rlang::enexprs(...))
  objet <- map(objet, translate_four_j)
  glue("{lhs} WITH {objet}")
}

#' AS infix operator
#'
#' @param lhs the elemnt of the query
#' @param rhs the alias
#'
#' @return x AS y
#' @export
#'

`%AS%` <- function(lhs, rhs){
  lhs <- deparse(substitute(lhs))
  rhs <- deparse(substitute(rhs))
  glue("{lhs} AS {rhs}")
}

#' SET
#'
#' @inheritParams node
#'
#' @return SET x y
#' @export
#'

SET <- function(lhs, ...){
  objs <- rlang::enexprs(...) %>%
    imap(name_it) %>%
    map(translate_four_j) %>%
    paste(collapse = ", ")
  glue("{lhs} SET {objs}")
}

#' SET
#'
#' @inheritParams node
#'
#' @return CREATE x
#' @export
#'

CREATE <- function(...){
  objs <- paste(..., sep = ", ")
  glue("CREATE {objs}")
}
