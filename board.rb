require_relative 'pieces'
require_relative 'display'
require_relative 'errors'
require 'byebug'


class Board

  attr_reader :grid

  def initialize(fill_board = true)
    @null_piece = NullPiece.instance
    make_empty_grid(fill_board)
    @last_cursor =[4,4]
    @display = Display.new(self, @last_cursor)
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def in_check?(color)
    position_king = find_king_pos(color)
    opposite_moves = []
    @grid.flatten.each do |piece|
      next if piece.color == color
      moves = (piece.is_a?(Pawn) ? piece.attack_positions : piece.moves)
      opposite_moves.concat(moves)
    end
    opposite_moves.include?(position_king)
  end

  def checkmate?(color)
    return false unless in_check?(color)
    all_pieces = find_pieces(color)
    all_pieces.each do |piece|
      return false if piece.valid_moves? != []
    end
    true
  end

  def empty?(pos)
    self[pos].empty?
  end

  def valid_pos?(pos)
    pos.all? { |el| el.between?(0,7) }
  end

  def move_piece(start_pos, end_pos)
    if valid_pos?(start_pos)
      piece_to_move = self[start_pos]
      raise InvalidMoveError.new unless piece_to_move.moves.include?(end_pos)
      piece_to_move.move_to(end_pos)
      self[start_pos] = @null_piece
    end
  end

  def dup
    dupped_board = Board.new(false)
    all_pieces = find_pieces(:black).concat(find_pieces(:white))

    all_pieces.each do |piece|
      piece.class.new(piece.color, dupped_board, piece.pos)
    end
    dupped_board
  end

  def get_move(current_player)
    @display = Display.new(self, @last_cursor)
    # start_pos = display.render
    start_pos = render_board
    start_piece = self[start_pos]
    raise EmptySquareError if start_piece == @null_piece
    raise IncorrectPieceError if start_piece.color != current_player.color
    end_pos = render_board
    @last_cursor = end_pos
    dupped_board = self.dup
    dupped_board.move_piece(start_pos, end_pos)
    raise GameCheckError if dupped_board.in_check?(current_player.color)
    other_player_color = current_player.color == :black ? :white : :black
    move_piece(start_pos, end_pos)
    display.alert_player(other_player_color) if dupped_board.in_check?(other_player_color)
  end

  def render_board(type = "human")
    @display.render( type == "computer" ? true : false)
  end

  def find_pieces(color)
    @grid.flatten.select { |piece| !piece.is_a?(NullPiece) && piece.color == color }
  end

  private
  def make_empty_grid(fill_board)
    @grid = Array.new(8) { Array.new(8, @null_piece) }
    make_starting_grid if fill_board
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

  def find_king_pos(color)
    @grid.flatten.each { |piece| return piece.pos if piece.is_a?(King) && piece.color == color }
  end

end
