module TicTacToe
  class Player
    attr_accessor :name,  :marker
    attr_reader :board
    def initialize(name ="", board = nil, marker = "" )
      @name = name
      @board = board
      @marker = marker
    end
  end
end
