require_relative "piece.rb"

class Board
  attr_reader :grid

  def self.empty_grid
    Array.new(8) do
      Array.new(8) { NullPiece.instance }
    end
  end

  def initialize(grid = Board.empty_grid)
    @grid = grid
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def move_piece(start_pos, end_pos)
    begin
      piece = self[start_pos]
      raise StandardError if piece == nil && self[end_pos] != nil
      self[end_pos] = piece
      self[start_pos] = nil
    rescue
      puts "Bad move!"
    end
  end

end

# b = Board.new
# pos = [0,0]
# b[pos] = Piece.new
# b.move_piece([0,0], [1,1])
# p b.grid
b = Board.new
r = Queen.new(b, [0,0], "black")
p r.moves
