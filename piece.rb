class Piece
  attr_reader :color
  attr_accessor :board, :position

  def initialize(pos, board)
    @board = board
    @position = pos
    @color = pos.first.between?(0,1) ? :black : :white
  end

  def moves
  end

  def valid_moves
    self.moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    new_board = @board.deep_dup
    new_board.move_piece!(@position, end_pos)
    new_board.in_check?(@color)
  end

  def to_s
    " P "
  end

end
