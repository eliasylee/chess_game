class HumanPlayer

  attr_reader :color, :name

  def initialize(name, color)
    @name = name
    @color = color
  end

  def make_move
    puts "Now accepting move from #{name}."
  end
end
