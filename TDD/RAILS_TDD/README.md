# TESTING IN RAILS 🧶

*Index*
- [Todo app exercise](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#Todo-app-exercise)
- [Testing in Rails by Josh Steiner](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#testing-in-rails-by-josh-steiner)

https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD

<br>

### Why testing?

- We test because we want something to behave the way it expects.
- Tests act as documentation, they tell us a story of our code.
- They should help us (give us confidence) to refactor and extend the code. They avoid regressions.

## TODO APP EXERCISE IN RAILS
Here's a finished exercise creating a todo test with integration and unit tests.
- [Todo Rails app with tests](https://github.com/daniel-enqz/rails_tdd)

As you can appreciate in the image, we cover features such as:
- Allowing users to sign_in
- User can visit home page and see his todos
- Users can create tasks
- Users will only see tasks they created
- Users can mark task as incomplete

![Screenshot 2023-05-12 at 11 50 55](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/74982873-7077-4070-8d8d-9cf08ee1aeb7)

It was a simple Rails app but usefull for practicing TDD, we also made use of support folder to keep our tests DRY:

![Screenshot 2023-05-12 at 11 54 53](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/8bfe255a-8fba-40f7-9269-ba892a687e56)

As you can see we are using some helper methos like sign_in, create_todo, display_todo and a databse cleaner configuration. They help us to avoid repeating code, making it more dynamic and avoid incidences.

![Screenshot 2023-05-12 at 11 53 47](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/73182961-00b4-4a6b-b860-3415aae1bd8c)
![Screenshot 2023-05-12 at 11 54 09](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/b7507134-06f0-437f-a1c7-8bd7be7d7fd5)
![Screenshot 2023-05-12 at 11 54 26](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/40b5f349-95b5-4a24-81b1-fcbc18cf555d)

Unit tests were also added for the todo model:

![Screenshot 2023-05-12 at 11 56 53](https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/2fc42f76-f346-43e2-acb5-40dd44bed04b)


### This was a good exercise to practice unit and integration(feature) tests, please feel free to check the [repo](https://github.com/daniel-enqz/rails_tdd).

---

## TESTING IN RAILS BY Josh Steiner

Yes, we have multiple ways of doing TDD in bigger applications:

"Tests should be reliable, complete, mantainable, expressive, isolated and fast

*Outside-In Development:* It's a method where development begins from the user's perspective, starting from the highest level of abstraction and working inwards, guided by user acceptance tests.

*Inside-Out Development:* This approach involves building software component by component, starting from the smallest pieces and gradually building up to the whole, enabling flexibility and adaptability during development.


When working wih rspec, which is a DSL which makes writing tests readable and understandable, we need to know specific files:
- `.rspec` Configures the default flags that are passed when you run rspec. 
- `spec/spec_helper.rb` Further customizes how RSpec behaves. Because this is loaded in every test, you can guarantee it will be run when you run a test in isolation.
-  `spec/rails_helper.rb` A specialized helper file that loads Rails and its dependencies. Like Capybara

*The testing pyramid:*

In our projects we will ned high level integration tests that check for general functionality of the app, several intermediate-level tests that cover a sub-system in more detail, and many unit tests to cover the nitty-gritty details of each component.

<img src="https://github.com/daniel-enqz/ruby-corners-100/assets/72522628/91cc3335-13ba-4735-8774-ddc8ce38eb69" alt="kublau" width="500" height="400">

## Defining the user:
- When doing a feature/integration test, we often need to specify the target user who will experience the feature, so our psuedocode will look something like:
```
As a user
When I visit the home page
And I click "Submit a link post"
And I fill in m....
[...]
And I click "Submit"
```
The important thing is to notice how we are sayig `As a user`, we could also specify we are an unauthenticated user, an admin, a coach or player.
> Remember that when wtriting a test we need to focus on [telling a story](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/README.md#these-are-the-4-parts-each-test-should-have) with out test.

```ruby
# spec/features/user_submits_a_link_spec.rb
  require "rails_helper"
  RSpec.feature "User submits a link" do
    scenario "they see the page for the submitted link" do
      link_title = "This Testing Rails book is awesome!" link_url = "http://testingrailsbook.com"
      visit root_path
      click_on "Submit a new link"
      fill_in "link_title", with: link_title fill_in "link_url", with: link_url click_on "Submit!"
      expect(page).to have_link link_title, href: link_url
    end 
   end
```

Things to note:
- Rspec.feature, `.feature` is a method that gives us access to capybara methods and test web functionalities.
- See how we are using Capybara methods such as `fill_in`, `click_on`, `submit`.
- `#expect` is an RSpec method that will build an assertion. It takes one value, which we will run an assertion against. 
- In this case, `#expect` it’s taking the page object, which is a value provided by Capybara that gives access to the currently loaded page. To run the assertion, you call `#to` on the return value of `#expect` and pass it a matcher.
- The matcher we’ve passed here is #have_link. #have_link comes from Capybara, and returns true if it finds a link with the given text on the page.
- For writing assertions, please refer to [rspec-expectations](https://github.com/rspec/rspec-expectations)
