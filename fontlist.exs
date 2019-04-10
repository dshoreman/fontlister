defmodule Fonts do
  require Logger

  @doc "Get list of system fonts from Fontconfig"
  def list do
    Logger.info "Fetching list of system fonts..."
    fonts = "fc-list"
    |> System.cmd([], stderr_to_stdout: true)
    |> split_lines

    Logger.info "Parsing fonts..."
    for font <- fonts do
      [path, family, style] = String.split font, ":"
      Logger.debug "Font Path: " <> path <> "\nFamily: " <> family <> "\nStyle: " <> style
    end
  end

  defp split_lines ({fonts, 0}) do
    String.split(fonts, "\n")
  end

  defp split_lines (_) do
    raise "Failed to get font list."
  end
end

Fonts.list()
