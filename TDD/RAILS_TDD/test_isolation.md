### RSpec gives us doubles also known as mock objects, they act as fake collaborators in tests.

"Taking this approach yields several benefits. Because we aren’t using real collab- orators, we can TDD a unit of code even if the collaborators haven’t been written yet.
Using test doubles gets painful for components that are highly coupled to many collaborators"


> Doubles make it easy for us to isolate collaborators that are passed into the object we are testing (the system under test or SUT). 

## Mocking
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

# Mocking vs Stubbing
Stubbing is similar to mocking but focuses on controlling the return values of methods or simulating certain behaviors of objects. It allows you to replace the implementation of a method with a predefined response. Mocking involves creating a fake object that mimics the behavior of a real object or component. 


# Avoiding Dangers ‼️

- Imagine we create a double that doesnt or will never exist in our program.

*RSpec let's us verify doubles (created with the method instance_double)*. 

1. When that class is not loaded, it acts like a regular double
2. If the class is loaded, it will raise an error if you try to call methods on the double that are not defined for instances of the class.

```ruby
require "rails_helper"
RSpec.describe Score do describe "#upvotes" do
  it "is the upvotes on the link" do
    link = instance_double(Link, upvotes: 10, downvotes: 0) 
    score = Score.new(link)
    expect(score.upvotes).to eq
  end
end
```

---

- There are many patterns for testing external services. Please check this [page 65](https://drive.google.com/file/d/1RyZpE5lvZSxXN6lIEoWrCBQgFr0G7I1i/view), to address this part.


