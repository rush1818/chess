require_relative 'board'
require_relative 'player'
require_relative 'computer_player'
require 'byebug'
class Game

  attr_reader :current_player

  def initialize(player1 = nil, player2 = nil)
    @board = Board.new(true)
    @player1 = player1 || HumanPlayer.new("P1",:white)
    @player2 = player2 || HumanPlayer.new("P2", :black)
    @current_player = @player1
    pass_board_to_players
  end

  def pass_board_to_players
    @player1.get_board(@board)
    @player2.get_board(@board)
  end

  def play_game
    until game_over?
      begin
        @current_player.play_turn
        # @board.get_move(@current_player)
      rescue StandardError => e
        puts e.msg
        sleep (1)
        retry
      end
      switch_players
    end
    switch_players
    puts "Checkmate! #{@current_player.color.to_s.capitalize} won."
  end

  private
  attr_reader :player1, :player2

  def game_over?
    @board.checkmate?(:white) || @board.checkmate?(:black)
  end

  def switch_players
    @current_player = (@current_player == @player1 ? @player2 : @player1)
  end

end

if __FILE__ == $PROGRAM_NAME
  p 'Enter 1 to play against AI or 2 to play against another player.'
  input = gets.chomp

  if input == '1'
    game = Game.new(HumanPlayer.new("P1",:white), ComputerPlayer.new("AI", :black) )
  else
    game = Game.new(HumanPlayer.new("P1",:white), HumanPlayer.new("AI", :black) )
  end
  game.play_game
end
