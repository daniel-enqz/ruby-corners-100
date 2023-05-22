### RSpec gives us doubles also known as mock objects, they act as fake collaborators in tests.
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
