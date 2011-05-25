module TicTacToe
  class Board
    GRID_SIZE = 8
    attr_reader :grid
    def initialize()
      @grid = []
      (0..GRID_SIZE ).each {|x| @grid[x] = nil } 
    end
    def size
      @grid.size
    end
  end
end