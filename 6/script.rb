class Set
    def initialize(data)
        @data = Marshal.load(Marshal.dump(data))
    end
    def print
        @data.each do |line|
            puts "'" + line.join + "'"
        end
    end
    def get_data
        return @data
    end
    def walk
        l_index = nil
        c_index = nil
        cell_count = {}
        @data.each_with_index do |line, li|
            line.each_with_index do |cell, ci|
                cell_count[ li.to_s + "_" + ci.to_s ] = 0
                if [ "^" , "v" , "<" , ">" ].include?(cell)
                    l_index = li
                    c_index = ci
                end
            end
        end
        return "no sec" if not l_index

        while true
            cell = @data[l_index][c_index]
            if cell == "^"
                if l_index == 0
                    cell.replace('X')
                    return ""
                elsif @data[l_index - 1][c_index] == "#"
                    cell.replace('>')
                else
                    @data[l_index - 1][c_index] = "^"
                    cell_count[ l_index.to_s + "_" + c_index.to_s ] += 1
                    l_index -= 1
                    cell.replace("X")
                end
            end
            if cell == "v"
                if l_index == @data.length - 1
                    cell.replace('X')
                    return ""
                elsif @data[l_index + 1][c_index] == "#"
                    cell.replace('<')
                else
                    @data[l_index + 1][c_index] = "v"
                    cell_count[ l_index.to_s + "_" + c_index.to_s ] += 1
                    l_index += 1
                    cell.replace("X")
                end
            end
            if cell == "<"
                if c_index == 0
                    cell.replace('X')
                    return ""
                elsif @data[l_index][c_index - 1 ] == "#"
                    cell.replace('^')
                else
                    @data[l_index][c_index - 1] = "<"
                    cell_count[ l_index.to_s + "_" + c_index.to_s ] += 1
                    c_index -= 1
                    cell.replace("X")
                end
            end
            if cell == ">"
                if c_index == @data.first.length - 1
                    cell.replace('X')
                    return ""
                elsif @data[l_index][c_index + 1 ] == "#"
                    cell.replace('v')
                else
                    @data[l_index][c_index + 1] = ">"
                    cell_count[ l_index.to_s + "_" + c_index.to_s ] += 1
                    c_index += 1
                    cell.replace("X")
                end
            end
            return "loop" if cell_count.values.include?(5)

        end
    end
    def count
        return @data.flatten.count('X')
    end
end

game = nil
input = []
STDIN.each_line do |line|
    input << line.strip.split("")
end
game = Set.new(input)

puts "########### Level 1 ################"

game.walk
game.print
pp game.count
old = game.get_data

exit

puts "########### Level 2 ################"

count_all = 0
count_loop = 0

input.each_with_index do |line, li|
    line.each_with_index do |cell, ci|
        if old[li][ci] == "X"
            input2 = Marshal.load(Marshal.dump(input))
            input2[li][ci] = "#"
            g = Set.new(input2)
            if g.walk == "loop"
                count_loop += 1
            end
        end
        count_all += 1
        puts count_loop.to_s + "/" + count_all.to_s
    end
end

puts

pp count_loop
