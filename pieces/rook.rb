require_relative 'sliding'

class Rook < Piece

  include Sliding

  def symbol
    "\u265C".encode('utf-8').colorize(color)
  end

  def move_dirs
    updown_dirs
  end

end
