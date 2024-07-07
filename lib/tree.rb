# frozen_string_literal: true

require_relative 'node'
require_relative 'utils/tree_utils'

# Defines the tree of nodes
class Tree
  include TreeUtils

  attr_reader :root

  def initialize(array)
    @array = array
    @root = build_tree(@array)
  end

  def build_tree(array)
    return nil if array.empty?

    sorted_array = array.uniq.sort
    last = sorted_array.length - 1

    balance_tree(sorted_array, 0, last)
  end

  def pretty_print(node = @root, prefix = '', is_left = true) # rubocop:disable Style/OptionalBooleanParameter
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    internal_insert(value)
    rebalance
  end

  def delete(value)
    internal_delete(value)
    rebalance
  end

  def find(value, node = @root)
    return nil if node.nil?

    case value <=> node.data
    when -1
      find(value, node.left)
    when 1
      find(value, node.right)
    when 0
      node
    end
  end

  def level_order(queue = [@root], result = [], &block)
    return result if queue.empty?

    result = check_for_block(queue.first, result, &block)
    queue = queue_level_shift(queue)

    level_order(queue, result, &block)
  end

  def level_order_iteration(&block)
    queue = [@root]
    result = []

    until queue.empty?
      result = check_for_block(queue.first, result, &block)
      queue = queue_level_shift(queue)
    end

    result
  end

  def inorder(node = @root, result = [], &block)
    return if node.nil?

    inorder(node.left, result, &block)
    result = check_for_block(node, result, &block)
    inorder(node.right, result, &block)

    result
  end

  def preorder(node = @root, result = [], &block)
    return if node.nil?

    result = check_for_block(node, result, &block)
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)

    result
  end

  def postorder(node = @root, result = [], &block)
    return if node.nil?

    postorder(node.left, result, &block)
    postorder(node.right, result, &block)
    check_for_block(node, result, &block)
  end

  def balanced?
    simulated_rebalance = rebalance(change_root: false)
    return true if simulated_rebalance == @root

    false
  end

  def rebalance(change_root: true)
    nodes = inorder
    return @root = build_tree(nodes) if change_root

    build_tree(nodes)
  end
end
