require_relative 'piece'

class Pawn < Piece

  ALL_ATTACK_MOVES = [[-1,-1],[-1,1] ,[1,-1],[1,1]]

  attr_reader :top

  def initialize(color, board, pos)
    super
    @moved = false
    top?
  end

  def symbol
     '♟'.colorize(color)
  end

  def moves
    possible_moves = []
    move_diffs.each do |div|
      drow, dcol = div
      new_pos = [@pos[0] + drow, @pos[1] + dcol]
      if @board[new_pos].empty? && !ALL_ATTACK_MOVES.include?(div)
        possible_moves << new_pos
      elsif !@board[new_pos].empty? && ALL_ATTACK_MOVES.include?(div) && @board[new_pos].color != color
        possible_moves << new_pos
      end
    end
    possible_moves
  end

  def attack_moves
    @top ? [[1,-1],[1,1] ] : [[-1,-1],[-1,1]]
  end

  def move_diffs
    piece_moves = (@top ?  [[1,0]] : [[-1,0]] )
    first_move = (@top ?  [[2,0]] : [[-2,0]] )

    piece_moves.concat(first_move) unless @moved
    piece_moves.concat(attack_moves)
    @moved = true
    piece_moves
  end

  def top?
    @top = (self.color == :black ? true : false)
  end

  protected
  attr_accessor :top
end
