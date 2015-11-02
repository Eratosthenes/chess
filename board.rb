class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8){Array.new(8)}
    # @pieces = pieces
    populate_board
  end

  def move(start_pos, end_pos)
    if self[*start_pos] == nil
      raise ArgumentError.new "Cannot move an empty position"
    elsif self[*end_pos].color == self[*start_pos].color
      raise ArgumentError.new "Cannot take your own piece"
    end
    # p self[*start_pos].pos
    piece = self[*start_pos]
    self[*end_pos] = piece
    piece.pos = end_pos
    p self[*start_pos].pos
    self[*start_pos] = nil
  end

  def display
    @grid.each do |row|
      p row
    end
  end

  def populate_board
    @grid.each.with_index do |row, r_idx|
      row.each.with_index do |col, c_idx|
        @grid[r_idx][c_idx] = Piece.new([r_idx, c_idx], :black) if [0,1].include?(r_idx)
        @grid[r_idx][c_idx] = Piece.new([r_idx, c_idx], :white) if [6,7].include?(r_idx)
      end
    end
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

end

class Piece
  attr_reader :color
  attr_accessor :value, :pos

  def initialize(pos, color)
    @pos = pos
    @value = :p
    @color = color
  end
end

class SteppingPiece < Piece
end

class SlidingPiece < Piece
end

class Knight < SteppingPiece
end

if __FILE__==$PROGRAM_NAME
  b = Board.new
  p b.grid
  b.move([0,0],[0, 1])
  b.display


end
