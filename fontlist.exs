require Logger

Logger.info "Fetching list of system fonts..."
{fonts, 0} = System.cmd "fc-list", []
fonts = String.split fonts, "\n"

Logger.info "Parsing fonts..."
for font <- fonts do
  [path, family, style] = String.split font, ":"
  Logger.debug "Font Path: " <> path <> "\nFamily: " <> family <> "\nStyle: " <> style
end
