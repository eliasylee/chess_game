require 'byebug'
require_relative 'piece'
require_relative 'null_piece'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'


class Board
  attr_reader :rows

  # NULL = NullPiece.instance

  def initialize
    @rows = Array.new(8) {Array.new(8)}
  end

  def populate_board
    @rows.each_with_index do |row, row_idx|
      row.each_with_index do |el, col_idx|
        pos = [row_idx, col_idx]
        case pos.first
        when 1, 6
          self[pos] = Pawn.new(pos, self)
        when 0, 7
          case pos.last
          when 0, 7
            self[pos] = Rook.new(pos, self)
          when 1, 6
            self[pos] = Knight.new(pos, self)
          when 2, 5
            self[pos] = Bishop.new(pos, self)
          when 3
            self[pos] = pos.first == 7 ? Queen.new(pos, self) : King.new(pos, self)
          when 4
            self[pos] = pos.first == 7 ? King.new(pos, self) : Queen.new(pos, self)
          end
        else
          self[pos] = NullPiece.instance
        end
      end
    end
  end

  def move(start_pos, end_pos)
    #TODO: raise MoveError unless self[start_pos] = NullPiece
    #TODO: raise OtherMoveError piece cannot move to end_pos
    self[end_pos], self[start_pos] = self[start_pos], self[end_pos]
    self[end_pos].position = end_pos
  end

  def in_bounds?(pos)
    x, y = pos
    x.between?(0,7) && y.between?(0,7)
  end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @rows[row][col] = value
  end

end
