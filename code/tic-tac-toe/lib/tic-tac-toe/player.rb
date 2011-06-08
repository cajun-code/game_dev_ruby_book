module TicTacToe
  class Player
    attr_accessor :name,  :marker
    attr_reader :board
    def initialize(name ="", board = nil, marker = "" )
      @name = name
      @board = board
      @marker = marker
    end
    
    def take_turn(cell)
      @board.place_marker(cell, @marker)
      @board.check_winner
    end
  end  
end
