
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

This is a basic example which shows you how to get product information:

``` r
# Get product information for 'The Art of R Programming: A Tour of Statistical Software Design'
product_info <- Rmazon::get_product_info("1593273843")

# Have a look at the data
product_info
#> $productTitle
#> [1] "The Art of R Programming: A Tour of Statistical Software Design"
#> 
#> $newPrice
#> [1] "$32.12"
#> 
#> $avgRating
#> [1] 4.4
#> 
#> $histogramTable
#>   rating pct
#> 1 5 star 64%
#> 2 4 star 19%
#> 3 3 star 11%
#> 4 2 star  3%
#> 5 1 star  3%
#> 
#> $reviewsCount
#> [1] 122
#> 
#> $productDetails
#> $productDetails[[1]]
#> [1] "Paperback: 400 pages"
#> 
#> $productDetails[[2]]
#> [1] "Publisher: No Starch Press; 1 edition (October 15, 2011)"
#> 
#> $productDetails[[3]]
#> [1] "Language: English"
#> 
#> $productDetails[[4]]
#> [1] "ISBN-10: 1593273843"
#> 
#> $productDetails[[5]]
#> [1] "ISBN-13: 978-1593273842"
#> 
#> $productDetails[[6]]
#> [1] "Product Dimensions: 7 x 1.2 x 9.2 inches"
#> 
#> $productDetails[[7]]
#> [1] "Shipping Weight: 1.7 pounds (View shipping rates and policies)"
#> 
#> $productDetails[[8]]
#> [1] "Average Customer Review: function acrPopoverHover(e, h) { if(h) window.acrAsinHover = e; else if(window.acrAsinHover == e) window.acrAsinHover = null; } function popoverReady(jQuery) { if((typeof jQuery === \"undefined\") || (typeof jQuery.fn === \"undefined\")) { return; } else if(jQuery.fn.acrPopover) { return; } var popoverConfig = { showOnHover:true, showCloseButton: true, width: null, location:'bottom', locationAlign:'left', locationOffset:[-20,0], paddingLeft: 15, paddingBottom: 5, paddingRight: 15, group: 'reviewsPopover', clone:false, hoverHideDelay:300 }; jQuery.fn.acrPopover = function() { return this.each(function() { var $this = jQuery(this); if(!$this.data('init') && typeof $this.amazonPopoverTrigger === 'function') { $this.data('init', 1); var getargs = $this.attr('getargs'); var ajaxURL = '/gp/customer-reviews/common/du/displayHistoPopAjax.html?' + '&ASIN=' + $this.attr('name') + '&link=1' + '&seeall=1' + '&ref=' + $this.attr('ref') + ((typeof getargs != 'undefined') ? ('&getargs=' + getargs) : ''); var myConfig = jQuery.extend(true, { destination: ajaxURL }, popoverConfig); $this.amazonPopoverTrigger(myConfig); var w = window.acrAsinHover; if(w && jQuery(w).parents('.asinReviewsSummary').get(0) == this) { $this.trigger('mouseover.amzPopover'); window.acrAsinHover = null; } } }); }; window.reviewHistPopoverConfig = popoverConfig; var jqInit = window.jQueryInitHistoPopovers = function(asin) { if (typeof jQuery('.acr-popover[name=' + asin + ']').acrPopover === 'function') { jQuery('.acr-popover[name=' + asin + ']').acrPopover(); } }; window.doInit_average_customer_reviews = jqInit; window.onAjaxUpdate_average_customer_reviews = jqInit; window.onCacheUpdate_average_customer_reviews = jqInit; window.onCacheUpdateReselect_average_customer_reviews = jqInit; if (typeof P !== 'undefined') { P.when('amznJQ.criticalFeature').execute(\"amznJQ.criticalFeatureComplete\", function() { setTimeout(function() { P.register('acrPopover', function () { return window.arcPopover; }); }, 10); }); } else if (typeof amznJQ !== 'undefined') { amznJQ.onCompletion('amznJQ.criticalFeature', function() { setTimeout(function() { amznJQ.declareAvailable('acrPopover'); }, 10); }); } }; function acrPopoverReady(jQuery) { jQuery('.acr-popover,#searchTemplate .asinReviewsSummary').each(function() { if (typeof jQuery(this).acrPopover === 'function') { jQuery(this).acrPopover(); } }); }; if (typeof P !== 'undefined') { var jq = null; if (typeof $ !== 'undefined') { jq = $; } else if (typeof jQuery !== 'undefined') { jq = jQuery; } if (jq) { P.when('popover', 'ready').execute(popoverReady(jq)); P.when('acrPopover', 'ready').execute(acrPopoverReady(jq)); } } else if ((typeof amznJQ !== 'undefined') && (typeof jQuery !== 'undefined')) { amznJQ.onReady('popover', popoverReady, jQuery); amznJQ.onReady('acrPopover', acrPopoverReady, jQuery); }; 4.4 out of 5 stars See all reviews (122 customer reviews)"
#> 
#> $productDetails[[9]]
#> [1] "Amazon Best Sellers Rank: #34,346 in Books (See Top 100 in Books) .zg_hrsr { margin: 0; padding: 0; list-style-type: none; } .zg_hrsr_item { margin: 0 0 0 10px; } .zg_hrsr_rank { display: inline-block; width: 80px; text-align: right; } #14 in Books > Computers & Technology > Software > Mathematical & Statistical #44 in Books > Textbooks > Science & Mathematics > Mathematics > Statistics #91 in Books > Science & Math > Mathematics > Applied > Probability & Statistics"
#> 
#> $productDetails[[10]]
#> [1] "#14 in Books > Computers & Technology > Software > Mathematical & Statistical"
#> 
#> $productDetails[[11]]
#> [1] "#44 in Books > Textbooks > Science & Mathematics > Mathematics > Statistics"
#> 
#> $productDetails[[12]]
#> [1] "#91 in Books > Science & Math > Mathematics > Applied > Probability & Statistics"
```

Lets get the same information, but from the **german** Amazon

``` r
# Find the appropriate domain
Rmazon::domains$Germany
#> $url
#> [1] "https://www.amazon.de"
#> 
#> $domain
#> [1] "de"

# Then use domain to get german data
product_info_de <- Rmazon::get_product_info("1593273843", domain = "de")
```

### Example - product reviews

This is a basic example which shows you how to get reviews:

``` r
# Get reviews for 'The Art of R Programming: A Tour of Statistical Software Design'
reviews <- Rmazon::get_reviews("1593273843")
#> Fetching 122 reviews of 'The Art of R Programming: A Tour of Statistical Software Design'

# Have a look at the data
reviews
#> # A tibble: 122 × 6
#>    reviewRating        reviewDate reviewFormat Verified_Purchase
#> *         <dbl>             <chr>        <chr>             <lgl>
#> 1             5  November 4, 2011    Paperback              TRUE
#> 2             5  October 30, 2011    Paperback             FALSE
#> 3             4  January 15, 2012    Paperback              TRUE
#> 4             3      July 6, 2012    Paperback              TRUE
#> 5             5  November 1, 2011    Paperback             FALSE
#> 6             3  January 28, 2014    Paperback              TRUE
#> 7             1    March 18, 2015    Paperback              TRUE
#> 8             5 November 28, 2011    Paperback             FALSE
#> 9             3    March 20, 2013    Paperback              TRUE
#> 10            3    April 24, 2013    Paperback             FALSE
#> # ... with 112 more rows, and 2 more variables: reviewHeadline <chr>,
#> #   reviewText <chr>
```

Lets get the same information, but from the **french** Amazon

``` r
# Find the appropriate domain
Rmazon::domains$France
#> $url
#> [1] "https://www.amazon.fr"
#> 
#> $domain
#> [1] "fr"

# Then use domain to get german data
reviews_fr <- Rmazon::get_reviews("1593273843", domain = "fr")
#> Fetching 2 reviews of 'The Art of R Programming - A Tour of Statistical Software Design'
```
