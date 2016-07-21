class InvalidMoveError < StandardError

  def initialize(msg = "Invalid move! Please input move again.")
    super
  end
end
