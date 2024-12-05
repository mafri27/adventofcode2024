
class Set
    def initialize(data)
        @data = data
    end
    def get_data
        return(@data)
    end
    def validate(rules)
        return true if @data.length == 1
        rules.each do |rule|
            a = @data.index(rule[0])
            b = @data.index(rule[1])
            return false if a and b and b < a
        end
#        @data.reverse.combination(2).each do |com|
#            return false if rules.include?(com)
#        end
        return true
    end
    def middle
        return @data[ (@data.length / 2) ]
    end
    def make_valid(rules)
        temp = []
        @data.each do |item|
            valid = false
            while not valid
                (temp.length + 1 ).times do |x|
                    test = temp.clone.insert( x, item )
                    if not valid and Set.new(test).validate(rules)
                        valid = true
                        temp = test
                    end
                end
            end
        end
        return Set.new(temp)
    end
end

rules = []
sets = []
STDIN.each_line do |line|
    sets << Set.new(line.scan(/[0-9]+/).map{|x| x.to_i}) if line.include?(',')
    rules << line.scan(/[0-9]+/).map{|x| x.to_i} if line.include?('|')
end

puts "########### Level 1 ################"
count = 0
sets2 = []
sets.each do |set|
    if set.validate(rules)
        count += set.middle
    else
        sets2 << set
    end
end
pp count
puts "########### Level 2 ################"

count = 0
sets2.each do |set|
    count += set.make_valid(rules).middle
end
pp count
