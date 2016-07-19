require_relative 'stepping_piece'
require_relative 'piece'

class Knight < Piece
  include SteppingPiece

  def move_dirs
    [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]
  end

  def to_s
    " \u265E ".encode('utf-8')
  end

end
