require_relative 'sliding_piece'
require_relative 'piece'

class Rook < Piece
  include SlidingPiece

  def move_dirs
    [[0, -1], [0, 1], [1, 0], [-1, 0]]
  end

  def to_s
    " \u265C ".encode('utf-8')
  end

end
