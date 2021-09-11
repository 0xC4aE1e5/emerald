code = File.read("main.cr")
code = code.gsub("includes?", "include?")
code = code.gsub("size", "length()")
File.write("windows.rb", code)
