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
## 👆Unit Tests:
> They will test a specific part of your code. Like a class or method.

## 👆Integration Tests:
> They will test that a different parts of the application work together. They can also drive the writing of unit tests.

### As steps in your integration tests fail, that can point you toward the units that need to be built to build the feature. 
