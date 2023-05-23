# Antipatterns

## Slow tests
> As applications grow, we will need to be testing more and more stuff. Development can get slow.

### Tricks to find slow tests:
1. Running (--profile 4) will output the 4 slowest tests. You can add this flag to your .rspec file to output with every run. <br>
2. Some tests dont require Rails. Therefore require only "spec_helper" rather than "rails_helper".
3. Only persist if necessary. Persisting to the database takes far longer than initializing objects in memory.
4. Use happy paths for feture specs, do not over complicate adding sad paths. Find a balance in feature specs.
5. Stub external APIS, do not hit them directly. (You can configure to test the API driectly on CI only)
6. Delete slow tests that are not cirtical-mission.


## Interminent Failures:
- How to find the test thats causing the problem?
![Screenshot 2023-05-23 at 11 03 09](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/f489a859-b3b4-40eb-bb78-0f4be8b1e83d)

1. Remember to use database to mantain clean states in each test
2. Reset Global states:

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
