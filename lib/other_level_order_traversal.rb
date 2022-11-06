# Left over code for the Level Order traversal.

  def size(node = @root)
    return 0 if node.nil?

    left = size(node.l_child)
    right = size(node.r_child)

    left + right + 1
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

# level order traversal that uses the size of the tree for the queue recursion to work
def level_order_recur_queue(node = @root, &block)
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
