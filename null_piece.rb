require 'singleton'

class NullPiece
  include Singleton
  attr_reader :color

  def initialize
  end

  def moves
  end

  def color
    :blue
  end

  def to_s
    "   "
  end
end
