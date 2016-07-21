require 'colorize'
require_relative 'board'
require_relative 'cursorable'

class Display
  include Cursorable

  attr_accessor :selected

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @selected = nil
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)

    if [i, j] == @cursor_pos
      bg = @selected.nil? ? :light_red : :green
    elsif @selected && @board[@selected].valid_moves.include?([i,j])
      bg = :light_green
    elsif [i, j] == @selected
      bg = :green
    elsif (i + j).odd?
      bg = :light_black
    else
      bg = :light_white
    end

    { background: bg, color: @board[[i,j]].color }
  end

  def color_possible_moves(piece)
    piece.moves.each do |piece|
      piece.to_s.colorize({background: :light_green})
    end
  end

  def render
    system("clear")
    puts "Arrow keys or WASD to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
  end
end
