#require_relative 'display'
require_relative 'pieces'
# require_relative 'display'

class Board

  attr_reader :grid

  def initialize
    @null_piece = NullPiece.instance
    make_starting_grid
  end

  def make_starting_grid
    @grid = Array.new(8) { Array.new(8, @null_piece) }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  # def is_nil?(pos)
  #   self[pos].nil?
  # end

  def empty?(pos)
    self[pos].empty?
  end

  def valid_pos?(pos)
    valid = pos.all? { |el| el.between?(0,7) }
    # raise ArgumentError.new "Not within board range" unless valid
    valid
  end

  def move_piece(start_pos, end_pos)
    if empty?(start_pos)
      raise ArgumentError.new "There is no piece there"
    end
    if valid_pos?(start_pos)
      piece_to_move = self[start_pos]
      raise "Piece cannot move into that spot" unless piece_to_move.valid_moves.include?(end_pos)
      piece_to_move.move(end_pos)
      self[start_pos] = @null_piece
    end

  end
end
# Piece requires (color, board, pos)
