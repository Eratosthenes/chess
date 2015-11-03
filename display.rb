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
        # if tile.is_a?(Piece)
        #    tile = tile.to_s.colorize(tile.color)
        #    print " #{tile} ".colorize(colors_for(i, j))
        # else
        #    print '   '.colorize(colors_for(i, j))
        # end
      end
      puts
    end

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


  #
  # def display_loop
  #   while true
  #     system("clear")
  #     display_grid
  #     @board.get_input
  #   end
  # end

end


# class Display
#   def initialize(board)
#     @board = board
#
#   end
#
#   def build_grid
#     @board.rows.map.with_index do |row, i|
#       build_row(row, i)
#     end
#   end
#
#   def build_row(row, i)
#     row.map.with_index do |piece, j|
#       color_options = colors_for(i, j)
#       piece.to_s.colorize(color_options)
#     end
#   end
#
#   def render
#     system("clear")
#     puts "Fill the grid!"
#     puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
#     build_grid.each { |row| puts row.join }
#   end
#
# end


if __FILE__==$PROGRAM_NAME
  b = Board.new
  d = Display.new(b)
  d.display_loop

end
