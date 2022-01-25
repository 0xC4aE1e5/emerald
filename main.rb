require 'open-uri'

$functions = {}
def readprog(codet, varlist)
	lines = codet.split("\n")
	lines.each do |line|
		line = line.gsub("\r", "")
		tok = line.split(" ")
		# tok vs args.
		# args is for Ruby extensions, and tok is for built-in functions
		if tok[0] == "print:"
			puts tok[1..-1].join(" ")
		elsif tok[0] == "add:"
			varlist["add"] = "#{tok[1].to_f + tok[2].to_f}"
		elsif tok[0] == "subtract:"
			varlist["subtract"] = "#{tok[1].to_f - tok[2].to_f}"
		elsif tok[0] == "multiply:"
			varlist["multiply"] = "#{tok[1].to_f * tok[2].to_f}"
		elsif tok[0] == "divide:"
			varlist["divide"] = "#{tok[1].to_f / tok[2].to_f}"
		elsif tok[0] == "input:"
			print tok[1..-1].join(" ")
			print " "
			varlist["input"] = gets.to_s
		elsif tok[0] == "if:"
			code = tok[4..-1].join(" ").gsub(";", "\n").split(" else: ")
			if code.length() == 1
				if tok[2] == "is:"
					if tok[1] == tok[3]
						readprog(code[0], varlist)
					end
				elsif tok[2] == "not:"
					if tok[1] != tok[3]
						readprog(code[0], varlist)
					end
                elsif tok[2] == "greater:"
                    if tok[1].to_f > tok[3].to_f
                        readprog(code[0], varlist)
                    end
                elsif tok[2] == "less:"
                    if tok[1].to_f < tok[3].to_f
                        readprog(code[0], varlist)
                    end
                elsif tok[2] == "greaterequal:"
                    if tok[1].to_f >= tok[3].to_f
                        readprog(code[0], varlist)
                    end
                elsif tok[2] == "lessequal:"
                    if tok[1].to_f <= tok[3].to_f
                        readprog(code[0], varlist)
                    end
				end
			else
				if tok[2] == "is:"
					if tok[1] == tok[3]
						readprog(code[0], varlist)
					else
						readprog(code[1], varlist)
					end
				elsif tok[2] == "not:"
					if tok[1] != tok[3]
						readprog(code[0], varlist)
					else
						readprog(code[1], varlist)
					end
                elsif tok[2] == "greater:"
                    if tok[1].to_f > tok[3].to_f
                        readprog(code[0], varlist)
                    else
                        readprog(code[1], varlist)
                    end
                elsif tok[2] == "less:"
                    if tok[1].to_f < tok[3].to_f
                        readprog(code[0], varlist)
                    else
                        readprog(code[1], varlist)
                    end
                elsif tok[2] == "greaterequal:"
                    if tok[1].to_f >= tok[3].to_f
                        readprog(code[0], varlist)
                    else
                        readprog(code[1], varlist)
                    end
                elsif tok[2] == "lessequal:"
                    if tok[1].to_f <= tok[3].to_f
                        readprog(code[0], varlist)
                    else
                        readprog(code[1], varlist)
                    end
				end
			end
		elsif tok[0] == "loop:"
			while true
				readprog(tok[1..-1].join(" ").gsub(";", "\n"), varlist)
			end
		elsif tok[0] == "variable:"
			varlist[tok[1]] = tok[2..-1].join(" ").gsub(";", "\n")
		elsif tok[0] == "usevariable:"
			var = varlist[tok[1]]
			fixedcode1 = tok[2..-1].join(" ")
			fixedcode = fixedcode1.gsub("{}", var)
			readprog(fixedcode, varlist)
		elsif tok[0] == "system:"
			system tok[1..-1].join(" ")
		elsif tok[0] == "rubycode:"
			eval tok[1..-1].join(" ")
		elsif tok[0] == "require:"
			mod = File.read("#{tok[1]}.em")
			readprog(mod, varlist)
		elsif tok[0] == "function:"
			$functions[tok[1] + ":"] = tok[2..-1].join(" ").gsub(";", "\n")
		elsif tok[0] == "call:"
			readprog(varlist[tok[1]], varlist)
		elsif tok[0] == "list:"
			varlist[tok[1]] = tok[2..-1]
		elsif tok[0] == "for:"
			varlist[tok[1]].each do |element|
				readprog(tok[2..-1].join(" ").gsub(";", "\n").gsub("{}", element).to_s, varlist)
			end
		elsif tok[0] == "write:"
			File.write(tok[1], tok[2..-1].join(" "))
		elsif tok[0] == "append:"
			File.write(tok[1], "#{File.read(tok[1])}#{tok[2..-1].join(" ")}")
		elsif tok[0] == "appendline:"
			File.write(tok[1], "#{File.read(tok[1])}\n#{tok[2..-1].join(" ")}")
		elsif tok[0] == "read:"
			varlist["read"] = File.read(tok[1])
		elsif tok[0] == "range:"
			varlist["range"] = ("0"..tok[1]).to_a
		elsif tok[0] == "rubyext:"
			args = tok[2..-1]
			eval File.read(tok[1]) 
		elsif tok[0] == "pkginstall:"
			def downloadFile(url)
				URI.open(url) { |f| return f.read }
			end
			print "Saving package..."
			# create a slash spinner
			spinner = Thread.new {
				while true
					print "."
					sleep 0.05
				end
			}
			begin
				File.write "#{tok[1]}.em", downloadFile("https://codeberg.org/brahma/emerald-libs-exts/raw/branch/main/#{tok[1]}.em")
			rescue => exception
				File.write "#{tok[1]}.rb", downloadFile("https://codeberg.org/brahma/emerald-libs-exts/raw/branch/main/#{tok[1]}.rb")
			end
			spinner.kill
			print "\b "
			puts "Done!"
		elsif tok[0].start_with?("#")
			0
        elsif tok[0] == "getindex:"
            varlist["getindex"] = varlist[tok[1]][tok[2].to_i]
		elsif $functions.key?(tok[0])
			readprog($functions[tok[0]], varlist)
		else
			puts "Error: #{tok[0]} is not a valid function."
		end
	end
end
vars = {"junk" => ""}
begin
	filename = ARGV[0]
	code = File.read(filename)
	readprog(code, vars)
rescue
	puts "Emerald REPL"
	while true
		print "λ "
		code = $stdin.gets
		readprog(code, vars)
	end
end
