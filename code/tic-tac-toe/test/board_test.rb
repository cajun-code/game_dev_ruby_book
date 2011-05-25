require 'test/unit'
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
require "tic-tac-toe/board"


class BoardTest < Test::Unit::TestCase
  def test_board_create
    board = TicTacToe::Board.new  
    assert_not_nil board
    assert_equal board.size, 9 
  end
end 