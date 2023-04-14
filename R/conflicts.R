#' Conflicts between the ojoverse and other packages
#'
#' This function lists all the conflicts between packages in the ojoverse
#' and other packages that you have loaded.
#'
#' @export
#' @param only Set this to a character vector to restrict to conflicts only
#'   with these packages.
#' @examples
#' ojoverse_conflicts()
#'
ojoverse_conflicts <- function(only = NULL) {
  envs <- grep("^package:", search(), value = TRUE)
  envs <- purrr::set_names(envs)

  if (!is.null(only)) {
    only <- union(only, core)
    envs <- envs[names(envs) %in% paste0("package:", only)]
  }

  objs <- invert(lapply(envs, ls_env))

  conflicts <- purrr::keep(objs, ~ length(.x) > 1)

  tidy_names <- paste0("package:", ojoverse_packages()) #nolint
  conflicts <- purrr::keep(conflicts, ~ any(.x %in% tidy_names))

  conflict_funs <- purrr::imap(conflicts, confirm_conflict)
  conflict_funs <- purrr::compact(conflict_funs)

  conflict_obj <- structure(conflict_funs, class = "ojoverse_conflicts")

  return(conflict_obj)
}

ojoverse_conflict_message <- function(x) {
  header <- cli::rule(
    left = cli::style_bold("Conflicts"),
    right = "ojoverse_conflicts()"
  )

  pkgs <- x |> purrr::map(~ gsub("^package:", "", .))
  others <- pkgs |> purrr::map(`[`, -1)
  other_calls <- purrr::map2_chr(
    others, names(others),
    ~ paste0(cli::col_blue(.x), "::", .y, "()", collapse = ", ")
  )

  winner <- pkgs |> purrr::map_chr(1)
  funs <- format(paste0(cli::col_blue(winner), "::", cli::col_green(paste0(names(x), "()"))))
  bullets <- paste0(
    cli::col_red(cli::symbol$cross), " ", funs, " masks ", other_calls,
    collapse = "\n"
  )

  conflict_message <- paste0(
    header, "\n",
    bullets, "\n"
  )

  return(conflict_message)
}

#' @export
print.ojoverse_conflicts <- function(x, ..., startup = FALSE) {
  cli::cat_line(ojoverse_conflict_message(x))
  invisible(x)
}

confirm_conflict <- function(packages, name) {
  # Only look at functions
  objs <- packages |>
    purrr::map(~ get(name, pos = .)) |>
    purrr::keep(is.function)

  if (length(objs) <= 1) {
    return(NULL)
  }

  # Remove identical functions
  objs <- objs[!duplicated(objs)]
  packages <- packages[!duplicated(packages)]
  if (length(objs) == 1) {
    return(NULL)
  }

  return(packages)
}

ls_env <- function(env) {
  x <- ls(pos = env)

  # intersect, setdiff, setequal, union come from generics
  if (env %in% c("package:dplyr", "package:lubridate")) {
    x <- setdiff(x, c("intersect", "setdiff", "setequal", "union"))
  }

  if (env == "package:lubridate") {
    x <- setdiff(x, c(
      "as.difftime", # lubridate makes into an S4 generic
      "date"         # matches base behaviour
    ))
  }

  return(x)
}