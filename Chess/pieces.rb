class Pieces

  def initialize(name, location)
    @name = name
    @location = location
  end

  def moves
    piece_type
    case
    when 'Q'
      sliding + diagonal
    when 'K'
      stepping
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

end



# knight = Piece("knight", [0,1])
