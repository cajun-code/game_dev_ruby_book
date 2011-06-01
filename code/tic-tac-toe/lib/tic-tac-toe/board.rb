module TicTacToe
  
  class BoardError < Exception
  end
  
  class Board
    GRID_SIZE = 8
    WINNING_PATTERNS = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [2,4,6],
      [0,4,8],
    ]
    attr_reader :grid
    def initialize()
      @grid = []
      (0..GRID_SIZE ).each {|x| @grid[x] = nil } 
    end
    def size
      @grid.size
    end
    def place_marker(index, marker)
      if index < 0 or index > GRID_SIZE 
        raise BoardError.new, "#{index} is outside the board"
      end
      if @grid[index].nil?
        @grid[index] = marker
      else
        raise BoardError.new, "#{index} is already used"
      end
    end
    
    def clear
      @grid.clear
    end
  end
end