.onAttach <- function(...) {
  attached <- ojoverse_attach()
  if (!is_loading_for_tests()) {
    inform_startup(ojoverse_attach_message(attached))
  }

  if (!is_attached("conflicted") && !is_loading_for_tests()) {
    conflicts <- ojoverse_conflicts()
    inform_startup(ojoverse_conflict_message(conflicts))
  }
}

is_attached <- function(x) {
  paste0("package:", x) %in% search()
}

is_loading_for_tests <- function() {
  !interactive() && identical(Sys.getenv("DEVTOOLS_LOAD"), "ojoverse")
}