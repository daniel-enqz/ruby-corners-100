# 1. We started by adding the UnitTests for the converter method, the TDD process guided us to create the class, constructor, converter method.
# 2. We created a test that expected the converted method to correctly do the conversion in different dimensions.
# 3. We then refactor our method to be more readable.
# 4. We then decided to enhance our code and make it possible of managing same dimension conversion.



require "rspec/autorun"
require "pry"

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
      raise DimensionalMismatchError, "Can't convert from #{@initial_quantity.unit} to #{@unit_to}!"
    end
  end

  private

  CONVERSION_FACTORS = {
    liter: {
      cup: 4.226775,
      liter: 1,
      pint: 2.11338
    },
    gram: {
      gram: 1,
    }
  }

  def conversion_factor(from:, to:)
    dimension = CONVERSION_FACTORS.keys.find do |key|
      CONVERSION_FACTORS[key].keys.include?(from) && CONVERSION_FACTORS[key].keys.include?(to)
    end
    CONVERSION_FACTORS[dimension][to] / CONVERSION_FACTORS[dimension][from]
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

    it "can convert between quantities of the same dimension" do
      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :cup)

      result = converter.convert

      expect(result.amount).to be_within(0.001).of(2)
      expect(result.unit).to eq(:cup)

    end

    it "raises an error if quantities are not of the same dimension" do
      cups = Quantity.new(2, :cup)
      converter = UnitConverter.new(cups, :gram)

      expect{converter.convert}.to raise_error(DimensionalMismatchError)
    end
  end
end

