require_relative '00_tree_node'

class KnightPathFinder
  def initialize(starting_position)
    @starting_position = starting_position
    @visited_positions = [starting_position]
  end

  DELTAS = [
    [-2, 1],
    [-2, -1],
    [1, 2],
    [-1, 2],
    [2, 1],
    [2, -1],
    [-1, -2],
    [1, -2]
  ]
  #maybe change to class method in the future
  def valid_moves(position)
    x, y = position
    directional_moves = DELTAS.map do |(delta_x, delta_y)|
      [x + delta_x, y + delta_y]
    end

    valid_move_array = directional_moves.select do |(x_move, y_move)|
      x_move.between?(0, 7) && y_move.between?(0, 7)
    end

    valid_move_array
  end

  def new_move_positions(position)
    new_moves = valid_moves(position) - @visited_positions
    @visited_positions += new_moves
    new_moves
  end

  def build_move_tree
    root = PolyTreeNode.new(@starting_position)
    queue = [root]
    until queue.empty?
      current_node = queue.shift
      new_move_positions(current_node.value).each do |new_child_position|
        new_child_node = PolyTreeNode.new(new_child_position)
        current_node.add_child(new_child_node)
        queue << new_child_node
      end
    end
    @move_tree = root
  end

  def find_path(end_position)
    leaf_node = @move_tree.dfs(end_position)
  end

  def trace_path_back(leaf_node)
    path_array = []
    until leaf_node.parent.nil?
      path_array << leaf_node.value
      leaf_node = leaf_node.parent
    end
    path_array << @starting_position
    path_array.reverse!
  end



end
