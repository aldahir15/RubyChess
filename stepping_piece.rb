module SteppingPiece

  MOVES = {
    left: [0, -1],
    right: [0, 1],
    up: [1, 0],
    down: [-1, 0],
    up_right: [1, 1],
    up_left: [1, -1],
    down_right: [-1, 1],
    down_left: [-1, -1],
    knight1: [2,1],
    knight2: [-2,1],
    knight3: [-2,-1],
    knight4: [2,-1],
    knight5: [1,2],
    knight6: [1,-2],
    knight7: [-1,2],
    knight8: [-1,-2],
    init_up: [2,0],
    init_down: [-2,0],
  }

  def moves
    moves = []
    move_dirs.each do |dir|
      row, col = MOVES[dir]
      moves += move_diffs(row, col)
    end
    moves
  end

  def move_diffs(dx,dy)
    moves = []
    current_pos_dup = @position.dup
    current_pos_dup[0] += dx
    current_pos_dup[1] += dy
    unless current_pos_dup[0] < 0 || current_pos_dup[1] < 0
      if board.in_range?(current_pos_dup) && @board[current_pos_dup].color != color
        moves << current_pos_dup.dup
      end
    end
    moves
  end

end
