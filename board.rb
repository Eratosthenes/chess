class Board
  attr_accessor :grid, :error_message
  def initialize(populate = true)
    @grid = Array.new(8) { Array.new(8) }
    # @pieces = pieces
    populate_board if populate
  end

  def in_check?(color)
    flattened_grid = @grid.flatten.reject{|x| x.nil?}
    king_piece = flattened_grid.select{|piece| piece.color == color && piece.value == :K}[0]
    flattened_grid.each do |piece|
      if king_piece != piece
        return true if piece.moves.include?(king_piece.pos)
      end
    end
    false
  end

  def move_piece(start_pos, end_pos, player_color)
    piece = self[*start_pos]

    if piece.nil?
      @error_message = "Cannot move an empty position"
      raise ArgumentError
    elsif self[*end_pos].color == piece.color
      @error_message = "Cannot take your own piece"
      raise ArgumentError
    elsif piece.color != player_color
      @error_message = "Cannot move your opponent's pieces"
      raise ArgumentError
    elsif piece.moves.include?(end_pos) == false
      @error_message = "Invalid move"
      raise ArgumentError
    end
    self[*end_pos] = piece
    self[*start_pos] = nil
    piece.pos = end_pos


  end

  def populate_board
    @grid.each.with_index do |row, i|
      row.each.with_index do |col, j|
        case
        when i == 0
          populate_rows_first_and_last(i,j, :black)
        when i == 1
          @grid[i][j] = Pawn.new([i, j], :black, self)
        when i == 6
          @grid[i][j] = Pawn.new([i, j], :white, self)
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
