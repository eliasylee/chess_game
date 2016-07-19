require_relative 'sliding_piece'
require_relative 'piece'

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    [[1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def to_s
    " \u265D ".encode('utf-8')
  end

end
