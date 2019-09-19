#' Stop a Script
#'
#' A helper function that temporarily sets options(error = NULL) to stop the script without calling error handling
#'
#' @param message An error message to print when the script is stopped.  Default is NULL.
#' @keywords internal
#' @export
#' @examples
#' softstop(message = "User stopped script")

softstop <- function(message = NULL)
{
  #get existing error options
  error_opt <- getOption("error")

  #turn off error handling
  options(error = NULL)

  #reset error options after script stops
  on.exit(options(error = error_opt))

  #stop the script and print the error message
  stop(message, call. = FALSE)
}
