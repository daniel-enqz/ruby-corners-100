# TESTING IN RAILS 🧶

- In the next documentation we review some concepts about tasting in Rails.
- We 2 two exercises, a todo app and a reddit clone, and specify different aspects of testing.

*Index*
- [Todo app exercise](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#Todo-app-exercise)
- [Testing in Rails by Josh Steiner](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#testing-in-rails-by-josh-steiner)
- [Integration Tests](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#integration-tests)
- [Testing Models](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#testing-models-(#spec/models/))
- [Testing Validations](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#testing-validations)
- [Testing Associations](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#testing-associations)
- [Testing Requests](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#testing-requests)
- [Testing Views](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#testing-views)
- [Testing Controllers](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#testing-controllers)
- [Testing Mailers](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#testing-mailers)


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

## Example doing a Reddit Clone app ([Check it out here!!!]())

- We will explain the tests we did in this project, but please refer to [the project]() to see full implementation.

## Integration Tests:
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
> Remember that when wtriting a test we need to focus on [telling a story with 4 Phase Test Patter](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/README.md#these-are-the-4-parts-each-test-should-have) with out test.

```ruby
test do 
 setup

 exercise 

 verify 

 teardown
end
```

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

We can continue doing TDD in our links app by adding cluases for invalid links, where of course we will not need to do all the simulation of a user creating a link again, we could just use factory girl to create our link. We allready know thats testes somewhere else:
> TIP: In factory bot remember to use only required data, to avoid having objects with unecessary extra data when testing.

```ruby
# spec/factories.rb
FactoryBot.define do 
 factory :link do
  title "Testing Rails"
  url "http://testingrailsbook.com" 
  end
end

# In your test
link = create(:link)

# Or override the title
link = create(:link, title: "TDD isn't Dead!")
```
```
MORE ABOUT FACTOIRES
# build creates an Article object without saving
build :article, :unpublished

# build_stubbed creates an Article object and acts as an already saved Article
build_stubbed :article, :published

# create creates an Article object and saves it to the database
create :article, :published, :in_the_future
create :article, :published, :in_the_past

# create_list creates a collection of objects for a given factory
# you can also use build_list and build_stubbed_list
create_list :article, 2
```

As we did with pur first TODO APP practice example, we need to load files under the support folder.
In your rails_helper you’ll find some commented out code that requires all of the files in  spec/support. Let’s comment that in so our FactoryBot config gets loaded:

`Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }`

## Important aspects about `have_css`:
> We also did this example in our Todo app, you can check at the begining of this documentation. I only want to highlight the data attribute: `[data-role=score]`.
- We’ll frequently use data-roles to decouple our test logic from our presentation logic. 
- This way, we can change class names and tags without breaking our tests!

```ruby
# spec/features/user_upvotes_a_link_spec.rb
RSpec.feature "User upvotes a link" do 
 scenario "they see an increased score" do
  link = create(:link)
  visit root_path
  within "#link_#{link.id}" do 
   click_on "Upvote"
  end
  expect(page).to have_css "#link_#{link.id} [data-role=score]", text: "1" 
 end
end
```
## Testing Models (#spec/models/)
> We prefix instance methods with a `#` and class methods with a `.`.
- Instance methods (Upvoting a link and caluclating score)

Note: If we needed a persisted object (for example, if we needed to query for it), we would use .create. .build skips the save.
How to order model specs:
- validation tests
- Class method tests
- Instance Mtehod tests

```ruby
# spec/models/link_spec.rb
RSpec.describe Link, "#upvote" do 
 it "increments upvotes" do
  link = build(:link, upvotes: 1)
  link.upvote
  expect(link.upvotes).to eq 2 
 end
end
```

```ruby
# spec/models/link_spec.rb
RSpec.describe Link, "#score" do
 it "returns the upvotes minus the downvotes" do
  link = Link.new(upvotes: 2, downvotes: 1)
  expect(link.score).to eq 1 
 end
end
```
- Class methods:

```ruby
RSpec.describe Link, ".hottest_first" do
 it "returns the links: hottest to coldest" do
  coldest_link = create(:link, upvotes: 3, downvotes: 3) 
  hottest_link = create(:link, upvotes: 5, downvotes: 1) 
  lukewarm_link = create(:link, upvotes: 2, downvotes: 1)
  expect(Link.hottest_first).to eq [hottest_link, lukewarm_link, coldest_link] 
 end
end
```

## Testing validations:
- We use a library called shoulda-matchers to test validations. 
- shoulda-matchers pro- vides matchers for writing single line tests for common Rails functionality.
- Provided by RSpec, is_exepcted is a convenience syntax for expect(subject) 

```ruby
RSpec.describe Link, "validations" do
 it { expect(Link.new).to validate_presence_of(:title) } 
 it { expect(subject).to validate_presence_of(:url) }
 it { is_expected.to validate_uniqueness_of(:url) } # This is the best way to go.
end
```

## Testing associations:
Associations will be tested at an integration level. So no worth tasting them.

## Testing Requests:
- Request specs are integration tests that allow you to send a request and make assertions on its response.
- Request specs should be used to test API design

1. Testing endpoint of all existing links:

First some configuration, as all of our request will be JSON.
```ruby
# spec/support/api_helpers.rb
module ApiHelpers 
  def json_body
   JSON.parse(response.body) 
  end
end

RSpec.configure do |config|
 config.include ApiHelpers, type: :request
end
```

```ruby
# spec/requests/api/v1/links_spec.rb
require "rails_helper"

RSpec.describe "GET /api/v1/links" do
 it "returns a list of all links, hottest first" do
  coldest_link = create(:link) 
  hottest_link = create(:link, upvotes: 2)
  
  get "/api/v1/links" 
  
  expect(json_body["links"].count).to eq(2)
  hottest_link_json = json_body["links"][0] 
  expect(hottest_link_json).to eq({
   "id" => hottest_link.id, "title" => hottest_link.title,
   "url" => hottest_link.url,
   "upvotes" => hottest_link.upvotes, 
   "downvotes" => hottest_link.downvotes,
  })
 end 
end
```

2. Testing creating a link (POST)

We first add some traits to our factory so that we can create invalid links with: `attributes_for(:link, :invalid)`
```ruby
factory :link do
 title "Testing Rails"
 url "http://testingrailsbook.com"
 
 trait :invalid do 
  title nil
 end 
end
```

```ruby
# spec/requests/api/v1/links_spec.rb
RSpec.describe "POST /api/v1/links" do 
 it "creates the link" do
  link_params = attributes_for(:link) # This is a FactoryBot method that returns a hash like: { title: "Testing Rails", url: "http://testingrailsbook.com" }

  post "/api/v1/links", link: link_params

  expect(response.status).to eq 201
  expect(Link.last.title).to eq link_params[:title] 
 end
 
 context "when there are invalid attributes" do 
  it "returns a 422, with errors" do
   link_params = attributes_for(:link, :invalid) post "/api/v1/links", link: link_params
   expect(response.status).to eq 422
   expect(json_body.fetch("errors")).not_to be_empty 
  end
 end 
end
```

## Testing views:
- Testing that a view renderes an image
```ruby
# spec/views/links/_link.html.erb_spec.rb
require "rails_helper"

RSpec.describe "links/_link.html.erb" do 
 context "if the url is an image" do
   it "renders the image inline" do
    link = build(:link, url: "http://example.com/image.jpg")
    render partial: "links/link.html.erb", locals: { link: link }
    expect(rendered).to have_selector "img[src='#{link.url}']" 
   end
 end 
end


# spec/views/links/show.html.erb_spec.rb
require "rails_helper"

RSpec.describe "links/show.html.erb" do 
 context "if the url is an image" do 
  it "renders the image inline" do
   link = build(:link, url: "http://example.com/image.jpg") 
   assign(:link, link) # assigns the value of the variable link to the instance variable @link in our rendered view.
   
   render # magically infers the vire to render from the describe
   
   expect(rendered).to have_selector "img[src='#{link.url}']" 
  end
 end 
end
```

## Testing controllers:
> They aren’t really unit tests because controllers are so tightly coupled to other parts of the Rails infrastructure.
- Feature specs do cover controllers, controller tests can often be redundant.
- You don’t need a controller test until you introduce conditional logic to your controller.
- Use feature specs for happy paths and controller tests for the sad paths.

> The “happy path” is where everything succeeds (e.g. successfully navigating the app and submitting a link) while the “sad path” is where a failure occurs (e.g. suc- cessfully navigating the app but submitting an invalid link).

We are going to test the `if save` logic from the controller, testing the sad path of the record not saving and re-rendering the view
```ruby
# spec/controllers/links_controller_spec.rb
 require "rails_helper"
 
 RSpec.describe LinksController, "#create" do 
  context "when the link is invalid" do
   it "re-renders the form" do
    post :create, link: attributes_for(:link, :invalid)
    expect(response).to render_template :new 
   end
  end 
end
```

### Question that arise.....
> Is it worth trading a slow and partially duplicated feature spec for a faster controller test that doesn’t test the UI? Would a request spec be a good compromise? What about a controller spec plus a view spec to test the both sides independently?

## Testing helpers
> Formatting is not a model-level concern. Instead, we are going to implement it as a helper method.

- Since we don’t need to persist to the database and don’t care about validity, we are using Link.new here instead of FactoryGirl. We need to nake our tests FAST ⚡️
```ruby
# spec/helpers/application_helper_spec.rb
require "rails_helper"
RSpec.describe ApplicationHelper, "#formatted_score_for" do 
 it "displays the net score along with the raw votes" do
   link = Link.new(upvotes: 7, downvotes: 2) 
   formatted_score = helper.formatted_score_for(link)
   
   expect(formatted_score).to eq "5 (+7, -2)" 
 end
end
```

## Testing mailers:
- Mailers are a great example for Outside-in testing. Starting from integration to Unit layer.
- We start by testing the controller (integration)

```ruby
# spec/controllers/links_controller_spec.rb
context "when the link is valid" do
 it "sends an email to the moderators" do
  valid_link = double(save: true)
  allow(Link).to receive(:new).and_return(valid_link) 
  allow(LinkMailer).to receive(:new_link)
  
  post :create, link: { attribute: "value" }
  
  expect(LinkMailer).to have_received(:new_link).with(valid_link) 
 end
end
```

- This now forces us to write a new class and method `LinkMailer#new_link.` with  `email-spec gem`
 - Provides a number of helpful matchers for testing mailers, such as:
- deliver_to
- deliver_from
- have_subject
- have_body_text

```ruby
# spec/mailers/link_mailer_spec.rb
require "rails_helper"
RSpec.describe LinkMailer, "#new_link" do
 it "delivers a new link notification email" do
  link = build(:link)
  email = LinkMailer.new_link(link)
  
  expect(email).to deliver_to(LinkMailer::MODERATOR_EMAILS) 
  expect(email).to deliver_from("noreply@reddat.com") 
  expect(email).to have_subject("New link submitted") 
  expect(email).to have_body_text("A new link has been posted")
 end 
end
```




