# frozen_string_literal: true

# Defines a node for the tree
class Node
  include Comparable

  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    return nil if other.nil?

    data <=> other.data
  end
end
