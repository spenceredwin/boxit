#' Notification Dialog Box
#'
#' This function is a wrapper for the showDialog function in rstudioapi.
#' The difference is that if the user is not using RStudio, or their version of RStudio is not 1.1.67 or greater, it will use readline to print the message to the console.  Because portability.
#'
#' @param title The title for the dialog box
#' @param message The message for the dialog box
#'
#' @keywords boxit
#' @export
#' @examples
#' dialogbox(title = "Warning", message = "Danger Will Robinson!")


dialogbox <- function(title, message)
{
    vcheck <- rstudioapi::isAvailable(version_needed = "1.1.67")

    if(vcheck == TRUE)
    {
        rstudioapi::showDialog(title = title,
                                 message = message)
    } else
        {
          readline(prompt = paste(message, "Press ENTER to continue."))
        }
}
