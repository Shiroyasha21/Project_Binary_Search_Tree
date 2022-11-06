# Project_Binary_Search_Tree

This project shows how to build a balanced Binary Search Tree. 

The following are the methods to build and take/delete/get the data within the nodes of the tree.

#build_tree
  Takes an array and turn it to a balanced tree full of nodes.

#insert and #delete
  Accepts a value to insert it in the tree or delete the node that has that value

#find
  Accepts a value and find it in the tree

#level_order
  Accepts a block. This method traverse the tree in breadth-first level order.
  If block is not given, return an array of the values of the tree.

#preorder, #inorder, and #postorder
  These three methods has its own way of traversing the tree in depth-first order.
  The methods accepts a block. If block is not given, it returns the array of values of the tree traversed.

#height
  Returns the height of the tree. 
  Height is defined as the number of edges in longest path from a given node to a leaf node.

#depth
  Returns the depth of the tree.
  Depth is defined as the number of edges from a given node to the root node.
  Note:
    The height of the tree is the max depth of root node.

#balanced?
  Check if the tree is balanced.
  It's balance if the difference height of left and right subtree of all the nodes does not exceed 1.

#rebalance
  Create a new tree from a unbalanced tree.

