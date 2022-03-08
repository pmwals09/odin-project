# frozen_string_literal: true

# Knight node
class KnightNode
  attr_accessor :children
  attr_reader :position, :parent

  def initialize(position, parent = nil)
    @position = position
    @parent = parent
    @children = []
  end

  def next_moves
    [
      [2, 1], [2, -1],
      [1, 2], [-1, 2],
      [-2, 1], [-2, -1],
      [1, -2], [-1, -2]
    ].map { |ea| [ea[0] + @position[0], ea[1] + @position[1]] }
      .map { |pos| KnightNode.new(pos, self) }
      .filter(&:valid?)
  end

  def valid?
    @position.all? { |x| x.between?(0, 7) }
  end

  def ==(other)
    other.position[0] == @position[0] && other.position[1] == @position[1]
  end
end

# Tree of KnightNodes
class KnightTree
  attr_reader :root

  def initialize(start_position)
    @root = build_tree(KnightNode.new(start_position))
  end

  def build_tree(current, history = [])
    history << current
    current.children = current.next_moves.filter do |next_move|
      history.none? do |prev_move|
        prev_move == next_move
      end
    end
    current.children.each { |child| build_tree(child, history) }

    current
  end

  def knight_moves(end_position)
    end_position = KnightNode.new(end_position) unless end_position.is_a?(KnightNode)
    q = Queue.new
    node = nil
    q.push @root
    until q.empty? || node == end_position
      node = q.pop
      node.children.each { |child_node| q.push child_node }
    end
    walk_up_tree node
  end

  def walk_up_tree(node, path = [])
    if node.nil?
      path
    else
      path << node
      walk_up_tree(node.parent, path)
    end
  end
end

kt = KnightTree.new([0, 0])
p kt.knight_moves([1, 2]).map(&:position)
p kt.knight_moves([3, 3]).map(&:position)
