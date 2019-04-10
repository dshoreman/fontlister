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
    |> Enum.map(&font_string_to_map/1)
    |> Enum.sort_by(& &1[:family])
  end

  defp parse_fonts (_) do
    raise "Failed to get font list."
  end

  defp font_string_to_map (font_string) do
    font_string
    |> String.split(":")
    |> map_font()
  end

  defp map_font ([path, family, styles]) do
    %{path: path, family: family, styles: styles}
  end

  defp map_font ([path, family]) do
    %{path: path, family: family, styles: ""}
  end

  def generate do
    EEx.eval_file("template.html.eex", fonts: list(), family_style_parser: &parse_family_style/1)
  end

  defp parse_family_style(family) do
    family
    |> String.split(~r/,\s?/, trim: true)
    |> Enum.map(&"'#{&1}'")
    |> Enum.join(", ")
  end

  def export do
    "output.html"
    |> Path.expand(__DIR__)
    |> File.write!(generate())

    Logger.info("Fonts test file saved! Now run `firefox --new-tab output.html`")
  end
end

Fonts.export()
