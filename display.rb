require 'colorize'
require_relative 'board'
require_relative "cursorable"

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
  end

  def display_grid
  
    system("clear")

    grid = @board.grid
    grid.each.with_index do |row, i|
      row.each.with_index do |col, j|
        tile = grid[i][j]
        print " #{tile.to_s.colorize(tile.color)} ".colorize(colors_for(i, j))
      end
      puts
    end

    message
  end

  def message
    puts @board.error_message
    @board.error_message = nil
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).even?
      bg = :green
    else
      bg = :blue
    end
    { background: bg}
  end
end

if __FILE__==$PROGRAM_NAME
  b = Board.new
  d = Display.new(b)
  d.display_loop

end
