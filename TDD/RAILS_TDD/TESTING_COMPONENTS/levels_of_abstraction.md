# Lets refactor or feature spec!!

```ruby
# spec/features/user_marks_todo_complete_spec.rb
feature "User marks todo complete" do 
  scenario "updates todo as completed" do
    sign_in # straight forward 
    create_todo "Buy milk" # makes sense
     
    # huh? HTML list element ... text ... some kind of button?
    find(".todos li", text: "Buy milk").click_on "Mark complete"
    # hmm... styles ... looks like we want completed todos to look different?
    expect(page).to have_css(".todos li.completed", text: "Buy milk") 
  end
end
```

Wouldn't it be better to have this? Developers should be able to read our tests clearly.

```ruby
# spec/features/user_marks_todo_complete_spec.rb
feature "User marks todo complete" 
  do scenario "updates todo as completed" do
  # sign_in
  # create_todo
  # mark todo complete
  # assert todo is completed
  end 
end
```

We already did this exercise in our first todo app, please check it [here](https://github.com/daniel-enqz/rails_tdd/blob/master/spec/features/user_marks_todo_as_incomplete_spec.rb).
<br>
- Let's explain this clearly here!

We need to focus in high-level of abstarction. Communication and maintainability are the main goal here, code reusability is a side effect.

In the next example we will create methods like, create_todo, mark_complete, have_completed_todo, etc. And put them in our support folder.
```ruby
#spec/features/link.rb
feature "User marks todo complete" do 
  scenario "updates todo as completed" do
    sign_in
    create_todo "Buy milk"
    mark_complete "Buy milk"
    expect(page).to have_completed_todo "Buy milk" 
  end
end
```

```ruby
#spec/support/links.rb
def create_todo(name) 
  click_on "Add new todo" 
  fill_in "Name", with: name 
  click_on "Submit"
end

def mark_complete(name)
  find(".todos li", text: name).click_on "Mark complete"
end

def have_completed_todo(name) 
  have_css(".todos li.completed", text: name)
end



