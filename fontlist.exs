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
    |> String.replace(~r/:(\s|style=)/, ":")
    |> String.split("\n", trim: true)
    |> Enum.map(fn font -> String.split(font, ":") |> map_font() end)
    |> Enum.sort_by(&Map.fetch(&1, :family))
  end

  defp parse_fonts (_) do
    raise "Failed to get font list."
  end

  defp map_font ([path, family, styles]) do
    %{path: path, family: family, styles: styles}
  end

  defp map_font ([path, family]) do
    %{path: path, family: family, styles: ""}
  end

  def generate do
    "template.html.eex"
    |> EEx.eval_file(fonts: list())
  end

  def export do
    "output.html"
    |> Path.expand(__DIR__)
    |> File.write!(generate())

    Logger.info("Fonts test file saved! Now run `firefox --new-tab output.html`")
  end
end

Fonts.export()
