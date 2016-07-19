require_relative 'piece'

class Pawn < Piece

  ALL_ATTACK_MOVES = [[-1,-1],[-1,1] ,[1,-1],[1,1]]

  attr_reader :top

  def initialize(color, board, pos)
    super
    @moved = false
    @positions_it_can_attack = []
    top?
  end

  def symbol
    "\u265F".encode('utf-8').colorize(color)
  end

  def valid_moves?
    self.attack_positions.reject{|new_pos| move_into_check?(new_pos)}
  end

  def moves
    possible_moves = []
    move_types = move_diffs
    move_types.each do |div|
      drow, dcol = div
      new_pos = [@pos[0] + drow, @pos[1] + dcol]
      if @board.valid_pos?(new_pos)
        byebug if @board[new_pos].nil?
        if @board[new_pos].empty? && !ALL_ATTACK_MOVES.include?(div)
          possible_moves << new_pos
        elsif !@board[new_pos].empty? && ALL_ATTACK_MOVES.include?(div) && @board[new_pos].color != color
          possible_moves << new_pos
          @positions_it_can_attack << new_pos
        end
      end
    end
    possible_moves
  end

  def attack_positions
    @positions_it_can_attack
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
