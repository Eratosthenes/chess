require_relative 'board'
require_relative 'sliding_piece'

class Piece
  attr_reader :color
  attr_accessor :value, :pos, :board

  def initialize(pos, color = nil, board = nil)
    @board = board
    @pos = pos
    @value = color.nil? ? ' ' : :p
    @color = color
  end

  def valid_moves
    moves.reject{|position| move_into_check?(position)}
  end

  def move_into_check?(end_pos)
    #duplicate board and perform the move
    dup_board = @board.dup
    dup_board.move_piece(@pos, end_pos, @color)
    dup_board.in_check?(@color)
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

  def opp_color?(current_piece, other_piece)
    diff_color?(current_piece, other_piece) && !other_piece.nil?
  end

end

if __FILE__ == $PROGRAM_NAME
  b = Board.new(false)
  rook = Rook.new([0,0], :black, b)
  p rook.valid_moves
end
