require_relative 'stepping_piece'
require_relative 'piece'

class King < Piece
  include SteppingPiece

  def move_dirs
    [[0, -1], [0, 1], [-1, 0], [1, 0], [1,1], [1,-1], [-1,1], [-1,-1]]
  end

  def to_s
    " \u265A ".encode('utf-8')
  end

end
