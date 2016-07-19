require_relative 'board'
require_relative 'player'

class Game

  attr_reader :player1, :player2, :current_player

  def initialize( player1 = HumanPlayer.new("P1",:white), player2 = HumanPlayer.new("P2", :black) )
    @board = Board.new(true)
    @player1, @player2 = player1, player2
    @current_player = @player1
  end

  def switch_players
    @current_player = (@current_player == @player1 ? @player2 : @player1)
  end

  def play_game
    until game_over?
      begin
        @board.get_move(@current_player)
      rescue StandardError => e
        puts e.msg
        sleep (1)
        retry
      end
      # @current_player.play_turn
      switch_players
    end
  end

  def game_over?
    @board.checkmate?(:white) || @board.checkmate?(:black)
  end

end

game = Game.new
game.play_game
