require_relative 'sliding'

class Bishop < Piece

  include Sliding

  def symbol
    '♝'.colorize(color)
  end

  def move_dirs
    diagonal_dirs
  end

end
