require_relative 'sliding'

class Rook < Piece

  include Sliding

  def symbol
    '♜'.colorize(color)
  end

  def move_dirs
    updown_dirs
  end

end
