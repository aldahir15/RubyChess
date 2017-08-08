require "singleton"
require_relative "sliding_piece.rb"
# require_relative "board"

class Piece
  attr_reader :board, :position

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

  end
end

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def color
     "black"
  end
  def symbol
     "N"
  end

  def moves

  end

end

class Bishop < Piece
  include SlidingPiece

  def symbol
     "B"
  end

  def move_dirs
    [:up_left, :up_right, :down_left, :down_right]
  end
end

class Rook < Piece
  include SlidingPiece

  def symbol
     "R"
  end

  def move_dirs
    [:up,:down,:left,:right]
  end
end

class Queen < Piece
  include SlidingPiece
  def symbol
     "Q"
  end

  def move_dirs
    [:up,:down,:left,:right,:up_left, :up_right, :down_left, :down_right]
  end
end

class Knight < Piece

end

# r = Rook.new(Board.new, [0,0], "black")
# p r.moves
