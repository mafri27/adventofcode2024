
class Set
    def initialize(str)
        @data = str.scan(/([0-9]+)/).flatten.map{|x| x.to_i }
    end
    def validate(array)
        return false if array != array.sort and array != array.sort.reverse
        0.upto(array.length - 2) do |x|
            return false if not (1..3).to_a.include?( ( array[x] - array[x+1] ).abs)
        end
        return true
    end
    def validate1
        return validate(@data)
    end
    def validate2
        @data.combination(@data.length - 1 ).each do |com|
            return true if validate(com)
        end
        return false
    end
end

sets = []
STDIN.each_line do |line|
    sets << Set.new(line)
end

puts "########### Level 1 ################"

count = 0
sets.each do |set|
    count += set.validate1 ? 1 : 0
end
pp count

puts "########### Level 2 ################"

count = 0
sets.each do |set|
    count += set.validate2 ? 1 : 0
end
pp count
