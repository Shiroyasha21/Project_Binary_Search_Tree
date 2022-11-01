# frozen_string_literal: false

# Merge Sort method
module MergeSort
  def merge_sort(arr)
    return arr if arr.length < 2

    left = merge_sort(arr.slice!(0, arr.length / 2))
    right = merge_sort(arr)
    sorted = []

    until left.length.zero? || right.length.zero?
      left.first <= right.first ? sorted << left.shift : sorted << right.shift
    end

    sorted + left + right
  end
end
