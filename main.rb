# frozen_string_literal: true

require_relative 'lib/tree'

tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

# Test methods
puts '--- #pretty_print ---'
tree.pretty_print # returns a visual representation of the tree
puts '--- #insert ---'
tree.insert(11) # inserts 11 into the tree and rebalances it accordingly
tree.pretty_print
puts '--- #delete ---'
tree.delete(11) # removes 11 from the tree and rebalances it accordingly
tree.pretty_print
puts '--- #find ---'
p tree.find(4) # returns the node '4' that was found, with no left or right value
puts '--- #level_order ---'
p(tree.level_order { |element| element < 5 }) # returns all nodes less than 5 in level order
puts '--- #level_order_iteration ---'
p(tree.level_order_iteration { |element| element < 5 }) # returns all nodes less than 5 in level order
puts '--- #preorder ---'
p(tree.preorder { |element| element >= 5 }) # returns all nodes greater than or equal to five in preorder
puts '--- #inorder ---'
p(tree.inorder { |element| element != 1 }) # returns all nodes NOT equal to 1 in inorder
puts '--- #postorder ---'
p tree.postorder # returns all nodes in postorder
puts '--- #height ---'
p tree.height(5) # returns 3, the amount of nodes away it is from the lowest leaf
puts '--- #depth ---'

puts '--- #balanced? ---'
p tree.balanced? # returns true
puts '--- #rebalance ---'
tree.rebalance # does nothing because it is already balanced
tree.pretty_print # returns the tree
