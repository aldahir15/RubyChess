require_relative 'board.rb'
require_relative 'display.rb'

class Game
  attr_reader :board, :display

  def initialize(board = Board.new)
    @board = board
    @display = Display.new(@board)
  end

  def play
    until @board.game_over?
      take_turn
    end
  end

  def take_turn
    puts "Pick a move (ie. [0,0])"
  end

end

new_game = Game.new
new_game.display.render
