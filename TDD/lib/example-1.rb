```ruby
require "rspec/autorun"

class Calculator
  def add(a, b)
    a + b
  end

  def factorial(n)
    if n == 0
      1
    else
      (1..n).reduce(:*)
    end
  end
end

calc = Calculator.new
calc.add(5, 10) # => 15
```

```ruby
describe Calculator do
  describe "#add" do
    it "returns the sum of its two arguments" do
      calc = Calculator.new
      expect(calc.add(5, 10)).to eq(15)
    end

    it "returns the sum of two different arguments" do
      calc = Calculator.new
      expect(calc.add(1, 2)).to eq(3)
    end
  end

  describe "#factorial" do
    it "returns 1 when given 0" do
      clac = Calculator.new
      expect(calc.factorial(0)).to eq(1)
    end

    it "returns 120 when given 5" do
      calc = Calculator.new
      expect(calc.factorial(5)).to eq(120)
    end
  end
end
```
