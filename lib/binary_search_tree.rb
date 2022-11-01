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

  def build_tree(array, node = nil)
    mid = array.length / 2
    if mid.zero?
      node = Node.new(array[0])
      return
    end
    root = array[mid]
    left_n = array[0, mid]
    right_n = array[mid + 1, array.length - 1]
    node = Node.new(root, left_n, right_n)
    build_tree(left_n, node)
    build_tree(right_n, node)
    node
  end
end

test = Tree.new([1,3,4,2,5,6,7])
puts 'This is the root node'
p test.root_node
puts 'This is the root node data:'
p test.root_node.data
puts "This is right #{test.root_node.r_child} and left: #{test.root_node.l_child}"