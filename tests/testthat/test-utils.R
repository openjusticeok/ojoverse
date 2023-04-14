test_that("ojoverse packages returns character vector of package names", {
  out <- ojoverse_packages()
  expect_type(out, "character")
  expect_true("ojodb" %in% out)
})