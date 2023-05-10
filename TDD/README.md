# TDD

> Test-Driven Development is a development technique where you write a failing test and then create code to make that test pass. 
--- 
> This process is sometimes called a red-green-refactor cycle with the failing tests being the "red" state, passing tests being the "green" state, and the refactoring step occurring after tests pass, where code can be confidently improved.
---

TDD is a process, we wrote the failing test "add", make it pass and then refactor.

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
Benefits:
- Testing gives us a workflow
- Teting gives us an overview of our code
- Of course avoids faliures

Tests should be readble, here theres a battle with DRY code, sometimes in testing we will put in a pedestal "telling a good story".

This are the 4 parts each test should have:

1. Setup - get the conditions correct for the test
2. Exercise - perform the thing that you're testing
3. Verification - verify that the exercise did what you expected
4. Teardown - undo any conditions that shouldn't persist post-test

Example: 

```ruby
describe "#promote_to_admin" do
  it "makes a regular membership an admin membership" do
    # setup
    membership = Membership.new(admin: false)

    # exercise
    membership.promote_to_admin

    # verify
    expect(membership).to be_admin
  end
end
```

