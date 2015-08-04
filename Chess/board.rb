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

  def valid_move?(start_pos, end_pos)
    # look at

    # what piece is at that position?
    # where can it move (call move method on that piece)
    # is the end position located in any of the sub arrays in the move return array
        # furthermore, is anything in between the start and the end

    # is that end point available for that piece?
    x,y = start_pos
    if grid[x][y].moves.flatten.include?(end_pos)
      check_array = find_check_array(start_pos, end_pos) #build sub_array
      check_array[0..-2].each do |el|
        x, y = el
        return false if grid[x][y] != nil
      end
      last_el = check_array[-1]
      return false if grid[last_el[0]][last_el[1]].color? 
      #look through each sub_array[start]
    # is it
    #
  end

  def find_check_array(start_pos, end_pos)
    grid[x][y].moves.each do |move|
      if move.include?(end_pos)
        idx = grid[x][y].index(end_pos)
        return grid[x][y].moves[0..idx]
      end
    end
  end


  def in_check? #needs to know if the player is white or black
    # loop through grid and find where white king is
    # which black pieces have the position of the king in their next move
    # if they do, this is a check
    #
  end



end
