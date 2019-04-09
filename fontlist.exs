IO.puts "Font List Script\n"
System.cmd "fc-list", [], into: IO.stream(:stdio, :line)
