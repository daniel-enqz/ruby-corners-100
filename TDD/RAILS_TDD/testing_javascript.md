# Testing Javascript

- By default, RSpec/Capybara run feature specs using Rack::Test which simulates a browser. Although it is fast, it cannot execute JavaScript.
- In order to execute JavaScript, we need a real browser. 
- Capybara allows using different drivers instead of the default of Rack::Test. Selenium is a wrapper around Firefox that gives us programmatic access. Its slow 🫥

### Capybara Webkit or Poltergeist.
> These are real browser engines but without the UI. By packaging the engine and not rendering the UI, these headless browsers can improve speed by a significant factor as well as avoid breaking every time you upgrade your browser.
