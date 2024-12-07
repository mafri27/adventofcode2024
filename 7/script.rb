class Set
    def initialize(res, data)
        @res = res
        @data = data
    end
    def solve
        temp = [@data.first]
        1.upto(@data.length - 1).each do |count|

            temp = temp.map{|x| [ (x + @data[count])  , (x * @data[count]) ] }.flatten
            temp = temp.delete_if{|x| x > @res }

        end
        return true if temp.include?(@res)
        return false
    end
    def solve2
        return false if @data[0] > @res
        if @data.length == 1
            return true if @data[0] == @res
            return false
        end

        a = @data.clone
        b = a[0] * a[1]
        a.delete_at(1)
        a[0] = b
        return true if Set.new(@res , a).solve2

        a = @data.clone
        b = a[0] + a[1]
        a.delete_at(1)
        a[0] = b
        return true if Set.new(@res , a).solve2

        a = @data.clone
        b = (a[0].to_s + a[1].to_s).to_i
        a.delete_at(1)
        a[0] = b
        return true if Set.new(@res , a).solve2

        return false
    end
    def get_res
        return @res
    end
end

sets = []
STDIN.each_line do |line|
    temp = line.scan(/[0-9]+/).map{|x| x.to_i}
    sets << Set.new(temp.first , temp[1..-1])
end

puts "########### Level 1 ################"

count = 0
sets.each do |set|
    if set.solve == true
        count += set.get_res
    end
end
pp count

puts "########### Level 2 ################"
count = 0
sets.each do |set|
    if set.solve2 == true
        count += set.get_res
    end
end
pp count
