filename = ARGV[0]
code = File.read(filename)
def readprog(codet)
    lines = codet.split("\n")
    lines.each do |line|
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
        elsif tok[0] == "if"
            if tok[2] == "is"
                if tok[1] == tok[3]
                    readprog(tok[4..-1].join(" "))
                end
            elsif tok[2] == "not"
                if tok[1] != tok[3]
                    readprog(tok[4..-1].join(" "))
                end
            end
        elsif tok[0] == "lop"
            while true
                readprog(tok[1..-1].join(" "))
            end
        end
    end
end
readprog(code)