require_relative 'board'

class Piece
  attr_reader :color
  attr_accessor :value, :pos, :board

  def initialize(pos, color = nil, board = nil)
    @board = board
    @pos = pos
    @value = color.nil? ? ' ' : :p
    @color = color
  end

  def to_s
    @value.to_s
  end

  def in_bounds?(current_pos)
    current_pos[0].between?(0, 7) && current_pos[1].between?(0, 7)
  end

  def same_color?(current_piece, other_piece)
    current_piece.color == other_piece.color
  end

  def diff_color?(current_piece, other_piece)
    current_piece.color != other_piece.color
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  rook = Rook.new([0,0], :black, b)
  p rook.offsets
end
