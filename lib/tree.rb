# frozen_string_literal: true

require_relative 'node'

# Defines the tree of nodes
class Tree
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

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    case value <=> node.data
    when -1
      node.left = insert(value, node.left)
    when 1
      node.right = insert(value, node.right)
    when 0
      node
    end

    node
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def delete(value, node = @root)
    return node unless node

    case value <=> node.data
    when -1
      node.left = delete(value, node.left)
    when 1
      node.right = delete(value, node.right)
    when 0
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      node.data = min_value(node.right)
      node.right = delete(min_value(node.right), node.right)
    end

    node
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

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

  private

  def balance_tree(array, first, last)
    return nil if first > last

    middle = (first + last) / 2
    root = Node.new(array[middle])

    root.left = balance_tree(array, first, middle - 1)
    root.right = balance_tree(array, middle + 1, last)

    root
  end

  def queue_level_shift(queue)
    first = queue.first

    queue.push(first.left) if first.left
    queue.push(first.right) if first.right
    queue.shift

    queue
  end

  def check_for_block(node, result, &block)
    result << node.data if block_given? && block.call(node.data)
    result << node.data unless block_given?
    result
  end

  def min_value(node, min = node.data)
    min_value(node.left, node.left.data) if node.left

    min
  end
end
