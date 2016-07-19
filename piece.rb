class Piece
  attr_reader :color

  def initialize(pos, board)
    @board = board
    @position = pos
    @color = pos.first.between?(0,1) ? :black : :light_white
  end

  def moves
  end

  def to_s
    " P "
  end
end
