class HumanPlayer

  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
    @board = nil
  end

  def get_board(board)
    @board = board
  end

  def play_turn
    begin
      @board.get_move(self)
    rescue StandardError => e
      puts e.msg
      sleep (1)
      retry
    end
  end

end
