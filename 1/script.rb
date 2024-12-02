x = []
y = []

STDIN.each_line do |line|
    line.scan(/([0-9]+) *([0-9]+)/).each{|b| x << b[0].to_i ; y << b[1].to_i }
end

puts "########### Level 1 ################"

x.sort!
y.sort!

all = 0

0.upto(x.length - 1) do |c|
    all  += (x[c] - y[c]).abs
end
pp all

puts "########### Level 2 ################"

all = 0

x.each do |c|
    all  += ( c * y.count(c) )
end
pp all





