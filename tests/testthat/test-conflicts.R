test_that("useful conflicts message", {
  expect_snapshot({
    ojoverse_conflicts(c("base", "stats"))
  })
})