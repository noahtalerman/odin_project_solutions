module Enumerable

    def my_each
        return self.to_enum if !block_given?
        if self.class == Array
            i = 0
            while i < self.length
                yield(self[i])
                i += 1
            end
        elsif self.class == Hash
            keys = self.keys
            keys.length.times do |i|
                key = keys[i]
                value = self[key]
                yield(key, value)
            end
        end
        self
    end

    def my_each_with_index
        return self.to_enum if !block_given?      
        if self.class == Array
            i = 0
            while i < self.length
                yield(self[i], i)
                i += 1
            end
        elsif self.class == Hash
            keys = self.keys
            keys.length.times do |i|
                key = keys[i]
                value = self[key]
                key_value = [key, value]
                yield(key_value, i)
            end
        end
        self
    end

    def my_select
        return self.to_enum if !block_given?
        new_array = []
        i = 0
        while i < self.length
            if yield(self[i])
                new_array << self[i]
            end
            i += 1
        end
        new_array
    end

    def my_all?
        if !block_given?
            return self.my_all? { |obj| obj }
        end
        if self.class == Array
            length = self.size - 1
            self.length.times do |i|
                if yield(self[i])
                    return false
                end
            end
        elsif self.class == Hash
            keys = self.keys
            keys.length.times do |i|
                if yield(keys[i], self[keys[i]])
                    return false
                end
            end
        end
        true
    end

    def my_any? 
        if !block_given?
            return self.my_any? { |obj| obj}
        end
        if self.class == Array
            length = self.size - 1
            self.length.times do |i|
                if yield(self[i])
                    return true
                end
            end
        elsif self.class == Hash
            keys = self.keys
            keys.length.times do |i|
                if yield(keys[i], self[keys[i]])
                    return true
                end
            end
        end
        false
    end

    def my_none? 
        if !block_given?
            return self.my_any? { |obj| obj}
        end
        if self.class == Array
            length = self.size - 1
            self.length.times do |i|
                if yield(self[i])
                    return false
                end
            end
        elsif self.class == Hash
            keys = self.keys
            keys.length.times do |i|
                if yield(keys[i], self[keys[i]])
                    return false
                end
            end
        end
        true
    end

    def my_count *arg 
        count = 0
        if !arg.empty?
            self.my_each do |obj|
                if obj == arg[0]
                    count += 1
                end
           end
           return count
        end
        if !block_given?
            return self.length
        else
            length = self.size - 1
            self.length.times do |i|
                if yield(self[i])
                    count += 1
                end
            end
        end
        count
    end

    def my_map(&my_proc)
        array = []
        if !block_given?
            return my_map { |obj| obj}
        end
        if self.class == Array
            length = self.size - 1
            self.length.timed do |i|
                array << my_proc.call(self[i])
            end
        elsif self.class == Hash
            self.my_each do |key, value|
                array << my_proc.call(key, value)
            end
        elsif self.class == Range
            range_array = self.to_a
            length = range_array.size - 1
            range_array.length.times do |i|
                array << my_proc.call(range_array[i])
            end
        end
        array
    end

    def my_inject *initial
        result = nil
        array = self.to_a
        if initial.size != 0
            result = initial
        else
            result = array[0]
            array.shift
        end 
        length = array.size - 1
        array.length.times do |i|
            result = yield(result, array[i])
        end
        result
    end

end

