class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    # @pieces = pieces
    populate_board
  end

  def move_piece(start_pos, end_pos)
    piece = self[*start_pos]
    if piece.nil?
      raise ArgumentError, "Cannot move an empty position"
    elsif self[*end_pos].color == piece.color
      raise ArgumentError, "Cannot take your own piece"
    elsif piece.moves.include?(end_pos) == false
      raise ArgumentError, "Can't move there"
    end
    self[*end_pos] = piece
    self[*start_pos] = nil
    piece.pos = end_pos
    # switch_position(start_pos, end_pos)
  end

  def populate_board
    @grid.each.with_index do |row, i|
      row.each.with_index do |col, j|
        case
        when i == 0
          populate_rows_first_and_last(i,j, :black)
        when i == 1

        when i == 6

        when i == 7
          populate_rows_first_and_last(i, j, :white)
        end
      end
    end

  end

  def populate_rows_first_and_last(i, j, color)
    case
    when j == 0 || j == 7
      @grid[i][j] = Rook.new([i, j], color, self)
    when j == 1 || j == 6
      @grid[i][j] = Knight.new([i, j], color, self)
    when j == 2 || j == 5
      @grid[i][j] = Bishop.new([i, j], color, self)
    when j == 3
      @grid[i][j] = Queen.new([i, j], color, self)
    when j == 4
      @grid[i][j] = King.new([i, j], color, self)
    end
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

end

if __FILE__==$PROGRAM_NAME
  b = Board.new
  p b.grid
  b.move_piece([0,0],[0, 1])
  b.display
end
