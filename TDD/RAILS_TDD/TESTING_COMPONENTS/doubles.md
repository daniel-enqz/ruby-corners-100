### RSpec gives us doubles also known as mock objects, they act as fake collaborators in tests.
> They help us to isolate our current system under test (often abbreviated SUT). Our SUT is "score" now.

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
