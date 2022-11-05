# frozen_string_literal: false

require_relative 'lib/binary_search_tree'

array = (Array.new(15) { rand(1..100) })
run = Tree.new(array)
run.pretty_print
puts "Is the tree balanced? #{run.balanced?}"
puts ''
puts "Level Order: #{run.level_order}"
puts ''
puts "Preorder: #{run.preorder}"
puts "Postorder: #{run.postorder}"
puts "Inorder: #{run.inorder}"
puts ''
run.insert(120)
run.insert(150)
run.insert(115)
run.insert(172)
puts "Is the tree balanced? #{run.balanced?}"
puts ''
run.pretty_print
puts 'After rebalance'
run.rebalance
puts run.pretty_print
puts ''
puts "Is the tree balanced? #{run.balanced?}"
puts "Level Order: #{run.level_order}"
puts ''
puts "Preorder: #{run.preorder}"
puts "Postorder: #{run.postorder}"
puts "Inorder: #{run.inorder}"
