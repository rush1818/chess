require 'colorize'
require_relative 'cursorable'
require_relative 'board'

class Display
  include Cursorable
  def initialize(board = Board.new)
    @board = board
    @cursor_pos = [0,0]
    # @game = game
  end

  def cursor
    input = get_input
    @selected = false
    if input
      @cursor = @cursor_pos
      @selected = true
    end
  end

  def move(new_pos)

  end

  def render
    until false
      system 'clear'
      @board.grid.each_with_index do |row, id1|
        1.times { puts }
        row.map.with_index do |piece, id2|
          if [id1, id2] != @cursor_pos
            if (id1 % 2 == 0 && id2 % 2 == 0) || (id1 % 2 != 0 && id2 % 2 != 0)
              print (piece.to_s  + "  ").colorize(:background => :white)
            else
              print (piece.to_s + "  ").colorize(:background => :light_black)
            end
          else
            print (piece.to_s + "  ").colorize(:background => :light_red)
          end
        end
      end

      puts
      cursor
      move(@cursor) if @selected
    end
  end

end
#
display = Display.new
display.render
# [:black, :light_black, :red, :light_red, :green, :light_green,
# :yellow, :light_yellow, :blue, :light_blue, :magenta, :light_magenta,
# :cyan, :light_cyan, :white, :light_white, :default]
