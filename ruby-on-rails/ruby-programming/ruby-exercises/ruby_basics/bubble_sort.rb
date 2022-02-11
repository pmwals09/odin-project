def bubble_sort(arr)
  loop_num = 0
  loop do
    sorted = true
    for i in 0...arr.length - 1 - loop_num do
      if arr[i] > arr[i + 1]
        sorted = false
        val = arr[i + 1]
        arr[i + 1] = arr[i]
        arr[i] = val
      end
    end
    break if sorted
  end
  arr
end

puts bubble_sort([6,5,3,1,8,7,2,4])
# [1,2,3,4,5,6,7,8]
puts bubble_sort([4,3,78,2,0,2])
# [0,2,2,3,4,78]
