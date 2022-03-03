# frozen_string_literal: true

require 'pry'

# Binary search tree node
class Node
  attr_accessor :value, :right, :left

  include Comparable
  def <=>(other)
    @value <=> other.value
  end

  def initialize(value = nil)
    @value = value
    @right = nil
    @left = nil
  end
end

# Balanced binary search tree
class Tree
  attr_reader :root

  def initialize(arr)
    @root = build_tree arr
  end

  def build_tree(arr)
    # Build a balanced, binary tree
    # Sort and remove duplicates before building
    # Return the root node
    if arr.length == 1
      Node.new arr[0]
    elsif arr.length.zero?
      nil
    else
      arr = arr.sort.uniq
      root = Node.new arr[arr.length / 2]
      root.left = build_tree(arr[0...arr.length / 2])
      root.right = build_tree(arr[arr.length / 2 + 1..])
      root
    end
  end

  def insert(value, node = @root)
    # Insert a value into the tree
    if value < node.value
      if node.left.nil?
        node.left = Node.new value
      else
        insert(value, node.left)
      end
    elsif value > node.value
      if node.right.nil?
        node.right = Node.new value
      else
        insert(value, node.right)
      end
    end
  end

  def delete(value, node = @root)
    # Delete a value from the tree
    # Handle special cases, i.e. when a deleted node has children
    parent = nil
    while !node.nil? && node.value != value
      parent = node
      node = node.left if value < node.value
      node = node.right if value > node.value
    end
    # We didn't find a node with that value
    if node.nil?
      # We didn't find a node with that value
      node
    elsif node.left.nil? && node.right.nil?
      # We found a node and it has no children - the simplest case
      parent.left = nil if parent.left == node
      parent.right = nil if parent.right == node
    else
      # We found a node and it has children
      # Make a balanced branch out of the children and attach it where
      # the node to delete used to be?
      values = inorder(node.left).concat inorder(node.right)
      puts "values"
      new_subtree = build_tree values
      if parent.left == node
        parent.left = new_subtree
      else
        parent.right = new_subtree
      end
    end
  end

  def find(value, node = @root, queue = Queue.new)
    # Returns the node with the given value
    return find(value, queue.pop, queue) if node.nil?

    if node.value == value
      node
    else
      queue.push(node.left)
      queue.push(node.right)
      find(value, queue.pop, queue)
    end
  end

  def level_order
    # Accepts a block
    # Traverse tree breadth first and yield node to provided block
    # Return array of values if no block is given
    q = Queue.new
    nodes = []
    q.push @root
    until q.empty?
      node = q.pop
      block_given? ? yield(node) : nodes << node.value
      q.push node.left unless node.left.nil?
      q.push node.right unless node.right.nil?
    end
    nodes unless block_given?
  end

  def inorder(node = @root, nodes = [], &block)
    # Accepts block
    # Traverse tree depth first inorder and yield node to provided block
    # Return array of values if no block is given
    inorder(node.left, nodes, &block) unless node.left.nil?
    block_given? ? yield(node) : nodes << node.value
    inorder(node.right, nodes, &block) unless node.right.nil?
    nodes
  end

  def preorder(node = @root, nodes = [], &block)
    # Accepts block
    # Traverse tree depth first preorder and yield node to provided block
    # Return array of values if no block is given
    block_given? ? yield(node) : nodes << node.value
    preorder(node.left, nodes, &block) unless node.left.nil?
    preorder(node.right, nodes, &block) unless node.right.nil?
    nodes
  end

  def postorder(node = @root, nodes = [], &block)
    # Accepts block
    # Traverse tree depth first postorder and yield node to provided block
    # Return array of values if no block is given
    postorder(node.left, nodes, &block) unless node.left.nil?
    postorder(node.right, nodes, &block) unless node.right.nil?
    block_given? ? yield(node) : nodes << node.value
    nodes
  end

  def height(node = @root)
    # Returns height of given node
    # Height = number of edges in longest path from a given node to a leaf node
    return 0 if node.nil?

    left_height = node.left.nil? ? 0 : height(node.left)
    right_height = node.right.nil? ? 0 : height(node.right)
    [left_height, right_height].max + 1
  end

  def depth(node)
    # Returns depth of given node
    # Depth = number of edges in path from a given node to the tree's root node
    height(@root) - height(node)
  end

  def balanced?(node = @root)
    # Check whether the tree is balanced
    # Difference between heights of left subtree and right subtree of every node is <= 1
    node.nil? || (balanced?(node.left) && balanced?(node.right) && (height(node.left) - height(node.right)).abs <= 1)
  end

  def rebalance
    # Rebalance an unbalanced tree
    # Use a traversal method to provide a new array to the #build_tree method
    tree_vals = inorder
    @root = build_tree tree_vals
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    # Provided by a generous Odin Project student
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# 1. Create binary search tree from array of random numbers
array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)
# tree.insert 9
# tree.insert 5
# tree.insert 19
# tree.insert 29
# tree.insert 39
# tree.pretty_print
# p tree.height tree.root
# p tree.depth(tree.find(9))
# 2. Confirm that the tree is balanced by calling #balanced?
p tree.balanced?
# 3. Print all elements in level, pre, post, in orders
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
# 4. Unbalance tree by adding several numbers > 100
tree.insert(109)
tree.insert(209)
tree.insert(259)
tree.insert(319)
# 5. Confirm tree is unbalanced with #balanced?
p tree.balanced?
# 6. Balance tree by calling #rebalance
tree.rebalance
# 7. Confirm tree is balanced with #balanced?
p tree.balanced?
# 8. Print all elements in level, pre, post, in orders
p tree.level_order
p tree.preorder
p tree.postorder
p tree.inorder
