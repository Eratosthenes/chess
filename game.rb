require_relative "nil_class"
require_relative "board"
require_relative "player"
require_relative "piece"
require_relative "sliding_piece"
require_relative "stepping_piece"
require_relative "pawn"

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    @player1 = Player.new(@board, :white)
    @player2 = Player.new(@board, :black)
    @current_player = @player1
    # @player_colors = [:white, :black]
  end

  def switch_players!
    # @player_colors.rotate![0]
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end

  end

  def run
    begin
      loop do
        # start_pos = @player.move
        # end_pos = @player.move
        @board.move_piece(@current_player.move, @current_player.move, @current_player.color)

        switch_players!
        # puts "#{@current_player.color.to_s.capitalize}'s turn"
        if @board.checkmate?(@current_player.color)
          break
        end
        if @board.in_check?(@current_player.color)
          @board.error_message = "CHECK!"
        end

      end
      puts "CHECKMATE. #{@current_player.color.upcase} LOSES."
    rescue ArgumentError => e
      puts e
      retry
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  # game = Game.new
  # p game.board[7, 1].moves
  Game.new.run
end
