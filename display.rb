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
    puts "#{color.to_s.upcase} is in check"
    sleep (2)
  end

  def render
    until false
      system 'clear'
      @board.grid.each_with_index do |row, id1|
        1.times { puts }
        row.map.with_index do |piece, id2|
          if [id1, id2] != @cursor_pos
            if (id1 % 2 == 0 && id2 % 2 == 0) || (id1 % 2 != 0 && id2 % 2 != 0)
              print (" " + piece.to_s  + " ").colorize(:background => :light_white)
            else
              print (" " + piece.to_s + " ").colorize(:background => :light_black)
            end
          else
            print (" " +piece.to_s + " ").colorize(:background => :light_red)
          end
        end
      end
      alert_player(@color) if @show_alert == true
      puts
      cursor
      return (@cursor) if @selected
    end
  end

end
