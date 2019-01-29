set_class <- function(object, new_class){
  class(object) <- c(new_class, class(object))
  object
}

#' @importFrom purrr map
names_to_as <- function(obj){
 res <- map(obj, as_if_not_null)
 paste(res, collapse = ", ")
}

as_if_not_null <- function(x){
  if (is.null(names(x))) {
    res <- x
  } else {
    res <- paste(imap(x, ~ glue("{.x} AS {.y}")),
                 collapse = ", ")
  }
  res
}

#' @importFrom glue glue
name_it <- function(obj, name = NULL){
  if (!is.null(name)){
    glue("{name} = {obj}")
  } else (
    glue("{obj}")
  )
}

#' @importFrom rlang enexpr
translate_four_j <- function(exp){
  exp <- rlang::enexpr(exp)
  exp %>%
    gsub("%in%", "IN", .) %>%
    gsub("%AS%", "AS", .) %>%
    gsub("c\\((.*)\\)", "[\\1]", .) %>%
    gsub("&", "AND", .) %>%
    gsub("%=~%", "=~", .)
}
# translate_four_j("user.name %in% c('Joe', 'John', 'Sara', 'Maria', 'Steve') & follower.name =~ 'S.*'")
