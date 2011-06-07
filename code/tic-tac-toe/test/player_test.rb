require "test/unit"
require "tic-tac-toe/board"
require "tic-tac-toe/player"

class PlayerTest < Test::Unit::TestCase
  def setup
    @board = TicTacToe::Board.new
  end
  def test_player_create
    player = TicTacToe::Player.new "Allan", @board, "X"
    assert_not_nil player
  end
end
