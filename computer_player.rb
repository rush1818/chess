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
    # begin
    #   @board.get_move(self)
    # rescue StandardError => e
    #   puts e.msg
    #   sleep (1)
    #   retry
    # end
    #move_piece(start_pos, end_pos)
    #all pieces board.find_pieces(color)
    #iterate and find all valid_moves each
    #choose at random
    # d = Display.new(@board).cursor
    begin
      @board.render_board("computer")
      random_piece = @board.find_pieces(color).shuffle.sample
      condition_to_check = random_piece.is_a?(Pawn) ? random_piece.moves : random_piece.valid_moves?
      while condition_to_check.empty?
        random_piece = @board.find_pieces(color).sample
        condition_to_check = random_piece.is_a?(Pawn) ? random_piece.moves : random_piece.valid_moves?
      end
      start_pos = random_piece.pos
      end_pos = condition_to_check.shuffle.sample
      @board.move_piece(start_pos, end_pos)
    rescue StandardError => e
      puts e.msg
      sleep (1)
      retry
    end
  end



end
