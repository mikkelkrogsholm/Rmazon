#' Gets reviews from Amazon
#'
#' @name get_reviews
#'
#' @param
#' productCode: The Amazon product code.
#'
#' @param
#' domain: Domain to use if searching other sites than .com. See \code{\link{domains}} for available domains.
#'
#' @description
#' The function gets reviews from Amazon for a particular product. It fetches the rating, the date of the review, the format if it is book, if the purchase was verified or not, the headline and the text of the review.
#'
#' @return
#' The function returns a data frame with reviews.
#'
#' @examples
#' # Get reviews for 'The Art of R Programming: A Tour of Statistical Software Design'
#'
#' reviews <- Rmazon::get_reviews("1593273843")
#'
#' @export

get_reviews <- function(productCode, domain = "com"){

  url <- paste0("http://www.amazon.", domain,"/product-reviews/", productCode)

  html_data <- xml2::read_html(url)

  totalReviewCount <- rvest::html_nodes(html_data, ".totalReviewCount")
  totalReviewCount <- rvest::html_text(totalReviewCount)
  totalReviewCount <- stringr::str_extract_all(totalReviewCount, "\\d+")
  totalReviewCount <- as.numeric(totalReviewCount)

  bookTitle <- rvest::html_nodes(html_data, ".a-col-right h1")
  bookTitle <- rvest::html_text(bookTitle)

  message(paste0("Fetching ", totalReviewCount, " reviews of '", bookTitle, "'"))

  pagecount <- ceiling(totalReviewCount/10)

  ################################################################################


  reviews <- pbapply::pblapply(1:pagecount, function(i){
    scrapeurl <- paste0(url,"/?pageNumber=", i)
    reviews <- reviews_from_page(scrapeurl)
  })

  all_reviews <- do.call(rbind, reviews)

  return(all_reviews)
}
