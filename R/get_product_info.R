#' Gets product info from Amazon.com
#'
#' @name get_product_info
#'
#' @param
#' productCode: The Amazon product code.
#'
#' @description
#' The function gets product info from Amazon.com for a particular product. It fetches the product title, the price, the average rating, the histogram of the reviews, reviews count and product details.
#'
#' @return
#' The function returns a list frame with product information.
#'
#' @examples
#' # Get product information for 'The Art of R Programming: A Tour of Statistical Software Design'
#'
#' product_info <- Rmazon::get_product_info("1593273843")
#'
#' @export

get_product_info <- function(productCode){

  url <- paste0("https://www.amazon.com/dp/", productCode)

  html_data <- xml2::read_html(url)

  productTitle <- rvest::html_nodes(html_data, "#productTitle")
  productTitle <- rvest::html_text(productTitle, trim = T)

  newPrice <- rvest::html_nodes(html_data, "#newOfferAccordionRow .header-price")
  newPrice <- rvest::html_text(newPrice, trim = T)

  avgRating <- rvest::html_nodes(html_data, "#avgRating")
  avgRating <- rvest::html_text(avgRating, trim = T)
  avgRating <- stringr::str_sub(avgRating, 1,3)
  avgRating <- as.numeric(avgRating)

  histogramTable <- rvest::html_nodes(html_data, "#histogramTable")
  histogramTable <- rvest::html_table(histogramTable)[[1]]
  histogramTable <- histogramTable[,c(1,3)]
  names(histogramTable) <- c("rating", "pct")

  summaryStars <- rvest::html_nodes(html_data, "#summaryStars")
  summaryStars <- rvest::html_text(summaryStars, trim = T)
  summaryStars <- stringr::str_split(summaryStars, "\n")
  summaryStars <- unlist(summaryStars)
  summaryStars <- summaryStars[2]
  summaryStars <- as.numeric(summaryStars)

  details <- rvest::html_nodes(html_data, ".content li")
  details <- rvest::html_text(details, trim = T)
  details <- details[!stringr::str_detect(details, "Average Customer Review|Amazon Best Sellers Rank")]

  details <- lapply(details, function(x){
    x <- stringr::str_replace_all(x, "\\s+", " ")
    x
  })

  info <-  list(productTitle = productTitle,
                newPrice = newPrice,
                avgRating = avgRating,
                histogramTable = histogramTable,
                reviewsCount = summaryStars,
                productDetails = details)

  return(info)

}
