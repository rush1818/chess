#require_relative 'display'
require_relative 'pieces'
require_relative 'display'

class Board

  attr_reader :grid

  def initialize
    @null_piece = NullPiece.instance
    make_empty_grid
  end

  def make_empty_grid
    @grid = Array.new(8) { Array.new(8, @null_piece) }
    make_starting_grid
  end

  def make_starting_grid
    # Piece requires (color, board, pos)
    color = [:black, :white,:black, :white]
    [0,7,1,6].each do |r|
      c = color.shift
      @grid[r].each_with_index do |el, id|
        pos = [r,id]
        if r == 0 || r == 7
          Rook.new(c, self, [r,id]) if [0,7].include?(id)
          Bishop.new(c, self, [r,id]) if [2,5].include?(id)
          Knight.new(c, self, [r,id]) if [1,6].include?(id)
          Queen.new(c, self, [r,id]) if id == 3
          King.new(c, self, [r,id])  if id == 4
        elsif r == 1 || r == 6
          Pawn.new(c, self, [r,id])
        end
      end
    end

  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  #phase4
  def in_check?(color)
  end

  def checkmate?(color)
  end

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
b = Board.new
d = Display.new(b)
d.render
