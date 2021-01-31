# save path
path <- getwd()

# create project
devtools::create(path, check_name = FALSE, open = FALSE)

# rename project to "promillo"

# set global option for name
options(usethis.full_name = "Marc Johler")

# set licenses
usethis::use_mit_license()

# necessary packages
usethis::use_package("checkmate", type = "Imports")
usethis::use_package("testthat", type = "Suggests")

## change rest of the Description manually
# rename package to "promillo"
# set an informative title
# give information about author
# give description of what the package does

## put files into R folder and change function names according to
# fun() --> package::fun() for imported packages

# check package for current progress
devtools::check(path)

# create structure for test files
usethis::use_test("promillo-withdoc.R")
# add test file manually to corresponding folder and rename it according to
# name convention

# check package coverage
cov <- covr::package_coverage(quiet = FALSE, clean = FALSE)
covr::report(cov)

## add documentation to promillo-withdoc.R
# check with devtools
devtools::document()
# --> exported and non-exported functions become visible
# and documentations for both become available

## add show_me_how_drunk() to main script
# add ggplot2 to Imports in the DESCRIPTION
# roxygen2: import qplot from ggplot2 and import whole package checkmate
# add tests to corresponding testfile

# check if package is complete (no errors, warnings or notes)
devtools::check(path)
# check if coverage is 100% again
cov <- covr::package_coverage(quiet = FALSE, clean = FALSE)
covr::report(cov)
# --> finished
