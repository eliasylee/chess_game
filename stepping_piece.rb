module SteppingPiece

  def moves
    moves = []
    move_dirs.each do |dir|
      end_pos = [@position.first + dir.first, @position.last + dir.last]
      moves << end_pos unless not_valid?(end_pos)
    end

    moves
  end

  def not_valid?(end_pos)
    x, y = end_pos
    return true unless x.between?(0,7) && x.between?(0,7)
    return true if @board[end_pos].color == self.color
    false
  end

end
