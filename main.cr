def readprog(codet, varlist)
    lines = codet.split("\n")
    lines.each do |line|
    if line.includes? "var"
		line = line.gsub(";", "\n")
    end
    tok = line.split(" ")
    if tok[0] == "say"
        puts tok[1..-1].join(" ")
        elsif tok[0] == "add"
            puts tok[1].to_f + tok[2].to_f
        elsif tok[0] == "stt"
            puts tok[1].to_f - tok[2].to_f
        elsif tok[0] == "mpy"
            puts tok[1].to_f * tok[2].to_f
        elsif tok[0] == "div"
            puts tok[1].to_f / tok[2].to_f
        elsif tok[0] == "inp"
            print tok[1..-1].join(" ")
            print " "
            varlist["inp"] = gets.to_s
        elsif tok[0] == "if"
            if tok[2] == "is"
                if tok[1] == tok[3]
                    readprog(tok[4..-1].join(" "), varlist)
                end
            elsif tok[2] == "not"
                if tok[1] != tok[3]
                    readprog(tok[4..-1].join(" "), varlist)
                end
            end
        elsif tok[0] == "lop"
            while true
                readprog(tok[1..-1].join(" "), varlist)
            end
        elsif tok[0] == "var"
            varlist[tok[1]] = tok[2..-1].join(" ")
        elsif tok[0] == "uvr"
            var = varlist[tok[1]]
            fixedcode1 = tok[2..-1].join(" ")
            fixedcode = fixedcode1.sub("@", var)
            readprog(fixedcode, varlist)
        elsif tok[0] == "scl"
            system tok[1..-1].join(" ")
        end
    end
end
vars = {"null" => ""}
begin
    filename = ARGV[0]
    code = File.read(filename)
    readprog(code, vars)
rescue
    puts "blang REPL"
    while true
        print "=> "
        code = gets.to_s
        readprog(code, vars)
    end
end
