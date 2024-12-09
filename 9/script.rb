puts "############# Start #{Time.now.inspect} ################"
data  = []
data2 = []
STDIN.each_line do |line|
    line.strip.split("").each_with_index do |element , row_index|
        if row_index.odd?
            data += ([nil] * element.to_i )
        else
            data2 << { :name => (row_index / 2) , :length => element.to_i  , :pos => data.length , :tried => false }
            data  += ( [ (row_index / 2) ] * element.to_i )
        end
    end
end

puts "########### Level 1 #{Time.now.inspect} ################"
while data.include?(nil)
    pos = data.index(nil)
    while data.last == nil
        data.delete_at(-1)
    end
    data[pos] = data.last
    data.delete_at(-1)
end

checksum = 0
data.each_with_index do |element , row_index|
    checksum += (element * row_index)
end
pp checksum

puts "########### Level 2 #{Time.now.inspect} ################"
pp data2

x = data2.length - 1
while x > 0
    if data2[x][:tried] == false
        a = data2[x]
        a[:tried] = true
        (data2.length - 1).times do |y|
            gap_s = data2[y][:pos] + data2[y][:length]
            gap_e = data2[y+1][:pos]
            gap = gap_e - gap_s
            if gap >= a[:length] and gap_s < a[:pos]
                a[:pos] = gap_s
                data2.insert( y+1 , a)
                data2.delete_at(x+1)
                x += 1
            end
        end
    end
    pp x
    x -= 1
end

checksum = 0
data2.each do |x|
    x[:length].times do |y|
        checksum += (x[:name] * (x[:pos] + y))
    end
end

pp checksum
puts "################### #{Time.now.inspect} ################"
