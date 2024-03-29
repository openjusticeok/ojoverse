#' @keywords internal
"_PACKAGE"

# Suppress R CMD check note
# Namespace in Imports field not imported from: PKG
#   All declared Imports should be used.
ignore_unused_imports <- function() {
  ojodb::ojo_connect
  ojoregex::regex_pre_clean
  ojoslackr::ojo_watermark
  ojoutils::limit
  forcats::as_factor
  ggplot2::ggplot
  readr::read_csv
  stringr::str_c
  tidyr::nest
}
