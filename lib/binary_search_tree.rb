# frozen_string_literal: false

require_relative 'merge_sort_mod'
require_relative 'node'

# The Tree class will accept an array
class Tree
  include MergeSort
  attr_accessor :arr, :root

  def initialize(array)
    @arr = merge_sort(array).uniq
    @node_count = 0
    @root = build_tree(@arr)
  end

  def size(node = @root)
    return 0 if node.nil?

    left = size(node.l_child)
    right = size(node.r_child)

    left + right + 1
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

    value < node.data ? insert(value, node.l_child, node) : insert(value, node.r_child, node)
  end

  def create_leaf_node(value, node)
    new_leaf = Node.new(value)
    if value < node.data
      node.l_child = new_leaf
    else
      node.r_child = new_leaf
    end
  end

  # The one and two child delete is relevant to this method
  def delete(value, node = @root, prev = nil)
    return false unless find(value)

    if node.data == value
      case child_size(node)
      when 0
        value < prev.data ? prev.l_child = nil : prev.r_child = nil
      when 1
        one_child_delete(value, node, prev)
      else
        two_child_delete(value, node)
      end
      return node
    end
    value < node.data ? delete(value, node.l_child, node) : delete(value, node.r_child, node)
  end

  def child_size(node)
    if node.l_child.nil? && node.r_child.nil?
      0
    elsif node.l_child && node.r_child
      2
    else
      1
    end
  end

  def one_child_delete(value, node, prev)
    if value < prev.data
      node.l_child.nil? ? prev.l_child = node.r_child : node.l_child
    else
      node.r_child.nil? ? prev.r_child = node.l_child : node.l_child
    end
  end

  def two_child_delete(value, node)
    min_node = right_minimum(value)
    delete(min_node.data)

    node.data = min_node.data
  end

  def right_minimum(value, node = find(value).r_child)
    return node if child_size(node).zero?

    right_minimum(value, node.l_child)
  end

  def find(value, node = @root)
    return false if node.nil?
    return node if node.data == value

    value < node.data ? find(value, node.l_child) : find(value, node.r_child)
  end

  def level_order_iterative(node = @root, &block)
    arr = []
    queue_arr = []
    level_arr = queue(node, arr, queue_arr)

    return level_arr unless block_given?

    level_arr.each do |data|
      block.call(data)
    end
  end

  def queue(node, arr, queue_arr)
    return if node.nil?

    # Push the node to the queue
    queue_arr << node
    until queue_arr.length.zero?
      current_node = queue_arr[0]
      arr << current_node.data
      unless current_node.l_child.nil?
        queue_arr.push(current_node.l_child)
      end
      unless current_node.r_child.nil?
        queue_arr.push(current_node.r_child)
      end
      # Remove the node to the queue after adding its child to the queue
      queue_arr.shift
    end
    arr
  end

  # A recursive method that use the size of the tree
  def level_order(node = @root, &block)
    h = height(node)
    arr = []

    (1..h + 1).each do |level|
      data = push_current_level(node, level)
      data.each { |val| arr << val }
    end
    return arr unless block_given?

    arr.each { |data| block.call(data) }
  end

  def push_current_level(node, level, arr = [])
    return arr if node.nil?

    if level == 1
      arr << node.data
    elsif level > 1
      push_current_level(node.l_child, level - 1, arr)
      push_current_level(node.r_child, level - 1, arr)
    end
  end

  def inorder(node = @root, arr = [], &block)
    return arr if node.nil?

    inorder(node.l_child, arr)
    arr << node.data
    inorder(node.r_child, arr)

    return arr unless block_given?

    arr.each { |val| block.call(val)}
  end

  def preorder(node = @root, arr = [], &block)
    return arr if node.nil?

    arr << node.data
    preorder(node.l_child, arr)
    preorder(node.r_child, arr)

    return arr unless block_given?

    arr.each { |val| block.call(val)}
  end

  def postorder(node = @root, arr = [], &block)
    return arr if node.nil?

    postorder(node.l_child, arr)
    postorder(node.r_child, arr)
    arr << node.data

    return arr unless block_given?

    arr.each { |val| block.call(val)}
  end

  def height(node)
    return -1 if node.nil?

    left = height(node.l_child)
    right = height(node.r_child)

    left > right ? left + 1 : right + 1
  end

  def depth(node, root = @root)
    h = height(root)
    arr = []

    (1..h + 1).each do |level|
      arr << push_current_level(root, level)
    end
    arr.each_with_index do |val, i|
      val.each do |int|
        return i if int == node.data
      end
    end
  end

  def balanced?(node = @root, truthy_arr = [])
    return if node.nil?

    balanced?(node.l_child, truthy_arr)
    balanced?(node.r_child, truthy_arr)

    left = height(node.l_child)
    right = height(node.r_child)

    left > right ? truthy = left - right <= 1 : truthy = right - left <= 1

    truthy_arr << truthy
    truthy_arr.all?
  end

  def rebalance
    new_arr = inorder()
    @root = build_tree(new_arr)
  end
end
