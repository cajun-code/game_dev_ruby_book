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
    
    attr_reader :grid, :last_move
    def initialize()
      @grid = []      
    end
    #def size
    #  @grid.size
    #end
    def place_marker(index, marker)
      if index < 0 or index > GRID_SIZE 
        raise BoardError.new, "#{index} is outside the board"
      end
      if @grid[index].nil?
        @grid[index] = marker
        @last_move = index
      else
        raise BoardError.new, "#{index} is already used"
      end
    end
    
    def clear
      @grid.clear
      @last_move = nil
      @winner = nil
    end
    def winner
      @winner
    end
    def check_winner
      result = false
      Board::WINNING_PATTERNS.each do |pattern|
        a = @grid[pattern[0]]
        b = @grid[pattern[1]]
        c = @grid[pattern[2]]
        if a.nil? and b.nil? and c.nil?
          next
        end
        if a == b and a == c
          result = true
          @winner = a
          break
        end        
      end
      result
    end
  end
end