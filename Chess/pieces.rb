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

  attr_accessor :color, :location

  def initialize(location) #[0,1]
    @location = location
    @color = color # == nil
    is_white?
  end

  def is_white?
    self.color = true if location[0].between?(0,1)
    self.color = false if location[0].between?(6,7)
  end

  def color?
    @color
  end

end

class SlidingPiece < Piece

  def initialize(position)
    super(position)
  end

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
