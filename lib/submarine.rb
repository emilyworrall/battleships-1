class Submarine < Ship

DEFAULT_SIZE = 3

  def initialize size = DEFAULT_SIZE
    @size = size
    @coords = []
  end

end
