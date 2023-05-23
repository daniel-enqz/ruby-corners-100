# Testing Javascript

- By default, RSpec/Capybara run feature specs using Rack::Test which simulates a browser. Although it is fast, it cannot execute JavaScript.
- In order to execute JavaScript, we need a real browser. 
- Capybara allows using different drivers instead of the default of Rack::Test. Selenium is a wrapper around Firefox that gives us programmatic access. Its slow 🫥

### Capybara Webkit or Poltergeist.
> These are real browser engines but without the UI. By packaging the engine and not rendering the UI, these headless browsers can improve speed by a significant factor as well as avoid breaking every time you upgrade your browser.

# Simple Config:

```ruby
Capybara.javascript_driver = :webkit
```
Then, you want to add a :js tag to all scenarios that need to be run with JavaScript.
```ruby

feature "A user does something" do
  scenario "and sees a success message", :js do
    # test some things
  end 
end
```

## Important points:
1. Remember disabling transactions and use databse cleaner.
2. When you want to wait for an event to happen. Like opening a modal, avoid this:

```ruby
# This will return nl. as the modal is still not loaded.
first(".modal-open").click 
first(".confirm").click
```
Instead, use this:

```ruby
# this will take a few seconds to open modal
find(".modal-open").click
# this will keep trying to find up to two seconds
find(".confirm").click
```
