require_relative 'piece'
require_relative 'board'

class SteppingPiece < Piece
  def initialize(pos, color = nil, board = nil)
    super
  end

  def moves
    moves = []
    original_piece = @board[*@pos]
    @offsets.each do |offset|
      current_pos = [@pos[0] + offset[0], @pos[1] + offset[1]]
      current_piece = @board[*current_pos]
      if in_bounds?(current_piece) && diff_color(current_piece, original_piece)
        moves << current_pos
      end
    end
    moves
  end
end

class Knight < SteppingPiece
  def initialize(pos, color = nil, board = nil)
    super
    @value = :k
    @offsets = [2, -1, 1, -1].permutation(2).to_a.reject{|x, y| x.abs == y.abs}
  end
end

class King < SteppingPiece
  def initialize(pos, color = nil, board = nil)
    super
    @value = :k
    @offsets = [0, 1, -1].repeated_permutation(2).to_a - [[0, 0]]
  end
end

if __FILE__==$PROGRAM_NAME
end
