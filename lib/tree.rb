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

    if value < node.data
      node.left = insert(value, node.left)
    else
      node.right = insert(value, node.right)
    end

    node
  end

  def delete(value)
    return nil if value.nil?

    @array.delete(value)
    @root = build_tree(@array)
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
end
