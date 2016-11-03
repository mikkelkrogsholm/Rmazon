reviews_from_page <- function(scrapeurl){
  html_review_data <- xml2::read_html(scrapeurl)

  reviewRating <- rvest::html_nodes(html_review_data, "#cm_cr-review_list .review-rating")
  reviewRating <- rvest::html_text(reviewRating)
  reviewRating <- stringr::str_sub(reviewRating, 1,3)
  reviewRating <- as.numeric(reviewRating)

  reviewDate <- rvest::html_nodes(html_review_data, "#cm_cr-review_list .review-date")
  reviewDate <- rvest::html_text(reviewDate)
  reviewDate <- stringr::str_replace_all(reviewDate, "on ", "")
  reviewDate <- lubridate::parse_date_time(reviewDate, orders = "B d Y")

  reviewFormat <- rvest::html_nodes(html_review_data, ".review")

  reviewFormat <- lapply(reviewFormat, function(x){
    x <- rvest::html_nodes(x, ".a-size-mini.a-color-secondary")
    x <- rvest::html_text(x)
    x <- stringr::str_replace_all(x, "Format: ", "")
  })

  reviewFormat <- lapply(reviewFormat, function(x) {
    if(length(x) == 0) x <- NA else x
  })

  reviewFormat <- unlist(reviewFormat)

  reviewHeadline <- rvest::html_nodes(html_review_data, "#cm_cr-review_list .a-color-base")
  reviewHeadline <- rvest::html_text(reviewHeadline)

  reviewText <- rvest::html_nodes(html_review_data, "#cm_cr-review_list .review-text")
  reviewText <- rvest::html_text(reviewText)

  Verified_Purchase <- rvest::html_nodes(html_review_data, ".review-data")
  Verified_Purchase <- rvest::html_text(Verified_Purchase)
  Verified_Purchase <- Verified_Purchase[seq(1, 20, by = 2)]
  Verified_Purchase <- stringr::str_detect(Verified_Purchase, "Verified Purchase")
  Verified_Purchase <- na.omit(Verified_Purchase)

  reviews <- dplyr::data_frame(reviewRating, reviewDate, reviewFormat,
                               Verified_Purchase, reviewHeadline, reviewText)

  return(reviews)
}



