#' Confirm Data Entry
#'
#' This function provides a dialog box in RStudio to confirm a value entered by the user from a previous entry.
#' If the user is not using RStudio, or their version of RStudio is not 1.1.67 or greater, it will use menu() to ask in the console.  Because portability.
#'
#' @param input The value provided by the user from a previous prompt
#' @param confirm_title The title of the dialog box
#' @param confirm_message_a The part of the message that goes before the input to be verified
#' @param confirm_message_b The part of the message that goes after the input to be verified
#' @param confirm_ok User input option that will return TRUE
#' @param confirm_cancel User input option that will return FALSE
#' @param ... Used to handle arguments intended for other functions, as confirmbox() is a helper function
#' @keywords internal
#' @export
#' @examples
#' x <- showPrompt(title = "Your Name", message = "Please enter your name.", default = "Jerry")
#' confirmbox(input = x)


confirmbox <- function(input,
                       confirm_title = "Confirm Entry",
                       confirm_message_a = "You entered",
                       confirm_message_b = ". Is this correct?",
                       confirm_ok = "Yes",
                       confirm_cancel = "No",
                       ...)
{
    vcheck <- rstudioapi::isAvailable(version_needed = "1.1.67")

    if(vcheck == TRUE)
    {
        rstudioapi::showQuestion(title = confirm_title,
                                 message = paste(confirm_message_a, input, confirm_message_b, sep=" "),
                                 ok = confirm_ok,
                                 cancel = confirm_cancel)
    } else
        {
            menu_choice <- menu(choices = c(confirm_ok, confirm_cancel),
                                title = paste(confirm_message_a, input, confirm_message_b, sep =))

            if(menu_choice == 1){TRUE} else {FALSE}
        }
}
