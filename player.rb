require_relative "display"

class Player
  attr_reader :color

  def initialize(board, color)
    @display = Display.new(board)
    @color = color
  end

  def move
    result = nil
    until result
      @display.display_grid
      result = @display.get_input
    end
    result
  end
end
