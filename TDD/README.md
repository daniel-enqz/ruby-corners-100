# TDD

> Test-Driven Development is a development technique where you write a failing test and then create code to make that test pass. 
--- 
> This process is sometimes called a red-green-refactor cycle with the failing tests being the "red" state, passing tests being the "green" state, and the refactoring step occurring after tests pass, where code can be confidently improved.
---

Simple example of TDD [here](https://github.com/daniel-enqz/ruby-corners-100/blob/master/TDD/lib/example-1.rb).

Benefits:
- Testing gives us a workflow
- Teting gives us an overview of our code
- Of course avoids faliures
- Enhances testing behaviour rather than implementation

Tests should be readble, here theres a battle with DRY code, sometimes in testing we will put in a pedestal "telling a good story".

### These are the 4 parts each test should have:

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

> Tests should help us with refactoring as the initial intend of our code will remian the same. We will avoid risky regressions! 💪

Dont's:
- Avoid over testing
- Avoid to much rspec syntax, use it if necessary. Tests should be meaningfull for our code and readers.
- Do not test private methods, as those will not be directly called by users
- Rather than try to solve all the failures at once, it's better to focus on a single test failure, and write the code that makes the spec pass. (Remember you can block tests from running with `xit`)

Exercises:
- [Cool exercise](https://github.com/daniel-enqz/ruby-corners-100/blob/master/TDD/lib/ex-1.rb) for testing a single Person class that rerturns the name of a person
- [More complex exercise](https://github.com/daniel-enqz/ruby-corners-100/blob/master/TDD/lib/ex-2.rb) for testing Conversions (Exception test here 👀)

# Integration vs. Unit Tests
## ⛰️Unit Tests:
> They will test a specific part of your code. Like a class or method.

- Remember to use doubles!!!
  - They help you isolate the code you're testing by replacing its dependencies with lightweight, controllable alternatives. 
  - Dependency injection is a technique used to provide an object with its dependencies, rather than having the object create or fetch them itself.
Here's a cool example of a double in a Unit Test from the UnitConvertor exercise.
```ruby
describe UnitConverter do 
  describe "#convert" do
    it "translates between objects of the same dimension" do
      cups = Quantity.new(amount: 2, unit: :cup)
      conversion_database = double(conversion_ratio: 0.236589)
      converter = UnitConverter.new(cups, :liter, conversion database)
      result = converter. convert
      expect (result.amount). to be_within (0.001).of (0.473176)
      expect (result.unit).to eq(:liter)
    end 
  end
end
```

👆 As you can see 👀, a double is created with the name conversion_database, and it's given a method called conversion_ratio that returns a fixed value of 0.236589. This double replaces the actual conversion_database object, allowing the test to control its behavior and return values. So we are not actually accessing database!!!

### So when to use doubles? 🤔
Doubles are more commonly used in unit tests rather than integration tests. The reason for this is that unit tests aim to isolate the specific piece of code being tested, so using doubles allows you to replace external dependencies, ensuring that the test focuses solely on the functionality of the code in question.

## 🏔️Integration(Feature - Testing from user perspective) Tests:
> They will test that a different parts of the application work together. They can also drive the writing of unit tests.

### As steps in your integration tests fail, that can point you toward the units that need to be built to build the feature. 
If you check the - [Conversion Exercise](https://github.com/daniel-enqz/ruby-corners-100/blob/master/TDD/lib/ex-2.rb). You will note we developed an integration test to confirm that the collaboration between UnitConverter and UnitDatabase. (Both of this containing UnitTests 👀)

In that exercise we also explain the process we did to create our Converter (Following TDD practices of course 👌)

Some important rules:
- Integration tests have a higher cost (developing, longest to run)
- They rely in multiple components (controllers, views, models etc.)
- It's often best to write tests that use actual collaborators and exercise them to ensure that the interfaces between components (the "glue" that holds them together) works as expected.
- It's important to ensure that your tests don't leave behind state that might break later tests (or test suite runs).
One way of ensuring that tests get cleaned up is to use an ensure statement to execute the test teardown step.

```ruby
begin
  result = converter.convert

  expect(result.amount).to be_within(0.001).of(1)
  expect(result.unit).to eq(:pint)
ensure
  File.delete(database_filename)
end
```

Another way of ensuring something is like this (Makes or code more DRY):

```ruby
around do |example|
  begin
    example.run
  ensure
    file.delete(database_filename)
  end
end
```
Check now [RAILS_TDD](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD) to see more of TDD in Rails env <br>
Check [this page](https://thoughtbot.com/upcase/videos/going-further-with-tdd) for more resources on testing.












