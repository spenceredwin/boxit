#' Confirm Cancelation
#'
#' Sometimes when you ask someone for data, they don't feel like sharing.  This function helps you with this situation.
#' This provides a dialog box that confirms whether a user wants to cancel a script.  It is intended to follow an rstudio::showPrompt dialog box where the user decides to hit cancel.
#' If the user is not using RStudio, or their version of RStudio is not 1.1.67 or greater, it will use menu() to ask in the console. Because portability.
#'
#' @param cancel_title The title of the dialog box
#' @param cancel_message The message confirming if the user would like to cancel
#' @param cancel_ok The
#' @param cancel_ok User input option that will cancel the script
#' @param cancel_cancel User input option that will return FALSE
#' @param ... Used to handle arguments intended for other functions, as cancelbox() is a helper function
#' @keywords internal
#' @export
#' @examples
#' x <- showPrompt(title = "Your Name", message = "Please enter your name.", default = "Jerry")
#' if(is.null(x)) {cancelbox()}


cancelbox <- function(cancel_title = "Stop Script?",
                      cancel_message = "I'm sorry, but your input is required to proceed. Are you sure you want to stop running this script?",
                      cancel_ok = "Yes",
                      cancel_cancel = "No",
                      ...)
{
    vcheck <- rstudioapi::isAvailable(version_needed = "1.1.67")

    if(vcheck == TRUE)
    {
        stopit <- rstudioapi::showQuestion(title = cancel_title,
                                           message = cancel_message,
                                           ok = cancel_ok,
                                           cancel = cancel_cancel)
    } else
       {
            menu_choice <- menu(choices = c(cancel_ok, cancel_cancel),
                                title = cancel_message)

           if(menu_choice == 1){stopit <- TRUE} else {stopit <- FALSE}
       }

    if(stopit == TRUE)
    {
        boxit::softstop(message = "User input not provided. Script canceled by user.")
    }
}
