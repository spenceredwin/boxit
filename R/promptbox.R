#' Freehand User Input Box
#'
#' Sometimes you need some info from the user.  You could ask in the console, but that's easy to miss.  Why not use a prompt in RStudio!
#' promptbox() provides a dialog box to get freehand user input.  Of course, so does rstudioapi::showPrompt().
#' But what makes promptbox() special is that has built in dialog boxes to confirm the user's input.
#' It also has a built in check so that if the user hits cancel, it will confirm they really meant to do so.
#' If the user does cancel, it will also cancel the script so that it does not run forward and error like crazy because it is missing vital input.
#' If the user is not using RStudio, or their version of RStudio is not 1.1.67 or greater, it will use readline() to ask in the console.  Because portability.
#'
#' @param title The title of the input box
#' @param message The message asking for user input
#' @param default The default value that is pre-populated in the input box.  Default is "".
#' @param confirm Set confirm = FALSE in order to disable the confirmation step.  Default is TRUE.
#' @param ... Additional arguments to pass to confirmbox and cancelbox
#' @keywords boxit
#' @export
#' @examples
#' x <- promptbox(title = "Name Please", message = "What's your name?", default = "Jerry")


promptbox <- function(title, message, default = "", confirm = TRUE, ...)
{
    vcheck <- rstudioapi::isAvailable(version_needed = "1.1.67")

    confirm_value <- FALSE
    value <- NULL

    while(confirm_value == FALSE)
    {
        while(is.null(value))
        {
            if(vcheck == TRUE)
            {
                value <- rstudioapi::showPrompt(title = title,
                                                message = message,
                                                default = default)

                if(is.null(value)) {boxit::cancelbox(...)}

            } else
                {
                    value <- readline(prompt = message)
                }
        }

        if(confirm == TRUE)
        {
            confirm_value <- boxit::confirmbox(value, ...)
            if(confirm_value == FALSE) {value <- NULL}
        } else {confirm_value = TRUE}
    }

    return(value)
}
