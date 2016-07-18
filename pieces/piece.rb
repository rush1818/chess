require 'byebug'


class Piece

  attr_reader  :color, :moves, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    raise 'invalid color' unless [:white, :black].include?(color)
    raise 'invalid pos' unless board.valid_pos?(pos)
    @color = color
    @board = board
    @pos = pos
  end

  def empty?
    false
  end

  def to_s
    self.symbol
  end


end
