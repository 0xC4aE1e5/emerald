code = File.read("main.cr")
code = code.gsub("includes?", "include?")
File.write("windows.rb", code)
