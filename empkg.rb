require "open-uri"

URI.open("https://raw.githubusercontent.com/emerald-pl/emerald-mods/main/#{ARGV[0]}.em") {|f|
    File.write("#{ARGV[0]}.em", f.gets)
}