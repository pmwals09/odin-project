# frozen_string_literal: true

def bubble_sort(arr)
  loop_num = 0
  loop do
    sorted = true
    (0...arr.length - 1 - loop_num).each do |i|
      next unless arr[i] > arr[i + 1]

      sorted = swap_vals(arr, i)
    end
    break if sorted
  end
  arr
end

def swap_vals(arr, idx)
  val = arr[idx + 1]
  arr[idx + 1] = arr[idx]
  arr[idx] = val
  false
end

puts bubble_sort([6, 5, 3, 1, 8, 7, 2, 4])
# [1,2,3,4,5,6,7,8]
puts bubble_sort([4, 3, 78, 2, 0, 2])
# [0,2,2,3,4,78]
