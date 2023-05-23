# Antipatterns

It's important to focus on testing the desired behavior rather than specific implementation details, minimize dependencies, use abstraction layers, and employ techniques like test doubles and mocking. Writing tests that are resilient to code changes and environment variations helps maintain a reliable and efficient test suite.

_* By testing just the inputs and outputs, we can freely change the implementation of the method without having to change our test case.*_

## Slow tests
> As applications grow, we will need to be testing more and more stuff. Development can get slow.

### Tricks to find slow tests:
1. Running (--profile 4) will output the 4 slowest tests. You can add this flag to your .rspec file to output with every run. <br>
2. Some tests dont require Rails. Therefore require only "spec_helper" rather than "rails_helper".
3. Only persist if necessary. Persisting to the database takes far longer than initializing objects in memory.
4. Use happy paths for feture specs, do not over complicate adding sad paths. Find a balance in feature specs.
5. Stub external APIS, do not hit them directly. (You can configure to test the API driectly on CI only)
6. Delete slow tests that are not cirtical-mission.

## Important learning about private methods:
- When dealing with private methods, its important to know that they will be indirectly tested by their public methods. 
> If you feel that the logic in your private methods is necessary to test independently, that may be a hint that the functionality can be encapsulated in its own class. At that point, you can extract a new class to test. This has the added benefit of improved reusability and readability.


## Interminent Failures:
- How to find the test thats causing the problem?
![Screenshot 2023-05-23 at 11 03 09](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/f489a859-b3b4-40eb-bb78-0f4be8b1e83d)

1. Remember to use database to mantain clean states in each test
2. Opt for explicit method calls to build and stub necessary objects and dependencies within the test itself. (Avoid let, before, subject)
3. Extract helper methods.
4. For feature specs, you may consider using Page Objects to clean up repetitive interactions.
5. Use raits in factories.
6. Use data-roles to assert presence.
7. Trust in  internationalization (i18n), you will only have to change something there, instead of specs and views.
8. Sometimes it will be necessary to test implementaion in service objects. So stubbing the job and assert it was qued.
9. Rely on mocking and stubbing. Brittle code comes from coupling. The more coupled your code, the harder it is to make changes without having to update multiple locations in your code. 
10. When usuing factories, remember to use only what our Model requires.
11. Avoid stubing our SUT, consider moving some behaviour/dependencies into its own class and stub that.
12. Reset Global states:

```ruby
module EnvHelper
  def with_env(variable, value)
    old_value = ENV[variable] ENV[variable] = value yield
  ensure
    ENV[variable] = old_value 
  end
 end
   
RSpec.configure do |config| 
  config.include EnvHelper
end
```
Then in the spec:
```ruby
feature "User views the form setup page", :js do
  scenario "after creating a submission, they see the continue button" do
    with_env("POLLING_INTERVAL", "1") do
```

