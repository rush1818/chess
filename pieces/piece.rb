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
    @board[pos] = self
  end

  def empty?
    false
  end

  def to_s
    self.symbol
  end

  def valid_moves?
    self.moves.reject{|new_pos| move_into_check?(new_pos)}
  end

  def move_to(end_pos)
    @pos = end_pos
    @board[@pos] = self
  end

  def move_into_check?(new_pos)
    new_board = @board.dup
    new_board.move_piece(@pos, new_pos)
    new_board.in_check?(color)
  end

end
