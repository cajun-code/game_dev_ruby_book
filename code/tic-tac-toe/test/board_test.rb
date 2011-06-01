require 'test/unit'
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
require "tic-tac-toe/board"


class BoardTest < Test::Unit::TestCase
  def test_board_create
    board = TicTacToe::Board.new  
    assert_not_nil board
    assert_equal board.size, 9 
  end
  
  def test_place_marker
    board = TicTacToe::Board.new
    board.place_marker(4, "X")
    assert_equal board.grid[4], "X"
    assert_raise( TicTacToe::BoardError) {board.place_marker(9,"O")}
    assert_raise( TicTacToe::BoardError) {board.place_marker(4, "X")}
  end
  
  def test_clear_board
    board = TicTacToe::Board.new
    board.place_marker(4, "X")
    assert_equal board.grid[4], "X"
    board.clear
    assert_nil board.grid[4]
  end
  
  def test_check_board
    board = TicTacToe::Board.new
    board.place_marker(4, "X")
    board.place_marker(5, "X")
    board.place_marker(3, "X")
    board.check_winner
    assert_equals board.winner, "X" 
  end
  
end 