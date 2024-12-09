puts "############# Start #{Time.now.inspect} ################"
antennas = {}
line_count = 0
row_count  = 0
STDIN.each_line do |line|
    line.strip.split("").each_with_index do |element , row_index|
        if element != "."
             antennas[element] = [] if not antennas[element]
             antennas[element] << [line_count , row_index ]
        end
    end
    line_count += 1
    row_count = line.strip.split("").length
end

res = []

puts "########### Level 1 #{Time.now.inspect} ################"

antennas.each_pair do |name,locations|
    locations.combination(2) do |com|
        x_dis = com[1][0] - com[0][0]
        y_dis = com[1][1] - com[0][1]
        res << [ (com[0][0] - x_dis) , (com[0][1] - y_dis)]
        res << [ (com[1][0] + x_dis) , (com[1][1] + y_dis)]
    end
end
res.delete_if do |x|
    x[0] < 0 or x[1] < 0 or x[0] >= line_count or x[1] >= row_count
end
pp res.uniq.length

puts "########### Level 2 #{Time.now.inspect} ################"

res = []
antennas.each_pair do |name,locations|
    locations.combination(2) do |com|
        x_dis = com[1][0] - com[0][0]
        y_dis = com[1][1] - com[0][1]

        a_pos = com[0][0]
        b_pos = com[0][1]
        while a_pos >= 0 and b_pos >= 0 and a_pos < line_count and b_pos < row_count
            res << [a_pos, b_pos]
            a_pos -= x_dis
            b_pos -= y_dis
        end

        a_pos = com[1][0]
        b_pos = com[1][1]
        while a_pos >= 0 and b_pos >= 0 and a_pos < line_count and b_pos < row_count
            res << [a_pos, b_pos]
            a_pos += x_dis
            b_pos += y_dis
        end
    end
end
pp res.uniq.length
puts "################### #{Time.now.inspect} ################"
