require_relative 'board.rb'
require_relative 'cursor.rb'
require 'colorize'

class Display

  def initialize(board)
    @cursor = Cursor.new([0,0],board)
    @board = board
    render
    new_pos = @cursor.get_input
    move(new_pos)
  end

  def move(new_pos)
    curr = @cursor.cursor_pos
    @board[new_pos] = @board[curr].colorize(:blue)
    @board[curr] = NullPiece.instance()
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

b = Board.new
b[[0,0]] = "p"
d = Display.new(b)
d.render
