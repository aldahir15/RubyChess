require_relative 'board.rb'
require_relative 'cursor.rb'
require 'colorize'

class Display

  def initialize(board)
    @cursor = Cursor.new([0,0],board)
    @board = board
    # render
    # new_pos = @cursor.get_input
    # move(new_pos)
  end

  def move(new_pos)
    curr = @cursor.cursor_pos
    @board[new_pos] = @board[curr]
    # @board[curr] = NullPiece.instance()
  end

  def render
    puts "  #{(0...@board.grid.size).to_a.join(" ")}"
    @board.grid.each_with_index do |row, i|
      puts "#{i} #{row.map do |x|
       x
      end.join(" ")}"
    end
  end
end


# PAWN MOVES
# b = Board.new
# start_pos = [5,1]
# b[start_pos] = "P".colorize(:blue)
# r = Pawn.new(b, start_pos, :white)
# b[[4,2]] = "S"
# b[[4,0]] = "S"
# b[[4,1]] = "S"
# b[[3,1]] = "S"
# r.moves.each_with_index do |move, i|
#   b.move_piece(start_pos, move)
#   b[start_pos] = "P".colorize(:blue) unless i == r.moves.size - 1
# end
# b[[5,3]] = Knight.new(b, [5,3], :black)
# d = Display.new(b)
# p b.find_king(:white)
# p b.possible_moves(:black)
# p b.in_check?(:white)
# p b.checkmate?(:white)
# d.render

# b = Board.new
# start_pos = [6,1]
# # b[start_pos] = "P".colorize(:blue)
# r = Pawn.new(b, start_pos, :white)
# p r.at_start_row?
