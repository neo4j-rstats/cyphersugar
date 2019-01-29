#' Create a node
#'
#' @param lhs the left-hand side of the cypher query. Typically, the output of a pipe %>%
#' @param ... the label, with an optional name variable
#' @param labels the properties of the nodes, passed as a name vector
#' @importFrom rlang exprs
#' @importFrom glue glue
#' @importFrom purrr imap is_empty
#' @return (node)
#' @export
#'

node <- function(lhs, ..., labels = NULL) {
  call <- rlang::exprs(...)
  if (missing(lhs)) lhs <- ""
  if (is_empty(call)) {
    res <- "()"
  } else {
    if (is.null(names(call))) {
      res <- glue("(:{call})")
    } else {
      res <- glue("{names(call)}:{unname(call)}")
    }
    if (!is.null(labels)){
      labels <- paste(imap(labels, ~ glue("{.y} : '{.x}'")),
                      collapse = ", ")
      res <- glue("([res] {[labels]})", .open = "[", .close = "]")
    } else {
      res <- glue("({res})")
    }
  }
    set_class(glue("{lhs} {res}"), "neo")
}

`%=~%` <- function(lhs, rhs){
  glue("{lhs} =~ '{rhs}'")
}

#' Create a relationship
#'
#' @inheritParams node
#'
#' @importFrom purrr imap
#' @importFrom glue glue
#'
#' @return \code{-[:relationship]-}
#' @export
#' @rdname relationships

to <- function(lhs, ..., labels = NULL){
  rel(lhs, ..., labels = NULL, direction = "to")
}


#' @export
#' @rdname relationships
from <- function(lhs, ..., labels = NULL){
  rel(lhs = lhs, ..., labels = labels, direction = "from")
}

rel <- function(lhs, ..., labels = NULL, direction = c("to", "from")) {
  #direction <- match.arg(direction)
  call <- rlang::exprs(...)
  if (is.null(names(call))) {
    res <- glue(":{call}")
  } else {
    res <- glue("{names(call)}:{unname(call)}")
  }
  if (!is.null(labels)){
    labels <- paste(imap(labels, ~ glue("{.y} : '{.x}'")),
                    collapse = ", ")
    res <- glue("[res] {[labels]}", .open = "[", .close = "]")
  }
  res <- glue("[{res}]")
  if (direction == "to"){
    res <- glue("-{res}->")
  } else {
    res <- glue("<-{res}-")
  }
  glue("{lhs} {res}")
}
