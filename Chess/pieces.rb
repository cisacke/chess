class Pieces

  attr_accessor :color

  def initialize(location) #[0,1]
    @location = location
    @white = false
    determine_color
  end

  def determine_color
    color = true if location[0].between?(0,1)
    color = false if location[0].between?(6,7)
  end

  def moves
    piece_type
    case
    when 'Q'

    when 'K'

    when 'N'

    # if
    #returns an array of valid positions
  end

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

  def sliding
    #can do this multiple times on the board as long as you your positin exists
  end

  def stepping
    #can only do it once
  end
end

class SlidingPieces < Pieces

  def initialize(position,color)
    super(position,color)
  end
end

class SteppingPieces < Pieces
end

class Biship < SlidingPieces

  def initialize(position,color)
    super(position,color)
  end

end

class Queen < SlidingPieces
end

class Rook < SlidingPieces
end

class King < SteppingPieces
end

class Knight < SteppingPieces
end


Biship.new([0,2])
# knight = Piece("knight", [0,1])
