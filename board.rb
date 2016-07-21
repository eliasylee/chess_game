require_relative 'piece'
require_relative 'null_piece'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'
require_relative 'invalid_move_error'

class Board
  attr_accessor :rows

  def initialize(rows = Array.new(8) {Array.new(8)})
    @rows = rows
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
            self[pos] = Queen.new(pos, self)
          when 4
            self[pos] = King.new(pos, self)
          end
        else
          self[pos] = NullPiece.instance
        end
      end
    end
  end

  def move_piece!(start_pos, end_pos)
    if self[end_pos].is_a?(NullPiece)
      self[end_pos], self[start_pos] = self[start_pos], self[end_pos]
    else
      take_piece(start_pos, end_pos)
    end

    self[end_pos].position = end_pos
  end

  def take_piece(start_pos, end_pos)
    self[end_pos], self[start_pos] = self[start_pos], NullPiece.instance
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]
    if piece.valid_moves.include?(end_pos)
      move_piece!(start_pos, end_pos)
    else
      raise InvalidMoveError
    end
  end

  def in_bounds?(pos)
    x, y = pos
    x.between?(0,7) && y.between?(0,7)
  end

  def in_check?(color)
    king_pos = find_king(color)

    @rows.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        if piece.color != color
          return true if piece.moves.include?(king_pos)
        end
      end
    end

    false
  end

  def checkmate?(color)
    if in_check?(color)
      # debugger
      @rows.each do |row|
        row.each do |piece|
          if piece.color == color
            return false unless piece.valid_moves.empty?
          end
        end
      end

      return true
    end

    false
  end

  def find_king(color)
    king_pos = nil
    @rows.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        king_pos = [i, j] if piece.is_a?(King) && color == piece.color
        return king_pos unless king_pos.nil?
      end
    end
  end

  def deep_dup
    dup_rows = []
    dup_board = Board.new

    self.rows.each do |row|
      dup_row = []

      row.each do |piece|
        if piece.is_a?(NullPiece)
          dup_row << piece
          next
        end

        dup_piece = piece.dup
        dup_piece.board = dup_board
        dup_row << dup_piece
      end

      dup_rows << dup_row
    end

    dup_board.rows = dup_rows
    dup_board
  end

  # def move_piece!(color, from_pos, to_pos)
  #
  # end
  #
  # def move_piece(from_pos, to_pos)
  #   self.dup.move_piece!(from_pos, to_pos)
  # end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @rows[row][col] = value
  end

end
