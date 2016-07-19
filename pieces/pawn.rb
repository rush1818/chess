require_relative 'stepable'

class Pawn < Piece
  include Stepable

  def initialize(color, board, pos)
    super
    @moved = false
    top?
  end

  def symbol
     '♟'.colorize(color)
  end

  def move_diffs
    #if it is at bottom
    attack_moves = [[-1,-1],[-1,1] ]
    normal_moves = [[-1,0]]
    first_move = [[-2,0]]

    if @top
      attack_moves = [[1,-1],[1,1]]
      normal_moves = [[1,0]]
      first_move = [[2,0]]
    end

    if @moved == false
      moves = normal_moves + attack_moves + first_move
    else
      moves = normal_moves + attack_moves
    end
    @moved = true
    moves
  end

  def top?
    rows = @board.grid.length
    if @pos[0] < rows/2
      @top = true
    else
      @top = false
    end
  end

  protected
  attr_accessor :top
end
