require_relative 'board.rb'
require_relative 'display.rb'
require_relative 'player.rb'

class Game
  attr_reader :board, :display, :player1, :player2

  def initialize(board = Board.new, player1, player2)
    @board = board
    @display = Display.new(@board)
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @next_player = player2
  end

  def play
    until @board.game_over?
      take_turn
      puts "You're in check" if @board.in_check?(@next_player.color)
      switch_players!
    end
    puts "Checkmate!"
  end

  def take_turn
    begin
      @display.render
      input = @current_player.make_move
      piece, new_pos = input
      # p @board[piece].moves
      raise StandardError unless @board[piece].moves.include?(new_pos) && @board[piece].color == @current_player.color
      @board.move_piece(piece, new_pos)
    rescue
      retry
    ensure
      @display.render
    end
  end

  def switch_players!
    @current_player, @next_player = @next_player, @current_player
  end

end

first_player = Player.new("Jose", :black)
second_player = Player.new("Alex", :white)
new_game = Game.new(Board.new, first_player, second_player )
new_game.play
