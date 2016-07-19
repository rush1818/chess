require_relative 'stepable'

class Knight < Piece

  include Stepable

  def symbol
    "\u265E".encode('utf-8').colorize(color)
  end

  def move_diffs
    [[1,2], [2,1], [-2,-1],[-2,1],[1,-2],[-1,-2],[-1,2],[2,-1]]
  end

end
