require "singleton"
require_relative "sliding_piece.rb"
require_relative "stepping_piece.rb"

class Piece
  attr_accessor :board, :position, :color

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end

  def moves

  end


  def to_s
    symbol
  end

  def empty?
    self.is_a?(NullPiece)
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def color
     ""
  end
  def symbol
     " "
  end

  def moves

  end

end

class Bishop < Piece
  include SlidingPiece

  def symbol
    return "♝" if @color == :black
    return "♗" if @color == :white
  end

  def move_dirs
    [:up_left, :up_right, :down_left, :down_right]
  end
end

class Rook < Piece
  include SlidingPiece

  def symbol
    return "♜" if @color == :black
    return "♖" if @color == :white
  end

  def move_dirs
    [:up,:down,:left,:right]
  end
end

class Queen < Piece
  include SlidingPiece
  def symbol
    return "♛" if @color == :black
    return "♕" if @color == :white
  end

  def move_dirs
    [:up,:down,:left,:right,:up_left, :up_right, :down_left, :down_right]
  end
end

class King < Piece

  include SteppingPiece

  def symbol
    return "♚" if @color == :black
    return "♔" if @color == :white
  end

  def move_dirs
    [:up,:down,:left,:right,:up_left, :up_right, :down_left, :down_right]
  end
end

class Knight < Piece

  include SteppingPiece

  def symbol
    return "♞" if @color == :black
    return "♘" if @color == :white
  end

  def move_dirs
    [:knight1, :knight2, :knight3, :knight4, :knight5, :knight6, :knight7, :knight8 ]
  end
end

class Pawn < Piece

  include SteppingPiece

  MOVES = {
    up_right: [1, 1],
    up_left: [1, -1],
    down_right: [-1, 1],
    down_left: [-1, -1],
  }

  def symbol
    return "♟" if @color == :black
    return "♙" if @color == :white
  end

  def move_dirs
    if at_start_row?
      if @color == :black
        dir =[:up, :init_up]
        [:up_left, :up_right].each do |move|
          row = @position[0] + MOVES[move][0]
          col = @position[1] + MOVES[move][1]
          pos_check = [row,col]
          dir << move if @board[pos_check].class != NullPiece && board.in_range?(pos_check)
        end
        return dir
      else
        dir =[:down, :init_down]
        [:down_left, :down_right].each do |move|
          row = @position[0] + MOVES[move][0]
          col = @position[1] + MOVES[move][1]
          pos_check = [row,col]
          dir << move if @board[pos_check].class != NullPiece
        end
        return dir
      end
    else
      if @color == :black
        dir =[:up]
        [:up_left, :up_right].each do |move|
          row = @position[0] + MOVES[move][0]
          col = @position[1] + MOVES[move][1]
          pos_check = [row,col]
          dir << move if @board[pos_check].class != NullPiece
        end
        return dir
      else
        dir =[:down]
        [:down_left, :down_right].each do |move|
          row = @position[0] + MOVES[move][0]
          col = @position[1] + MOVES[move][1]
          pos_check = [row,col]
          dir << move if @board[pos_check].class != NullPiece
        end
        return dir
      end
    end
  end

  def at_start_row?
    if @color == :black
      return true if @position[0] == 1
    else
      return true if @position[0] == 6
    end
    false
  end

end
