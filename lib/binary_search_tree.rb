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

  def child_size
    if l_child.nil? && r_child.nil?
      0
    elsif l_child && r_child
      2
    else
      1
    end
  end
end

# The Tree class will accept an array
class Tree
  include MergeSort
  attr_accessor :arr, :root, :node_count

  def initialize(array)
    @arr = merge_sort(array).uniq
    @node_count = 0
    @root = build_tree(@arr)
  end

  def build_tree(array)
    mid = array.length / 2
    root = array[mid]

    return root if array.length.zero?

    left = build_tree(array[0, mid])
    right = build_tree(array[mid + 1, array.length - 1])

    @node_count += 1
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
      case node.child_size
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
    return node if node.child_size.zero?

    right_minimum(value, node.l_child)
  end

  def find(value, node = @root)
    return false if node.nil?
    return node if node.data == value

    value < node.data ? find(value, node.l_child) : find(value, node.r_child)
  end

  def level_order(node = @root, &block)
    arr = [node.data]
    node_arr = queue(node, arr)
    return node_arr unless block_given?

    node_arr.each do |data|
      block.call(data)
    end
  end

  def queue(node, arr, q_arr = [node])
    return arr if arr.length == @node_count

    q_arr.push(node.l_child)
    q_arr.push(node.r_child)

    case q_arr[0].child_size
    when 2
      arr.push(q_arr[0].l_child.data)
      arr.push(q_arr[0].r_child.data)
    when 1
      q_arr[0].l_child.data.nil? ? arr.push(q_arr[0].r_child.data) : arr.push(q_arr[0].l_child.data)
    end
    q_arr.shift

    queue(q_arr[0], arr, q_arr)
  end
end

# test = Tree.new([1,4,3,2])
# test = Tree.new([7,5,1,3,4,2,6])
# test = Tree.new([1,3,5,7,8,10])
test = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# test = Tree.new([1,2,3,4,5,6,7,8,9])
# test = Tree.new((Array.new(21) { rand(1..100) }))
test.pretty_print
p test.level_order

