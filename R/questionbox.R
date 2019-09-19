#' Question Box
#'
#' Sometimes you need some info from the user.  You could ask in the console, but that's easy to miss.  Why not use a dialog box in RStudio!
#' questionbox() provides a pop up box to get user input as a binary (yes/no) response to a question.  Of course, so does rstudioapi::showQuestion().
#' But what makes questionbox() special is that has built in dialog boxes to confirm the user's input.
#' It also has a built in check so that if the user hits cancel, it will confirm they really meant to do so.
#' If the user is not using RStudio, or their version of RStudio is not 1.1.67 or greater, it will use readline() to ask in the console.  Because portability.
#'
#' @param title The title of the question box
#' @param message The question asking for user input
#' @param ok The positive ("yes") response value.  Default is "Yes"
#' @param no The negative ("no") response value.  Default is "No"
#' @param logical Option to return either a logical value (TRUE / FALSE) or the ok/cancel value.  TRUE returns logical. Default is TRUE
#' @param confirm Set confirm = FALSE in order to disable the confirmation step.  Default is TRUE
#' @param ... Additional arguments to pass to confirmbox and cancelbox
#' @keywords boxit
#' @export
#' @examples
#' x <- questionbox(title = "Would you like to buy a monkey?", ok = "Sure!", cancel = "No Way!")


questionbox <- function(title, message, ok = "Yes", cancel = "No", logical = TRUE, confirm = TRUE, ...)
{
  vcheck <- rstudioapi::isAvailable(version_needed = "1.1.67")

  confirm_value <- FALSE

  while(confirm_value == FALSE)
  {
      if(vcheck == TRUE)
      {
          value <- rstudioapi::showQuestion(title = title,
                                            message = message,
                                            ok = ok,
                                            cancel = cancel)
      } else
      {
        value <- readline(prompt = message)
      }

    actual_value <- if(value == TRUE) {ok} else {cancel}

    if(confirm == TRUE)
    {
      confirm_value <- boxit::confirmbox(actual_value)
    } else {confirm_value = TRUE}

  }

  if(logical == TRUE) {return(value)} else {return(actual_value)}
}

