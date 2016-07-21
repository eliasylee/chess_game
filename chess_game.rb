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
    puts "*" * 50
    puts "Congratulations! #{winner.name} won the game in #{turn_count/2} moves!"
    puts "*" * 50
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
      unless start_pos.nil? || @board[start_pos].color == @current_player.color
        @display.selected = nil
        raise InvalidMoveError
      end

      @display.render
    end

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
  puts "*" * 50
  puts "Welcome to Chess!"
  puts "*" * 50

  print "Player-1 enter your name > "
  player_one_name = gets.chomp
  print "\n"

  print "Player-2 enter your name > "
  player_two_name = gets.chomp
  print "\n"

  chess = ChessGame.new(HumanPlayer.new(player_one_name, :white), HumanPlayer.new(player_two_name, :black))
  chess.play
end
