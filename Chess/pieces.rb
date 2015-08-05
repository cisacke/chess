class Piece

  DIAGONAL_CHANGE = [
    [1,1],
    [-1,-1],
    [1,-1],
    [-1,1],
  ]

  SLIDING_CHANGE = [
    [1,0],
    [0,1],
    [-1,0],
    [0,-1]
  ]

  KNIGHT_CHANGE = [
    [2,1],
    [-2,1],
    [2,-1],
    [-2,-1],
    [1,2],
    [-1,2],
    [1,-2],
    [-1,-2]
  ]

  PAWN_CHANGE = [
      [1,0],
      [1,1],
      [1,-1],
  ]

  attr_accessor :color, :location, :board

  def initialize(location, board = nil) #[0,1]
    @location = location
    @color = color # == nil
    @board = board
    is_white?
  end

  def is_white?
    self.color = true if location[0].between?(0,1)
    self.color = false if location[0].between?(6,7)
  end

  def white?
    color
  end

  def black?
    !color
  end

  def same_color?(end_pos)
    return false if self[end_pos].nil?
    self.color == self[end_pos].color
  end

  def [](pos)
    row,col = pos
    board.grid[row][col]
  end



end

class SlidingPiece < Piece

  def moves
    x, y = location
    pos_list = []

    move_dir.each do |dx, dy|
      pos_paths = []
      while x.between?(0,7) && y.between?(0,7)
         pos_paths << [x, y]
         x, y = x + dx, y + dy
      end
     pos_list << pos_paths
     pos_paths = []
     x, y = location
    end
    pos_list.delete_if{ |array| array.length == 1}
  end

  def valid_move?(end_piece)
    # return false unless position_list.any? {|pos| pos == end_pos}
    #
    # check_array = find_check_array(start_pos, end_pos) #build sub_array
    # check_array[0..-2].each do |el|
    #   x, y = el
    #   return false if self[start_pos] != nil
    # end
    #
    # last_el = check_array[-1]
    # future_pos = self[last_el]
    # return false unless future_pos.nil? || !same_color?(start_pos, end_pos)
    # true
  end

end

class SteppingPiece < Piece

  def moves
    x, y = location
    pos_list = []

    move_dir.each do |dx, dy|
      if (x+dx).between?(0,7) && (y+dy).between?(0,7)
        pos_list << [ x + dx, y + dy ]
      end
    end
    pos_list
  end

  def valid_move?(end_pos)
    start_pos = self.location
    position_list = self.moves
    p "position list : #{position_list}"
    p "end_pos #{end_pos}"
    return false unless self.moves.any? {|move|  move != end_pos }
    return false unless same_color?(end_pos) || self[end_pos].nil?
    return true

  end

  def piece_taken?(end_pos)
    return !same_color?(end_pos) if valid_move?(end_pos)
    return false
  end


end

class Bishop < SlidingPiece

  def move_dir
    DIAGONAL_CHANGE
  end

end

class Queen < SlidingPiece

  def move_dir
    DIAGONAL_CHANGE + SLIDING_CHANGE
  end

end

class Rook < SlidingPiece

  def move_dir
    SLIDING_CHANGE
  end
end

class King < SteppingPiece

  def move_dir
    DIAGONAL_CHANGE + SLIDING_CHANGE
  end

end

class Knight < SteppingPiece

  def move_dir
    KNIGHT_CHANGE
  end
end

class Pawn < Piece

  def moves
    x, y = location
    pos_list = []
    PAWN_CHANGE.each do | pos |
      dx , dy = pos
      color? ? pos_list << [[x + dx, y + dy]] : pos_list << [[x - dx, y + dy]]
    end



    if x == 1 && color
      pos_list << [[x+1,y+0],[x+2,y+0]]
    elsif x == 6 && !color
      pos_list << [[x-1,y+0],[x-2,y+0]]
    end

    pos_list.delete_if do |array|
       array.flatten.any? { |element| element < 0 || element > 7 }
     end
  end


end
