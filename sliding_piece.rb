require "byebug"

module SlidingPiece

  HORIZONTAL_MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [1, 0],
    down: [-1, 0],
    up_right: [1, 1],
    up_left: [1, -1],
    down_right: [-1, 1],
    down_left: [-1, -1]
  }

  def moves
    moves = []
    move_dirs.each do |dir|
      row, col = HORIZONTAL_MOVES[dir]
      moves += grow_unblocked_moves_in_dir(row, col)
    end
    moves
  end

  private

  def grow_unblocked_moves_in_dir(dx, dy)
    moves = []
    current_pos_dup = @position.dup
    while (0..7).cover?(current_pos_dup[0]) && (0..7).cover?(current_pos_dup[1])
      current_pos_dup[0] += dx
      current_pos_dup[1] += dy
      unless current_pos_dup[0] < 0 || current_pos_dup[1] < 0
        moves << current_pos_dup.dup
      end
    end
    moves
  end
end
