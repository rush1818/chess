require 'colorize'
require_relative 'cursorable'

class Display
  include Cursorable
  attr_accessor :show_alert
  def initialize(board = Board.new, cursor_pos)
    @board = board
    @cursor_pos = cursor_pos
    @show_alert = false
  end

  def cursor
    input = get_input
    @selected = false
    if input
      @cursor = @cursor_pos
      @selected = true
    end
  end

  def alert_player(color)
    @show_alert = true
    @color = color
    puts
    puts "#{color.to_s.upcase} is in check"
    sleep (1)
  end

  def render(computer = true)
    @computer = computer
    until false
      system 'clear'
      @board.grid.each_with_index do |row, id1|
        puts
        row.each.with_index do |piece, id2|
          if [id1, id2] == @cursor_pos && !@computer
            print (" " + piece.to_s + " ").colorize(:background => :light_red)
          else
            if (id1 % 2 == 0 && id2 % 2 == 0) || (id1 % 2 != 0 && id2 % 2 != 0)
              print (" " + piece.to_s  + " ").colorize(:background => :light_white)
            else
              print (" " + piece.to_s + " ").colorize(:background => :light_black)
            end
          end
        end
      end
      alert_player(@color) if @show_alert == true
      puts
      cursor unless @computer
      sleep(0.5) if @computer
      return (@cursor) if @selected || @computer
    end
  end

end
