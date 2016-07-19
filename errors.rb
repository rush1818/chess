class InvalidMoveError < StandardError
  attr_reader :msg
  def initialize
    super
    @msg = "Invalid move, try again"
  end
end


class IncorrectPieceError < StandardError
  attr_reader :msg
  def initialize
    super
    @msg = "That's not your piece! Try again."
  end
end

class EmptySquareError < StandardError
  attr_reader :msg
  def initialize
    super
    @msg = "There's no piece there!"
  end
end


class GameCheckError < StandardError
  attr_reader :msg
  def initialize
    super
    @msg = "Invalid move, your King will be in check!"
  end
end
