class Ship

  DEFAULT_SIZE = 1

  attr_reader :location, :size, :size_range, :direction, :coords

  def initialize size = DEFAULT_SIZE
    @size_range = [1, 2, 3, 4, 5]
    fail "Size outside of range!" unless size_range.include?(size)
    @size = size
    @coords = []
  end

  def locate location
    @location = location
  end

  def direct direction
    @direction = direction
  end

  def reset
    if @coords.any?
      @coords.clear
    else
    end
  end

  def coordinates
    if @coords == []
      @size.times do |i|
        case @direction[0].upcase
        when 'N'
          @coords << [ @location[0], (@location[1] - i) ]
        when 'E'
          @coords << [ (@location[0] + i), @location[1] ]
        when 'S'
          @coords << [ @location[0], (@location[1] + i) ]
        when 'W'
          @coords << [ (@location[0] - i), @location[1] ]
        end
      end
    end
    @coords
  end

  def on_board(board_size)
    x_max = (board_size[0])-1
    y_max = (board_size[1])-1
    @coords.each do |a|
      fail 'Ship not on the board' if a[0]<0 || a[0]>x_max
      fail 'Ship not on the board' if a[1]<0 || a[1]>y_max
    end
  end

  def hit?(hit_coords)
    if @coords.include?(hit_coords)
      @coords.map!{ |x| x == hit_coords ? "Hit" : x }
      true
    else
      false
    end
  end

  def sunk?
    @coords - ["Hit"] == [] ? true : false
  end

end
