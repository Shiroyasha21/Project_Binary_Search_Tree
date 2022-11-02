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
    @arr = merge_sort(array).uniq
    @root = build_tree(@arr)
  end

  def build_tree(array)
    mid = array.length / 2
    root = array[mid]

    return root if array.length.zero?

    left = build_tree(array[0, mid])
    right = build_tree(array[mid + 1, array.length - 1])

    Node.new(root, left, right)
  end

  # Thanks fellow TOP student
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.r_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.r_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.l_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.l_child
  end

  def insert(value, node = @root, prev = nil)
    if node.nil?
      create_leaf_node(value, prev)
      return
    elsif node.l_child.nil? && node.r_child.nil?
      create_leaf_node(value, node)
      return
    end

    if value < node.data
      insert(value, node.l_child, node)
    else
      insert(value, node.r_child, node)
    end
  end

  def create_leaf_node(value, node)
    new_leaf = Node.new(value)
    if value < node.data
      node.l_child = new_leaf
    else
      node.r_child = new_leaf
    end
  end

  # def delete(value)
  #   node = find(value)
  # end

  def find(value, node = @root)
    return false if node.nil?
    return node if node.data == value

    value < node.data ? find(value, node.l_child) : find(value, node.r_child)
  end
end

test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# test = Tree.new([1,3,5,7,8,10]) error test
test.pretty_print
test.insert(15)
test.insert(100)
test.insert(10)
test.insert(69)
test.insert(6999)
puts ''
test.pretty_print
