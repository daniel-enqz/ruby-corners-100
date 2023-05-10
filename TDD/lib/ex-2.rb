require "rspec/autorun"

DimensionalMismatchError = Class.new(StandardError)

Quantity = Struct.new(:amount, :unit)

class UnitConverter
  def initialize(initial_quantity, unit_to)
    @initial_quantity = initial_quantity
    @unit_to = unit_to
  end

  def convert
    begin
      conversion = @initial_quantity.amount * conversion_factor(from: @initial_quantity.unit, to: @unit_to).truncate(4)
      Quantity.new(conversion, @unit_to)
    rescue
      raise DimensionalMismatchError, "Can't convert from #{@initial_quantity} to #{@unit_to}"
    end
  end

  private

  CONVERSION_FACTORS = {
    cup: {
      liter: 0.236588
    }
  }

  def conversion_factor(from:, to:)
    CONVERSION_FACTORS[from][to]
  end
end

describe UnitConverter do
  describe "#convert" do
    it "translates between objects of the same dimension" do
      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :liter)

      result = converter.convert

      expect(result.amount).to be_within(0.0001).of(0.473)
      expect(result.unit).to eq(:liter)
    end

    it "raises an error if quantities are not of the same dimension" do
      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :gram)

      expect{converter.convert}.to raise_error(DimensionalMismatchError)
    end
  end
end

