#' @keywords internal
"_PACKAGE"

# Suppress R CMD check note
# Namespace in Imports field not imported from: PKG
#   All declared Imports should be used.
ignore_unused_imports <- function() {
  ojodb::ojo_connect
  ojoslackr::ojo_watermark
  ojoutils::limit
}