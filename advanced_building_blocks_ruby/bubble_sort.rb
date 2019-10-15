def bubble_sort array
    swap_made = true
    total_iterations = 0
    while swap_made
        num_swaps = 0
        num_elements = array.length() - total_iterations - 1
        num_elements.times do |i|
            if (array[i] > array[i + 1])
                elem = array[i]
                array[i] = array[i + 1]
                array[i + 1] = elem
                num_swaps += 1
            end
        end
        unless num_swaps > 0
            swap_made = false
        end
        total_iterations += 1
    end 
    print array
end

# UNCOMMENT THIS FUNCTION CALL TO TEST
# bubble_sort([4,3,78,2,0,2,17,208,143,12,7,10,45,87,156])


def bubble_sort_by array
    swap_made = true
    total_iterations = 0
    while swap_made
        num_swaps = 0
        num_elements = array.length() - total_iterations - 1
        num_elements.times do |i|
            result = yield(array[i], array[i + 1])
            if result > 0
                elem = array[i]
                array[i] = array[i + 1]
                array[i + 1] = elem
                num_swaps += 1
            end
        end
        unless num_swaps > 0
            swap_made = false
        end
        total_iterations += 1
    end
    print array
end

# UNCOMMENT THIS FUNCTION CALL TO TEST
# bubble_sort_by(["hi","hello","hey"]) do |left,right|
#     left.length - right.length
# end