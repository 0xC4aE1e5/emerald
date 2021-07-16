ps = ARGV[0]

system "python #{ps} > /tmp/py2em.out"
olines = File.read("/tmp/py2em.out").split("\n")
olines.each do |oline|
    if oline == ""
        false
    else
        puts "say #{oline}"
    end
end