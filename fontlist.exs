require Logger

Logger.info "Fetching list of system fonts..."
{fonts, retval} = System.cmd "fc-list", []
fonts = String.split fonts, "\n"

IO.inspect fonts
