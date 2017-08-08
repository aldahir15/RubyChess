require "singleton"
require_relative "sliding_piece.rb"
require_relative "stepping_piece.rb"

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

class King < Piece

  include SteppingPiece

  def symbol
    "K"
  end

  def move_dirs
    [:up,:down,:left,:right,:up_left, :up_right, :down_left, :down_right]
  end
end

class Knight < Piece

  include SteppingPiece

  # MOVES = {
  #   knight1: [2,1],
  #   knight2: [-2,1],
  #   knight3: [-2,-1],
  #   knight4: [2,-1],
  #   knight5: [1,2],
  #   knight6: [1,-2],
  #   knight7: [-1,2],
  #   knight8: [-1,-2]
  # }

  def symbol
    "L"
  end

  def move_dirs
    [:knight1, :knight2, :knight3, :knight4, :knight5, :knight6, :knight7, :knight8 ]
  end
end

# r = Rook.new(Board.new, [0,0], "black")
# p r.moves
