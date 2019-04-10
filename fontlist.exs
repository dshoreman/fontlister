defmodule Fonts do
  require Logger

  @doc "Get list of system fonts from Fontconfig"
  def list do
    Logger.info "Fetching list of system fonts..."
    "fc-list"
    |> System.cmd([], stderr_to_stdout: true)
    |> parse_fonts
  end

  defp parse_fonts ({fonts, 0}) do
    fonts
    |> String.replace(":style=", ":")
    |> String.split("\n", trim: true)
    |> Enum.map(fn font -> String.split(font, ":") |> map_font() end)
  end

  defp parse_fonts (_) do
    raise "Failed to get font list."
  end

  defp map_font ([path, family, styles]) do
    Logger.debug("Found font '#{family}' at #{path}\n  Styles: #{styles}")
    %{path: path, family: family, styles: styles}
  end

  defp map_font ([path, family]) do
    Logger.debug("Found font '#{family}' without styles at #{path}")
    %{path: path, family: family, styles: ""}
  end
end

Fonts.list()
