require 'singleton'

class NullPiece
  include Singleton

  def moves

  end

  def color
    { :background => :blue }
  end

  def to_s
    " ".colorize(:background => :blue)
  end

  def empty?
    true
  end

end
