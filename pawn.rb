require_relative 'piece'
require 'byebug'

class Pawn < Piece

  def initialize(pos, board)
    @starting_row = pos.first == 1 ? 1 : 6
    super
  end

  def moves
    moves = []
    
    move_dirs.each do |dir|
      end_pos = [@position.first + dir.first, @position.last]
      moves << end_pos unless not_valid_moves?(end_pos, dir)
    end

    moves + side_attacks(@position)
  end

  def move_dirs
    @starting_row == 1 ? [[2,0], [1,0]] : [[-2,0], [-1,0]]
  end

  def side_attacks(end_pos)
    attacks = @starting_row == 1 ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]]
    attacks.select { |attack| attack unless not_valid_attack?(attack) }
  end

  def not_valid_moves?(end_pos, dir)
    x, y = end_pos
    return true unless x.between?(0,7) && y.between?(0,7)
    return true unless @board[end_pos].is_a?(NullPiece)
    if dir.first.abs == 2
      return true unless @position.first == @starting_row
      mid_pos = [end_pos[0] - dir[0]/2, end_pos[1] - dir[1]/2]
      return true unless @board[mid_pos].is_a?(NullPiece)
    end
    false
  end

  def not_valid_attack?(attack)
    end_pos = [@position.first + attack.first, @position.last + attack.last]
    return true unless @board[end_pos].is_a?(Piece)
    return true unless @board[end_pos].color != self.color
    false
  end

  def to_s
    " \u265F ".encode('utf-8')
  end

end
