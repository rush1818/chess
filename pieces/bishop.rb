require_relative 'sliding'

class Bishop < Piece

  include Sliding

  def symbol
    "\u265D".encode('utf-8').colorize(color)
  end

  def move_dirs
    diagonal_dirs
  end

end
