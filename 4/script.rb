class Set
    def initialize(array)
        @data = array.map{|x| x.split("") }
    end
    def print
        @data.each do |line|
            puts "'" + line.join + "'"
        end
    end
    def rotate90
        temp = []
        @data.first.length.times do |row_c|
            temp[row_c] = []
            @data.length.times do |line_c|
                temp[row_c][line_c] = @data[line_c][row_c]
            end
        end
        return Set.new(temp.reverse.map{|x| x.join })
    end
    def rotate45
        temp = []
        @data.length.times do |row_c|
            temp << ((" " * row_c) +  @data[row_c].join + (" " * (@data.length - row_c - 1)) )
        end
        return Set.new(temp).rotate90
    end

    def scan(str)
        return @data.map{|x| x.join.scan(str).length + x.join.scan(str.reverse).length }.sum
    end
    def subset
        temp = []
        0.upto( @data.length - 3 ) do |row_c|
            0.upto( @data.first.length - 3 ) do |line_c|
                a = [ @data[row_c][line_c..line_c+2] ,  @data[row_c + 1][line_c..line_c+2] , @data[row_c + 2][line_c..line_c+2] ]
                temp << a
            end
        end
        return temp
    end
    def validate1(str)
        return self.scan(str) + self.rotate90.scan(str) + self.rotate45.scan(str) + self.rotate90.rotate45.scan(str)
    end
end

temp = []
STDIN.each_line do |line|
    temp  << line.strip
end

puts "########### Level 1 ################"
a = Set.new(temp)
pp a.validate1("XMAS")

puts "########### Level 2 ################"
test = a.subset
count = 0
test.each do |set|
    if set[1][1]  == "A"
        corners = [ set[0][0] , set[0][2] ,  set[2][0] , set[2][2]]
        count += 1 if corners.count("M") == 2 and corners.count("S") == 2 and corners[0] != corners[3]
    end
end
pp count
