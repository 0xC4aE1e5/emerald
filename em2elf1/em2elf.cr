ps = ARGV[0]
oe = ARGV[1]

system "emerald #{ps} > /tmp/em2elf.txt.out"
system "echo '#!/bin/bash' > /tmp/em2elf.elf.out"
olines = File.read("/tmp/em2elf.txt.out").split("\n")
olines.each do |oline|
    if oline == ""
        false
    else
        system "echo 'echo #{oline}' >> /tmp/em2elf.elf.out"
    end
end
system "cp -f /tmp/em2elf.elf.out ."
system "shc -f em2elf.elf.out"
system "rm -f *.x.c em2elf.elf.out"
system "mv *.x #{oe}"