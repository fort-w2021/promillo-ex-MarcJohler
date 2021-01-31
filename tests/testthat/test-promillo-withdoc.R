testthat::context("tell_me_how_drunk")

testthat::test_that("basic implementation is correct", {
  testthat::expect_equivalent(
    tell_me_how_drunk(
      age = 39,
      sex = "male",
      height = 190,
      weight = 87,
      drinking_time = as.POSIXct(c("2016-10-03 17:15:00", "2016-10-03 22:55:00")),
      drinks = c("massn" = 3, "schnaps" = 4)
    ),
    2.359,
    tolerance = 0.01
  )
  testthat::expect_equivalent(
    tell_me_how_drunk(
      age = 24,
      sex = "female",
      height = 160,
      weight = 54,
      drinking_time = as.POSIXct(c("2016-10-03 14:00:00", "2016-10-03 21:00:00")),
      drinks = list("hoibe" = 1, "schnaps" = 2)
    ),
    0.40,
    tolerance = 0.01
  )
  testthat::expect_equivalent(
    tell_me_how_drunk(
      age = 68,
      sex = "male",
      height = 169,
      weight = 84,
      drinking_time = as.POSIXct(c("2016-10-03 08:10:00", "2016-10-03 08:15:00")),
      drinks = c("schnaps" = 3)
    ),
    0.687,
    tolerance = 0.01
  )
  testthat::expect_equivalent(
    tell_me_how_drunk(
      age = 38,
      sex = "male",
      height = 190,
      weight = 134,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("hoibe" = 1)
    ),
    0
  )
})

# use input homogenization and match.arg for this:
testthat::test_that("interface for sex is implemented flexibly", {
  testthat::expect_equal(
    tell_me_how_drunk(
      age = 38,
      sex = "male",
      height = 190,
      weight = 134,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("hoibe" = 5)
    ),
    tell_me_how_drunk(
      age = 38,
      sex = "m",
      height = 190,
      weight = 134,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("hoibe" = 5)
    )
  )
  testthat::expect_equal(
    tell_me_how_drunk(
      age = 38,
      sex = "M",
      height = 190,
      weight = 134,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("hoibe" = 5)
    ),
    tell_me_how_drunk(
      age = 38,
      sex = "m",
      height = 190,
      weight = 134,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("hoibe" = 5)
    )
  )
})

testthat::test_that("interface for drinks is implemented flexibly", {
  testthat::expect_equal(
    tell_me_how_drunk(
      age = 38,
      sex = "M",
      height = 190,
      weight = 134,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = list(list("hoibe" = 1), "schnaps" = 2)
    ),
    tell_me_how_drunk(
      age = 38,
      sex = "m",
      height = 190,
      weight = 134,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("schnaps" = 2, "hoibe" = 1)
    )
  )
  # think about how to achieve this as simply as possible:
  testthat::expect_equal(
    tell_me_how_drunk(
      age = 38,
      sex = "M",
      height = 190,
      weight = 134,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = list("schnaps" = 1, "hoibe" = 1, "schnaps" = 2)
    ),
    tell_me_how_drunk(
      age = 38,
      sex = "m",
      height = 190,
      weight = 134,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("schnaps" = 3, "hoibe" = 1)
    )
  )
})

# anything under age < 16 not ok, hard liquor under age 18 not ok.
testthat::test_that("legal drinking age is checked", {
  testthat::expect_warning(
    tell_me_how_drunk(
      age = 14,
      sex = "female",
      height = 160,
      weight = 50,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("hoibe" = 7)
    ),
    regexp = "illegal"
  )
  testthat::expect_warning(
    tell_me_how_drunk(
      age = 17,
      sex = "female",
      height = 160,
      weight = 50,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("schnaps" = 7)
    ),
    regexp = "illegal"
  )
  testthat::expect_silent(
    tell_me_how_drunk(
      age = 17,
      sex = "female",
      height = 160,
      weight = 50,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("massn" = 2)
    )
  )
})

# testthat-functions for show_me_how_drunk()
testthat::context("show_me_how_drunk")

# an easy example works
testthat::test_that("basic implmentation is correct", {
  testthat::expect_is(
    show_me_how_drunk(
      age = 28,
      sex = "female",
      height = 165,
      weight = 60,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("hoibe" = 7),
      interval_width = as.difftime("00:10:00")
    ),
    class = c("gg", "ggplot")
  )
})

# too big value for interval_width doesn't lead to an error
# but will simply be ignored
testthat::test_that("interval_width is not forced to be applied", {
  testthat::expect_is(
    show_me_how_drunk(
      age = 28,
      sex = "female",
      height = 165,
      weight = 60,
      drinking_time = as.POSIXct(c("2016-10-03 18:00:00", "2016-10-03 22:00:00")),
      drinks = c("hoibe" = 7),
      interval_width = as.difftime(99, units = "days")
    ),
    class = c("gg", "ggplot")
  )
})
