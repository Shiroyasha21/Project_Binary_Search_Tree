# frozen_string_literal: false

require_relative 'merge_sort_mod'

# Contains the nodes to store data and its children
class Node
  include Comparable
  attr_accessor :data, :l_child, :r_child

  def initialize(data, l_child = nil, r_child = nil)
    @data = data
    @l_child = l_child
    @r_child = r_child
  end 
end

# The Tree class will accept an array
class Tree
  include MergeSort
  attr_accessor :arr, :root

  def initialize(array)
    @arr = merge_sort(array)
    build_tree(@arr)
  end

  def build_tree(array)
    if array.length == 1
      last = Node.new(array[0])
      puts "(#{last.data})"
      return array
    end

    mid = array.length / 2
    @root = array[mid]

    test = Node.new(@root, build_tree(array[0, mid]), build_tree(array[mid + 1, (array.length - 1)]))
    puts test.data
    puts "#{test.l_child} - #{test.r_child}"
    
  end
end

Tree.new([7,3,5,2,6,1,4])
