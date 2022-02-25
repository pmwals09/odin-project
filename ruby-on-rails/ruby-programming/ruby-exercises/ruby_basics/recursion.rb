# frozen_string_literal: true

def fibs(n)
  nums = []
  a = 0
  b = 1
  c = a + b
  while n.positive?
    nums << a
    a = b
    b = c
    c = a + b
    n -= 1
  end
  nums
end

p fibs 8

def fibs_rec(n, a = 0, b = 1, c = 1, nums = [])
  return nums if n.zero?

  fibs_rec(n - 1, b, c, b + c, nums.concat([a]))
end

p fibs_rec 8

def merge_sort(arr)
  return arr if arr.length == 1

  left = merge_sort arr[0..arr.length / 2 - 1]
  right = merge_sort arr[arr.length / 2..]
  merge(left, right)
end

def merge(left, right)
  merged_arr = []
  merged_arr << (left.first < right.first ? left.shift : right.shift) while left.length.positive? && right.length.positive?
  merged_arr.concat right if right.length.positive?
  merged_arr.concat left if left.length.positive?
  merged_arr
end

p merge_sort [5, 2, 1, 3, 6, 4]
