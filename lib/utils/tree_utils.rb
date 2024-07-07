# frozen_string_literal: true

# Extra util methods for the Tree class
module TreeUtils
  def balance_tree(array, first, last)
    return nil if first > last

    middle = (first + last) / 2
    root = Node.new(array[middle])

    root.left = balance_tree(array, first, middle - 1)
    root.right = balance_tree(array, middle + 1, last)

    root
  end

  def internal_insert(value, node = @root)
    return Node.new(value) if node.nil?

    case value <=> node.data
    when -1
      node.left = internal_insert(value, node.left)
    when 1
      node.right = internal_insert(value, node.right)
    when 0
      node
    end

    node
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def internal_delete(value, node = @root)
    return node unless node

    case value <=> node.data
    when -1
      node.left = internal_delete(value, node.left)
    when 1
      node.right = internal_delete(value, node.right)
    when 0
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      node.data = min_value(node.right)
      node.right = internal_delete(min_value(node.right), node.right)
    end

    node
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

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
