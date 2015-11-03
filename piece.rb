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

end

class SteppingPiece < Piece

end

class SlidingPiece < Piece
  def initialize
    @offsets = [0, 1, -1].repeated_permutation(2).to_a - [0, 0]
  end

  def get_moves(directions)
    moves = []
    directions.each do |direction|
      current_pos = @pos

      @board[*current_pos].is_a?(Piece)
    end
    moves
  end

end

class Rook < SlidingPiece

  def get_directions
    @offsets.reject{|x, y| x.abs == y.abs}
  end
end

class Knight < SteppingPiece
end
