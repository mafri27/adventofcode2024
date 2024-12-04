muls = []
muls2 = []
STDIN.each_line do |line|
    muls += line.scan(/mul\(([0-9]{1,3}),([0-9]{1,3})\)/)
    muls2 += line.scan(/(mul\(([0-9]{1,3}),([0-9]{1,3})\))|(don't\(\))|(do\(\))/)
end
puts "########### Level 1 ################"

pp muls.map{|x| x[0].to_i * x[1].to_i }.sum

puts "########### Level 2 ################"

sum = 0
enabled = true
muls2.each do |m|
    if m[1] and m[2] and enabled
        sum += m[1].to_i * m[2].to_i
    end
    enabled = true if m[4]
    enabled = false if m[3]
end
pp sum
