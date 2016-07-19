class ComputerPlayer

  attr_reader :name, :color

  def initialize(name = "Android AI", color)
    @name = name
    @color = color
    @board = nil
  end

  def get_board(board)
    @board = board
  end

  def play_turn
    #move_piece(start_pos, end_pos)
    #all pieces board.find_pieces(color)
    #iterate and find all valid_moves each
    #choose at random
    # d = Display.new(@board).cursor
    random_piece = @board.find_pieces(color).shuffle.sample
    condition_to_check = random_piece.is_a?(Pawn) ? random_piece.moves : random_piece.valid_moves?
    while condition_to_check.empty?
      random_piece = @board.find_pieces(color).sample
      condition_to_check = random_piece.is_a?(Pawn) ? random_piece.moves : random_piece.valid_moves?
    end
    start_pos = random_piece.pos
    end_pos = condition_to_check.sample
    p "#{start_pos}         #{end_pos}"
    @board.move_piece(start_pos, end_pos)
  end



end
