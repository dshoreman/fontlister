IO.puts "Font List Script\n"
{fonts, retval} = System.cmd "fc-list", []
fonts = String.split fonts, "\n"

IO.inspect fonts
