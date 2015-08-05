require_relative 'Pieces'

class Board
  # builds bord
  #gets position list and checks which ones work.
  attr_accessor :grid

  def initialize
    @grid = Array.new(8){ Array.new(8)}
    populate_grid
    #give_piece_board
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end


  def populate_grid
    # add white pawns in row 1 and black pawns in row 6

    (0...8).each do |y_pos|
      self.grid[1][y_pos] = Pawn.new([1,y_pos])
      self.grid[6][y_pos] = Pawn.new([6,y_pos])
    end

    # white rooks go in [0,0], [0,7]
    self.grid[0][0], self.grid[0][7]  = Rook.new([0,0],self), Rook.new([0,7],self)
    self.grid[7][0], self.grid[7][7]  = Rook.new([7,0],self), Rook.new([7,7],self)

    # white knights go in [0,1], [0,6]
    self.grid[0][1], self.grid[0][6]  = Knight.new([0,1],self), Knight.new([0,6],self)
    self.grid[7][1], self.grid[7][6]  = Knight.new([7,1],self), Knight.new([7,6],self)

    # white bishops go in [0,2], [0,5]
    self.grid[0][2], self.grid[0][5]  = Bishop.new([0,2],self), Bishop.new([0,5],self)
    self.grid[7][2], self.grid[7][5]  = Bishop.new([7,2],self), Bishop.new([7,5],self)

    # Queen goes in [0,3]
    self.grid[0][3], self.grid[7][3]  = Queen.new([0,3],self), Queen.new([7,3],self)

    # King goes in [0,4]
    self.grid[0][4], self.grid[7][4]  = King.new([0,4],self), King.new([7,4],self)
    # for black its the same thing except x = 7

  end

  def play

    start_pos = gets.chomp
    end_pos = gets.chomp
    valid_move?(start_pos, end_pos)
  end

  def has_piece?(pos)
    !self[pos].nil?
  end

  def valid_move?(start_pos, end_pos)
    return false unless has_piece?(start_pos)
    #return false unless !same_color?(start_pos, end_pos)
    self[start_pos].valid_move?(end_pos)
  end



  # def valid_move?(start_pos, end_pos)
  #
  #   return false unless has_piece?(start_pos) #position has piece
  #   return false unless !same_color?(start_pos, end_pos)
  #
  #   #what kind of piece is this?
  #
  #   self[start_pos]
  #
  #   # where can it move (call move method on that piece)
  #   # is the end position located in any of the sub arrays in the move return array
  #       # furthermore, is anything in between the start and the end
  #
  #   # is that end point available for that piece?
  #
  #   position_list = self[start_pos].moves
  #   return false unless position_list.any? {|pos| pos == end_pos}
  #
  #   check_array = find_check_array(start_pos, end_pos) #build sub_array
  #   check_array[0..-2].each do |el|
  #     x, y = el
  #     return false if self[start_pos] != nil
  #   end
  #
  #   last_el = check_array[-1]
  #   future_pos = self[last_el]
  #   return false unless future_pos.nil? || !same_color?(start_pos, end_pos)
  #   true
  # end

  #



      #look through each sub_array[start]
    # is it
    #


  def find_check_array(start_pos, end_pos)
    x,y = start_pos
    sub_array = nil
    grid[x][y].moves.each_with_index do |move, grid_idx|
      sub_array = nil
      if move.include?([end_pos])
        # idx = grid[x][y].moves.index(end_pos)
        sub_array = grid[x][y].moves[grid_idx]
      end
    end
    sub_array
  end


  def in_check? #needs to know if the player is white or black
    # loop through grid and find where white king is
    # which black pieces have the position of the king in their next move
    # if they do, this is a check
    #
  end



end
