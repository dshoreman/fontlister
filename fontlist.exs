require Logger

Logger.info "Fetching list of system fonts..."
{fonts, 0} = System.cmd "fc-list", []
fonts = String.split fonts, "\n"

IO.inspect fonts
