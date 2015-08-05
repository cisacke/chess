require_relative 'Pieces'

class Board
  # builds bord
  #gets position list and checks which ones work.
  attr_accessor :grid

  def initialize(grid = Array.new(8){ Array.new(8)})
    @grid = grid
    #give_piece_board
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos,value)
    x, y = pos
    @grid[x][y] = value
  end



  def populate_grid
    # add white pawns in row 1 and black pawns in row 6

    (0...8).each do |y_pos|
      self.grid[1][y_pos] = Pawn.new([1,y_pos], self, "P")
      self.grid[6][y_pos] = Pawn.new([6,y_pos], self, "P")
    end

    # white rooks go in [0,0], [0,7]
    self.grid[0][0], self.grid[0][7]  = Rook.new([0,0],self, "R"), Rook.new([0,7],self, "R")
    self.grid[7][0], self.grid[7][7]  = Rook.new([7,0],self, "R"), Rook.new([7,7],self, "R")

    # white knights go in [0,1], [0,6]
    self.grid[0][1], self.grid[0][6]  = Knight.new([0,1],self, "N"), Knight.new([0,6],self, "N")
    self.grid[7][1], self.grid[7][6]  = Knight.new([7,1],self, "N"), Knight.new([7,6],self, "N")

    # white bishops go in [0,2], [0,5]
    self.grid[0][2], self.grid[0][5]  = Bishop.new([0,2],self, "B"), Bishop.new([0,5],self, "B")
    self.grid[7][2], self.grid[7][5]  = Bishop.new([7,2],self, "B"), Bishop.new([7,5],self, "B")

    # Queen goes in [0,3]
    self.grid[0][3], self.grid[7][3]  = Queen.new([0,3],self, "Q"), Queen.new([7,3],self, "Q")

    # King goes in [0,4]
    self.grid[0][4], self.grid[7][4]  = King.new([0,4],self, "K"), King.new([7,4],self, "K")
    # for black its the same thing except x = 7

  end

  def display
    grid.each do |row|
      puts row.join(" ") # implicitely calls the to_s
    end
    nil
  end

  def play

    populate_grid # during setup
# white moves first

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

  def move_into_check?(start_pos, end_pos, color)
    self[start_pos] #position of the piece we are moving

    dup_grid = grid.deep_dup_board
    dup_board = Board.new(dup_grid)
    dup_board.move(start_pos, end_pos)

    dup_board.in_check?(color)

  end

  def in_check?(color)
    king_pos = locate_king(color)
    # locate the king of argument color
    boolean_color = piece_color(color)
    (0..7).each do |col|
      (0..7).each do |row|
        chess_piece = self[[col,row]]
        next if chess_piece.nil?
        if chess_piece.color != boolean_color
          return true if chess_piece.valid_move?(king_pos)
        end
      end
    end
    return false
  end

  def move(start_pos, end_pos)
    if valid_move?(start_pos, end_pos)
       self[end_pos] = self[start_pos]
       self[start_pos] = nil
       self[end_pos].location = end_pos
    end
  end

  def locate_king(color)
    boolean_color = piece_color(color)
    (0..7).each do |row|
      (0..7).each do |col|
        return [row, col] if self[[row, col]].is_a?(King) && self[[row, col]].color == boolean_color
      end
    end
  end

  def piece_color(color_sym)
    color_sym == :white ? true : false
  end



    # def move_into_check?(startend_pos)
    #   dup_grid = board.grid.deep_dup_board
    #   dup_board = Board.new(dup_grid)
    #   dup_board.display
    #   p self.location
    #   p self[end_pos]
    #
    #   dup_board.move(self.location, self[end_pos])
    #   dup_board.display
    # end
end

class Array

  def deep_dup_board
    return nil if self.length == 0
    return nil if self.nil?
    return self if !self.is_a?(Array)

    self.map do |element|
       if !element.nil?
          element.is_a?(Array) ? element.deep_dup_board : element.dup
        else
        nil
        end
     end
  end

end
