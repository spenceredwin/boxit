#' Password Input Box
#'
#' Sometimes you need some info from the user.  You could ask in the console, but that's easy to miss.  Why not use a prompt in RStudio!
#' passbox() provides an input box to get a password using blinded characters.  Of course, so does rstudioapi::askForPassword().
#' But what makes passbox() different is that it has a built in check so that if the user hits cancel, it will confirm they really meant to do so.
#' If the user does cancel, it will also cancel the script so that it does not run forward and error like crazy because it is missing vital input.
#' If the user is not using RStudio, or their version of RStudio is not 1.1.67 or greater, it will use readline() to ask in the console.  Because portability.
#'
#' @param prompt The message you would like displayed in the input box
#' @param ... Additional arguments to pass to cancelbox
#' @keywords boxit
#' @export
#' @examples
#' x <- passbox(prompt = "Please enter your social security and bank account numbers")


passbox <- function(prompt, ...)
{
    vcheck <- rstudioapi::isAvailable(version_needed = "1.1.67")

    value <- NULL

    while(is.null(value))
    {
        if(vcheck == TRUE)
        {
            value <- rstudioapi::askForPassword(prompt = prompt)

            if(is.null(value)) {boxit::cancelbox(...)}

        } else
            {
                value <- readline(prompt = prompt)
            }
    }

    return(value)
}
