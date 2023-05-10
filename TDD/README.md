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

