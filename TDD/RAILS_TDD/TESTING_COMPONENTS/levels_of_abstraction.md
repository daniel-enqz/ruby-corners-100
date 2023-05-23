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
