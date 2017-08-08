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
    make_starting_grid
  end

  def populate_board
    self[[0,0]] = Rook.new(self, [0,0], :black)
    self[[0,1]] = Knight.new(self, [0,1], :black)
    self[[0,2]] = Bishop.new(self, [0,2], :black)
    self[[0,3]] = Queen.new(self, [0, 3], :black)
    self[[0,4]] = King.new(self, [0, 4], :black)
    self[[0,5]] = Bishop.new(self, [0,5], :black)
    self[[0,6]] = Knight.new(self, [0,6], :black)
    self[[0,7]] = Rook.new(self, [0,7], :black)

    self[[7,0]] = Rook.new(self, [7,0], :white)
    self[[7,1]] = Knight.new(self, [7,1], :white)
    self[[7,2]] = Bishop.new(self, [7,2], :white)
    self[[7,3]] = Queen.new(self, [7, 3], :white)
    self[[7,4]] = King.new(self, [7, 4], :white)
    self[[7,5]] = Bishop.new(self, [7,5], :white)
    self[[7,6]] = Knight.new(self, [7,6], :white)
    self[[7,7]] = Rook.new(self, [7,7], :white)
  end

  def make_starting_grid
    populate_board
    (1...2).each do |i|
      (0...8).each do |j|
        @grid[i][j] = Pawn.new(self, [i,j],:black)
      end
    end
    (6...7).each do |i|
      (0...8).each do |j|
        @grid[i][j] = Pawn.new(self, [i,j],:white)
      end
    end
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
    piece = self[start_pos]
    piece.position = end_pos
    self[end_pos] = piece
    self[start_pos] = NullPiece.instance
  end

  def in_check?(color)
    king_pos = find_king(color)
    color == :black ? other_color = :white : other_color = :black
    opposing_moves = possible_moves(other_color)
    opposing_moves.include?(king_pos) ? true : false
  end

  def checkmate?(color)
    color == :black ? other_color = :white : other_color = :black
    king_pos = find_king(color)
    king_moves = []
    king_moves += self[king_pos].moves unless self[king_pos].moves.empty?
    # king_moves << king_pos
    opposing_moves = possible_moves(other_color)
    opposing_moves += find_all_pieces_of_color(other_color)
    # p "king_moves: #{king_moves}"
    # p "opposing moves: #{opposing_moves.sort}"
    # return true if in_check?(color) && king_moves.length == 1
    king_moves.all? { |move| opposing_moves.include?(move) } && in_check?(color)
  end

  def game_over?
    self.checkmate?(:black) || self.checkmate?(:white)
  end

  def in_range?(pos)
    x, y = pos
    x < @grid.size && y < @grid.size
  end

  # protected

  def possible_moves(color)
    possible_moves = []
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |el, col_idx|
        if el.color == color
          possible_moves += el.moves
        end
      end
    end
    possible_moves
  end

  def find_king(color)
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |el, col_idx|
        if el.is_a?(King) && el.color == color
          return [row_idx, col_idx]
        end
      end
    end
  end

  def find_all_pieces_of_color(color)
    arr = []
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |el, col_idx|
        arr << [row_idx, col_idx] if el.color == color
      end
    end
    arr
  end

end

# b = Board.new
# pos = [0,0]
# b[pos] = Piece.new
# b.move_piece([0,0], [1,1])
# p b.grid
# b = Board.new
# r = Knight.new(b, [0,0], "black")
# p r.moves
# r.moves.each do |x|
#   b.move_piece([0,0], x)
# end
# new_dis = Display.new(b)
# new_dis.render
