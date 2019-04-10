defmodule Fonts do
  require Logger

  @doc "Get list of system fonts from Fontconfig"
  def list do
    Logger.info "Fetching list of system fonts..."
    {fonts, 0} = System.cmd "fc-list", []
    fonts = String.split fonts, "\n"

    Logger.info "Parsing fonts..."
    for font <- fonts do
      [path, family, style] = String.split font, ":"
      Logger.debug "Font Path: " <> path <> "\nFamily: " <> family <> "\nStyle: " <> style
    end
  end
end

Fonts.list()
