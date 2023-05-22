### RSpec gives us doubles also known as mock objects, they act as fake collaborators in tests.

"Taking this approach yields several benefits. Because we aren’t using real collab- orators, we can TDD a unit of code even if the collaborators haven’t been written yet.
Using test doubles gets painful for components that are highly coupled to many collaborators"


> Doubles make it easy for us to isolate collaborators that are passed into the object we are testing (the system under test or SUT). 

```ruby
require "rails_helper"
RSpec.describe Score do describe "#upvotes" do
  it "is the upvotes on the link" do
    link = double(upvotes: 10, downvotes: 0)
    score = Score.new(link)
    expect(score.upvotes).to eq 10
  end
end
```

## Stubbing
> Look how we are creating a hard-coded class Link, adding a specific behaviour. This is allready tested in other part of the application. So we want to isolate everything else, and making our test fail soley by its definition and context.
```ruby
# spec/controllers/links_controller_spec.rb
require "rails_helper"
RSpec.describe LinksController, "#create" do 
  context "when the link is invalid" do
    it "re-renders the form" do
      invalid_link = double(save: false)
      allow(Link).to receive(:new).and_return(invalid_link)
      post :create, link: { attribute: "value" }
      expect(response).to render_template :new 
    end
  end 
end
```
