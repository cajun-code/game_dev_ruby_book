require "test/unit"
require "tic-tac-toe/board"
require "tic-tac-toe/player"

class PlayerTest < Test::Unit::TestCase
  def setup
    @board = TicTacToe::Board.new
    @player = TicTacToe::Player.new "Allan", @board, "X"
  end
  def test_player_create
    @board.clear
    assert_not_nil @player
  end
  def test_take_turn
    @board.clear
    @player.take_turn(4)
    assert_equal 4, @board.last_move
    @board.clear
    @player.take_turn(3)
    @player.take_turn(4)
    @player.take_turn(5)
    assert_equal @board.winner, @player.marker
  end
end
