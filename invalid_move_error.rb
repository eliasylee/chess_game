class InvalidMoveError < StandardError

  def initialize(msg = "Invalid move; input move again.")
    super
  end
end
