require_relative 'ship'
require_relative 'submarine'

class Board
  DEFAULT_BOARD_SIZE = [5,5]

  attr_accessor :ships, :hits, :misses

  def initialize(board_size = DEFAULT_BOARD_SIZE)
    @ships = []
    @board_size = board_size
    @hits = []
    @misses = []
  end

  #make ships

  def place ship, location, direction
    ship.locate location
    ship.direct direction
    ship.coordinates
    ship.on_board(@board_size)
     true



    @ships.each do |s|
        fail 'Ships overlap' if self.overlap?(ship, s)
    end
    @ships << ship
  end

  def overlap? s1, s2
    s1.coords.each do |a|
        s2.coords.each do |b|
          if b==a
            return true
          else
            return false
          end
        end
    end
  end

  def receive_fire(hit_coords)
    @ships.each do |ship|
      if ship.hit?(hit_coords) == true
        @hits << hit_coords
        if self.lost? == true
          return "you have won!"
        else
          if ship.sunk? == true
            return "hit and a ship is sunk!"
          else
            return "hit!"
          end
        end
      end
    end
    @misses << hit_coords
    return "miss"
  end

  def lost?
    @ships.each do |ship|
      if ship.sunk? == false
        return false
      end
    end
    true
  end


end
