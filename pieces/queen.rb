require_relative 'sliding'

class Queen < Piece

  include Sliding

  def symbol
    '♛'.colorize(color)
  end

  def move_dirs
    diagonal_dirs + updown_dirs
  end

end
