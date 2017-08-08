class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def make_move
    puts "#{@name}, pick a #{color} piece to move (ie. 1,0)"
    piece = gets.chomp.split(",").map(&:to_i)
    puts "To where? (ie. 2,0)"
    new_pos = gets.chomp.split(",").map(&:to_i)
    [piece, new_pos]
  end

end
