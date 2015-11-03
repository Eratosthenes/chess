class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    # @pieces = pieces
    populate_board
  end

  def move_piece(start_pos, end_pos)
    if self[*start_pos].color.nil?
      raise ArgumentError, "Cannot move an empty position"
    elsif self[*end_pos].color == self[*start_pos].color
      raise ArgumentError, "Cannot take your own piece"
    end

    piece = self[*start_pos]
    nil_piece = self[*end_pos]
    piece.pos = end_pos
    nil_piece.pos = start_pos

    self[*end_pos] = piece
    self[*start_pos] = nil_piece
    # self[*start_pos].pos = end_pos
    # self[*end_pos].pos = start_pos
    # self[*start_pos], self[*end_pos] = self[*end_pos], self[*start_pos]

    # self[*end_pos] = piece
    # piece.pos = end_pos
    # # p self[*start_pos].pos
    # self[*start_pos] = nil
  end

  def populate_board
    @grid.each.with_index do |row, r_idx|
      row.each.with_index do |col, c_idx|
        if [0, 1].include?(r_idx)
          @grid[r_idx][c_idx] = Piece.new([r_idx, c_idx], :black)
        elsif [6, 7].include?(r_idx)
          @grid[r_idx][c_idx] = Piece.new([r_idx, c_idx], :white)
        else
          @grid[r_idx][c_idx] = Piece.new([r_idx, c_idx])
        end
      end
    end

    @grid.each do |row|
      row.each do |el|
        el.board = self if el.is_a?(Piece)
      end
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
