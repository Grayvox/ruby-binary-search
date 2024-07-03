# Binary Search Tree in Ruby

This includes both depth-first and breadth-first approaches to searching a BST.

The following methods are included in this project:

- [x] `#build_tree(array)` -- takes an array of data and returns a balanced tree of `Node` objects, and returns the level 0 root node.
- [x] `#pretty_print` -- returns a visually pleasing showcase of the tree.
- [x] `#insert(value)` -- inserts the value provided into the tree, keeping it balanced.
- [x] `#delete(value)` -- deletes the value provided if it is in the tree, keeping it balanced afterwards. Returns nil if the value is not found.
- [x] `#find(value)` -- searches through the tree to find the value provided. Returns nil if the value is not found
- [x] `#level_order(&block)` -- traverses the tree in breadth-first level order and yields each node to the provided block. Returns an array of values if no block is given. Also uses an array acting as a queue to keep track of all the child nodes that it has yet to traverse and will add new ones to the list when needed. This version uses recursion, while `#level_order_iteration(&block)` uses iteration.
- [x] `#inorder(&block)` -- traverses the tree in depth-first using inorder traversal and yields each node to the provided block. Returns an array of values if no block is given.
- [x] `#preorder(&block)` -- traverses the tree in depth-first using preorder traversal and yields each node to the provided block. Returns an array of values if no block is given.
- [ ] `#postorder(&block)` -- traverses the tree in depth-first using postorder traversal and yields each node to the provided block. Returns an array of values if no block is given.
- [ ] `#height(value)` -- accepts the value of a node on the tree and returns its height. Height is defined as the number of edges in longest path from a given node to a leaf node. Returns nil if the value isn't found on the tree.
- [ ] `#depth(value)` -- accepts the value of a node on the tree  and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node. Returns nil if the value isn't found on the tree.
- [ ] `#balanced?` -- checks if the tree is balanced. A balanced tree is one where the difference between heights of left subtree and right subtree of every node is not more than 1. Returns true or fals.
- [ ] `#rebalance` -- rebalances an unbalanced tree.
