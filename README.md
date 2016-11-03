
<!-- README.md is generated from README.Rmd. Please edit that file -->
Rmazon
======

The goal of Rmazon is to help you download product information and reviews from Amazon.com easily.

Installation
------------

You can install Rmazon from github with:

``` r
# install.packages("devtools")
devtools::install_github("56north/Rmazon")
```

### Example - product information

This is a basic example which shows you how ro get product information:

``` r
# Get product information for 'The Art of R Programming: A Tour of Statistical Software Design'

product_info <- Rmazon::get_product_info("1593273843")
```

### Example - product reviews

This is a basic example which shows you how gto et reviews:

``` r
# Get reviews for 'The Art of R Programming: A Tour of Statistical Software Design'

reviews <- Rmazon::get_reviews("1593273843")
```
