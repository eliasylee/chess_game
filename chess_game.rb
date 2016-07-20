require_relative 'display'
require_relative 'human_player'
require_relative 'computer_player'

class ChessGame

  def initialize(player_one, player_two)
    @board = Board.new
    @board.populate_board
    @display = Display.new(@board)
    @player_one = player_one
    @player_two = player_two
    @current_player = player_one
  end

  def play
    turn_count = 0
    until @board.checkmate?(@current_player.color)
      @display.render
      play_turn
      turn_count += 1
    end
    winner = @current_player.color == :black ? @player_one : @player_two
    @display.render
    puts "Congratulations! #{winner.name} won the game in #{turn_count} rounds!"
  end

  def play_turn
    @current_player.make_move

    begin
      move
    rescue InvalidMoveError => e
      puts "#{e}"
      retry
    end

    swap_player
  end

  def move
    start_pos = nil
    end_pos = nil

    until start_pos
      start_pos = @display.get_input
      @display.render
    end

    # debugger
    # raise InvalidMoveError unless @board[start_pos].color == @current_player.color

    until end_pos
      end_pos = @display.get_input
      @display.render
    end

    @board.move_piece(start_pos, end_pos)
  end

  def swap_player
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

end


if __FILE__ == $PROGRAM_NAME
  puts "Welcome to Chess!"
  # num_players = nil
  #
  # until num_players == 1 || num_players == 2
  #   puts "1-player or 2-player game?"
  #   num_players = gets.chomp.to_i
  # end
  #
  # puts "Player-1 enter your name."
  # player_one_name = gets.chomp
  #
  # if num_players == 2
  #   puts "Player-2 enter your name."
  #   player_two_name = gets.chomp
  # end

  # player_two = num_players == 1 ? ComputerPlayer.new("Deep Blue", :black) :
  #   HumanPlayer.new(player_two_name, :black)
  chess = ChessGame.new(HumanPlayer.new("Anthony", :white), HumanPlayer.new("Elias", :black))
  chess.play
end
