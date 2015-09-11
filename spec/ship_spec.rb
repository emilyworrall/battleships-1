require_relative "../lib/ship.rb"

describe Ship do
  let(:location) { double(:location) }
  let(:direction) { double(:direction) }
  # let(:test_ship){ double(:test_ship, location: ["A",1],
  #                                     direction: "South",
  #                                     size: 2)}

  context "Placing a ship" do

  it "responds to location" do
    expect(subject).to respond_to :location
  end

  it "responds to locate" do
    expect(subject).to respond_to(:locate).with(1).argument
  end


  it "is located at the assigned location" do
    subject.locate location
    expect(subject.location).to eq location
  end

  it "responds to direct" do
    expect(subject).to respond_to(:direct).with(1).argument
  end

  it "is pointing at the assigned direction" do
    subject.direct direction
    expect(subject.direction).to eq direction
  end

  it "coordinates reset if cannot be placed" do
    subject.reset
    expect(subject.coords).to be_empty
  end
end
  describe '#new' do

    it 'accepts size as a parameter' do
      expect{ Ship.new(double :size) }.to_not raise_error if subject.size_range.include?(double :size)
    end

    it 'raises an error if size is not in the range given' do
      expect{ Ship.new(double :size) }.to raise_error "Size outside of range!" unless subject.size_range.include?(double :size)
    end

  end

  it 'provides coordinates based on its location, direction and size' do
    ship = Ship.new(2)
    ship.locate [1,1]
    ship.direct "South"
    expect(ship.coordinates).to eq [[1,1], [1,2]]
  end

  it 'raises an error if the ship coordinates are off the board' do
    ship = Ship.new(2)
    ship.locate [1,0]
    ship.direct "North"
    ship.coordinates
    expect{ ship.on_board([10,10]) }.to raise_error "Ship not on the board"
  end

  describe "#hit?" do

    it "reports true if hit" do
      ship = Ship.new(2)
      ship.locate [1,0]
      ship.direct "North"
      ship.coordinates
      expect(ship.hit?([1,0])).to eq true
    end

    it "reports false if miss" do
      ship = Ship.new(2)
      ship.locate [1,0]
      ship.direct "North"
      ship.coordinates
      expect(ship.hit?([1,10])).to eq false
    end

    it "replaces the coordinate which got hit with Hit" do
      ship = Ship.new(3)
      ship.locate [1,1]
      ship.direct "South"
      ship.coordinates
      ship.hit?([1,1])
      expect(ship.coords).to eq ["Hit",[1,2],[1,3]]
    end

  end

  describe "#sunk?" do

    it "reports a true if sunk" do
      ship = Ship.new(1)
      ship.locate [1,1]
      ship.direct "South"
      ship.coordinates
      ship.hit?([1,1])
      expect(ship.sunk?).to eq true
    end

    it "reports a false if not sunk" do
      ship = Ship.new(1)
      ship.locate [1,1]
      ship.direct "South"
      ship.coordinates
      ship.hit?([1,10])
      expect(ship.sunk?).to eq false
    end

  end
end
