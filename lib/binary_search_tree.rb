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
  attr_accessor :arr, :root_node

  def initialize(array)
    @arr = merge_sort(array)
    @root_node = build_tree(@arr)
  end

  def build_tree(array)
    mid = array.length / 2
    root = array[mid]

    return root if array.length.zero?

    left = build_tree(array[0, mid])
    right = build_tree(array[mid + 1, array.length - 1])

    Node.new(root, left, right)
  end
end

test = Tree.new([1,3,4,2,5,6,7])
puts "This is the root node: #{test.root_node} and its data: #{test.root_node.data}"
puts "This is the left child: #{test.root_node.l_child} and right child: #{test.root_node.r_child}"
puts "And their respective data: #{test.root_node.l_child.data} & #{test.root_node.r_child.data}"
puts ''
puts "This is their child respectively: #{test.root_node.l_child.l_child} - #{test.root_node.l_child.r_child} AND #{test.root_node.r_child.l_child} - #{test.root_node.r_child.r_child}"
puts "This is their child data respectively: #{test.root_node.l_child.l_child.data} - #{test.root_node.l_child.r_child.data} AND #{test.root_node.r_child.l_child.data} - #{test.root_node.r_child.r_child.data}"