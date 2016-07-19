require_relative 'sliding'

class Queen < Piece

  include Sliding

  def symbol
    "\u265B".encode('utf-8').colorize(color)
  end

  def move_dirs
    diagonal_dirs + updown_dirs
  end

end
