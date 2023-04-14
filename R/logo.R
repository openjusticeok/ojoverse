#'
#' Use [cli::ansi_strip()] to get rid of the colors.
#'
#' @param unicode Whether to use Unicode symbols. Default is `TRUE`
#'   on UTF-8 platforms.
#'
#' @md
#' @export
#' @examples
#' ojoverse_logo()
#'
ojoverse_logo <- function(unicode = cli::is_utf8_output()) {

}


#' @export
print.ojoverse_logo <- function(x, ...) {
  cat(x, ..., sep = "\n")
  invisible(x)
}