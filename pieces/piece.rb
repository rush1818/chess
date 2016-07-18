require_relative "../board"
require 'byebug'
class Piece
  attr_reader :pos, :color, :moves

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def empty?
    false
  end
end


class SlidingPiece < Piece
  DIAGONAL = [ [1,1],[-1,-1], [1,-1], [-1, 1] ]
  DIRECTIONS = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  def initialize(color, board, pos, diagonal = false, updown = false)
    @diagonal = diagonal
    @updown = updown
    super(color, board, pos)
  end
  def inspect
    p "Position"
    p @pos
    p "******"
    p "Color"
    p @color
  end

  # def diagonal_moves
  #
  #   diagonal_pos = []
  #   DIAGONAL.each do |dir|
  #     x, y = @pos
  #     new_pos = [x + dir[0], y + dir[1] ]
  #     while @board.valid_position?(new_pos)
  #       i, j = new_pos
  #       diagonal_pos << new_pos
  #       new_pos = [i + dir[0], j + dir[1] ]
  #     end
  #     # @moves << diagonal_moves
  #   end
  #   diagonal_pos.sort
  # end

  # def updown_moves
  #   updown_pos = []
  #
  #   DIRECTIONS.each do |dir|
  #     x, y = @pos
  #     new_pos = [x + dir[0], y + dir[1] ]
  #     while @board.valid_position?(new_pos)
  #       updown_pos << new_pos
  #       i, j = new_pos
  #       new_pos = [i + dir[0], j + dir[1] ]
  #       updown_pos << new_pos if @board.valid_position?(new_pos) && !@board.empty_spot?(new_pos) && @board[new_pos].color != self.color
  #       break if !@board.empty_spot?(new_pos)
  #
  #       #updown_pos << new_pos && break if
  #       # pushed = false
  #       # if @board.valid_position?(new_pos) && !@board.empty_spot?(new_pos)
  #       #   byebug
  #       #   updown_pos << new_pos if @board[new_pos].color != self.color
  #       #   pushed =  true
  #       # end
  #       # return updown_pos.sort if pushed
  #     end
  #     updown_pos.sort
  #   end

  end


  # def updown_dir(pos)
  #   directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  #   positions = []
  #   directions.each do |dir|
  #     # byebug
  #     x, y = pos
  #     positions << [x + dir[0], y + dir[1] ]
  #   end
  #   positions.select{|coord| @board.valid_position?(coord) && (@board.empty_spot?(coord) || @board[pos].color != @color)}
  # end
  #
  # def build_positions(pos)
  #   queue = [pos]
  #   explored_positions = []
  #   until queue.empty?
  #     current_pos = queue.shift
  #     explored_positions << current_pos
  #     adj = updown_dir(current_pos)
  #     adj.select! {|coord| !explored_positions.include?(coord)}
  #     explored_positions += adj
  #     other_piece = adj.select{|coord| @board[pos].color != @color}
  #     adj.delete(other_piece)
  #     queue += adj
  #     # byebug
  #   end
  #   explored_positions.uniq
  # end


end

class SteppingPiece < Piece

  def initialize(color, board, pos)
    super(color, board, pos)
  end
end
b = Board.new
b[[0,1]] = SlidingPiece.new("black", b, [0,1])
v = b[[0,1]]
p v
s = SlidingPiece.new("white", b, [0,3])
# p s.diagonal_moves
p "*" * 15
p s.updown_moves
#p s.build_positions(s.pos)
