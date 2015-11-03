#has color, value, pos, board attributes
#has to_s, in_bounds?, same_color?, diff_color? methods
class Pawn < Piece

  def initialize(pos, color = nil, board = nil)
    super
    @starting_row = pos[0]
    generate_offsets(color)
  end

  def generate_offsets(color)
    mult = (color == :white) ? -1 : 1
    @start_offset = [2*mult, 0]
    @attack_offset = [[mult,-1], [mult, 1]]
    @move_offset = [mult, 0]
  end

  def moves
    moves = []
    move_one_pos = [@pos[0] + @move_offset[0], @pos[1] + @move_offset[1]]
    if in_bounds?(move_one_pos)
      if @board[*move_one_pos].nil?
        moves << move_one_pos
        move_two_pos = [@pos[0] + @start_offset[0], @pos[1] + @start_offset[1]]
        if @starting_row == pos[0] && @board[*move_two_pos].nil?
          moves << move_two_pos
        end
      end
    end
    @attack_offset.each do |offset|
      diagonal_pos = [@pos[0] + offset[0], @pos[1] + offset[1]]
      if in_bounds?(diagonal_pos) && opp_color?(@board[*@pos], @board[*diagonal_pos])
        moves << diagonal_pos
      end
    end
    moves
  end

end
