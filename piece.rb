class Piece
  attr_reader :color

  def initialize(pos)
    @position = pos
    @color = pos.first.between?(0,1) ? :blue : :magenta
  end

  def moves
  end

  def to_s
    " P "
  end
end
