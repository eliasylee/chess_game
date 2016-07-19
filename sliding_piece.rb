module SlidingPiece

  def moves
    moves = []
    move_dirs.each do |dir|
      while true
        end_pos = [@position.first + dir.first, @position.last + dir.last]
        break if not_valid?(end_pos) || piece_taken?(end_pos)
        moves << end_pos
      end
    end

    moves
  end

  def not_valid?(end_pos)
    x, y = end_pos
    return true unless x.between?(0,7) && y.between?(0,7)
    return true if @board[end_pos].color == self.color
    false
  end

  def piece_taken?(end_pos)
    @board[end_pos].color != self.color
  end

end
