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

  # def switch_position(start_pos, end_pos)
  #   self[*start_pos].pos = end_pos
  #   if self[*end_pos].color.nil? # we are moving piece to empty tile
  #     self[*end_pos].pos = start_pos
  #     temp = self[*start_pos]
  #     self[*start_pos] = self[*end_pos]
  #     self[*end_pos] = temp
  #   else # we are capturing
  #     self[*end_pos] = self[*start_pos]
  #     self[*start_pos] = Piece.new(start_pos)
  #   end
  # end

  def populate_board
    @grid.each.with_index do |row, i|
      row.each.with_index do |col, j|
        if [0].include?(i)
          if j == 0 || j == 7
            self[i, j] = Rook.new([i, j], :black, self)
          else
            @grid[i][j] = Piece.new([i, j], :black, self)
          end
        elsif [6, 7].include?(i)
          @grid[i][j] = Piece.new([i, j], :white, self)
        end
      end
    end

    # @grid.each do |row|
    #   row.each do |el|
    #     el.board = self if el.is_a?(Piece)
    #   end
    # end
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
