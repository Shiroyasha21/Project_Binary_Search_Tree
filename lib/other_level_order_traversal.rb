# Iterative level order traversal, uses Queue
def level_order_iterative(node = @root, &block)
  arr = [node.data]
  node_arr = queue(node, arr)
  return node_arr unless block_given?

  node_arr.each do |data|
    block.call(data)
  end
end

def queue(node, arr, q_arr = [node])
  return arr if arr.length == @tree_size

  q_arr.push(node.l_child, node.r_child)
  case child_size(q_arr[0])
  when 2
    arr.push(q_arr[0].l_child.data, q_arr[0].r_child.data)
  when 1
    q_arr[0].l_child.data.nil? ? arr.push(q_arr[0].r_child.data) : arr.push(q_arr[0].l_child.data)
  end
  q_arr.shift
  queue(q_arr[0], arr, q_arr)
end
