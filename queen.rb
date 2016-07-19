require_relative 'sliding_piece'
require_relative 'piece'

class Queen < Piece
  include SlidingPiece

  def moves_dirs
    [[0, -1],[0, 1],[-1, 0], [1, 0], [1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def to_s
    " \u265B ".encode('utf-8')
  end

end
