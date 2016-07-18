require_relative 'display'

class Board

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def is_nil?(pos)
    self[pos].nil?
  end

  def move(start_pos, end_pos)
    if is_nil?(start_pos) == nil
      raise ArgumentError.new "No piece to begin with"
    end

    

  end
end
