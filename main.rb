def readprog(codet, varlist)
    lines = codet.split("\n")
    lines.each do |line|
    line = line.gsub("\r", "")
    tok = line.split(" ")
    if tok[0] == "print"
        puts tok[1..-1].join(" ")
        elsif tok[0] == "add"
            varlist["add"] = "#{tok[1].to_f + tok[2].to_f}"
        elsif tok[0] == "subtract"
            varlist["subtract"] = "#{tok[1].to_f - tok[2].to_f}"
        elsif tok[0] == "multiply"
            varlist["multiply"] = "#{tok[1].to_f * tok[2].to_f}"
        elsif tok[0] == "divide"
            varlist["divide"] = "#{tok[1].to_f / tok[2].to_f}"
        elsif tok[0] == "input"
            print tok[1..-1].join(" ")
            print " "
            varlist["input"] = gets.to_s
        elsif tok[0] == "if"
            code = tok[4..-1].join(" ").gsub(";", "\n").split(" else ")
            if code.length() == 1
                if tok[2] == "is"
                    if tok[1] == tok[3]
                        readprog(code[0], varlist)
                    end
                elsif tok[2] == "not"
                    if tok[1] != tok[3]
                        readprog(code[0], varlist)
                    end
                end
            else
                if tok[2] == "is"
                    if tok[1] == tok[3]
                        readprog(code[0], varlist)
                    else
                        readprog(code[1], varlist)
                    end
                elsif tok[2] == "not"
                    if tok[1] != tok[3]
                        readprog(code[0], varlist)
                    else
                        readprog(code[1], varlist)
                    end
                end
            end
        elsif tok[0] == "loop"
            while true
                readprog(tok[1..-1].join(" ").gsub(";", "\n"), varlist)
            end
        elsif tok[0] == "variable"
            varlist[tok[1]] = tok[2..-1].join(" ").gsub(";", "\n")
        elsif tok[0] == "usevariable"
            var = varlist[tok[1]]
            fixedcode1 = tok[2..-1].join(" ")
            fixedcode = fixedcode1.gsub("@", var)
            readprog(fixedcode, varlist)
        elsif tok[0] == "system"
            system tok[1..-1].join(" ")
        elsif tok[0] == "rubycode"
            eval tok[1..-1].join(" ")
        elsif tok[0] == "require"
            mod = File.read("#{tok[1]}.em")
            readprog(mod, varlist)
        elsif tok[0] == "function"
            varlist[tok[1]] = tok[2..-1].join(" ").gsub(";", "\n")
        elsif tok[0] == "call"
            readprog(varlist[tok[1]], varlist)
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
        print "=> "
        code = gets.to_s
        readprog(code, vars)
    end
end
