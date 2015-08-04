require_relative 'Pieces'

class Board
  # builds bord
  #gets position list and checks which ones work.
  attr_accessor :grid

  def initialize
    @grid = Array.new(8){ Array.new(8)}
    populate_grid
  end

  def populate_grid
    # add white pawns in row 1 and black pawns in row 6

    (0...8).each do |y_pos|
      self.grid[1][y_pos] = Pawn.new([1,y_pos])
      self.grid[7][y_pos] = Pawn.new([7,y_pos])
    end

    # white rooks go in [0,0], [0,7]
    self.grid[0][0], self.grid[0][7]  = Rook.new([0,0]), Rook.new([0,7])
    self.grid[7][0], self.grid[7][7]  = Rook.new([7,0]), Rook.new([7,7])

    # white knights go in [0,1], [0,6]
    self.grid[0][1], self.grid[0][6]  = Knight.new([0,1]), Knight.new([0,6])
    self.grid[7][1], self.grid[7][6]  = Knight.new([7,1]), Knight.new([7,6])

    # white bishops go in [0,2], [0,5]
    self.grid[0][2], self.grid[0][5]  = Bishop.new([0,2]), Bishop.new([0,5])
    self.grid[7][2], self.grid[7][5]  = Bishop.new([7,2]), Bishop.new([7,5])

    # Queen goes in [0,3]
    self.grid[0][3], self.grid[7][3]  = Queen.new([0,3]), Queen.new([7,3])

    # King goes in [0,4]
    self.grid[0][4], self.grid[7][4]  = King.new([0,4]), King.new([7,4])
    # for black its the same thing except x = 7

  end

  def valid_move?
    #
  end




end
