require_relative 'stepable'

class King < Piece

  include Stepable

  def symbol
    "\u265A".encode('utf-8').colorize(color)
    # '♚'.colorize(color)
  end

  def move_diffs
    [[1,0], [0,1], [0,-1],[-1,0],[1,1],[1,-1], [-1,-1],[-1,1]]
  end

end
