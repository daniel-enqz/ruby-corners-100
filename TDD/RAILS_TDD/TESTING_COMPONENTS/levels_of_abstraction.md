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

# Extraction
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
```

# Why not creating page objects?

Do you see what we are doing here?
```ruby
scenario "create a new todo" do 
  sign_in_as "person@example.com" 
  todo = todo_on_page
  todo.create expect(todo).to be_visible
end
```

```ruby
scenario "mark completed todo as incomplete" do 
  sign_in_as "person@example.com"
  todo = todo_on_page
  todo.create 
  todo.mark_complete 
  todo.mark_incomplete
  expect(todo).not_to be_complete
end
```

> Instead of having unique methods, we are creating a whole TodoOnPage object.

```ruby
class TodoOnPage
  include Capybara::DSL
  attr_reader :title
  
  def initialize(title) 
    @title = title
  end
  
  def create
    click_link "Create a new todo" fill_in "Title", with: title click_button "Create"
  end
  
  def mark_complete
    todo_element.click_link "Complete"
  end
  
  def mark_incomplete 
    todo_element.click_link "Incomplete"
  end
  
  def visible?
    todo_list.has_css? "li", text: title
  end
  
  def complete?
    todo_list.has_css? "li.complete", text: title
  end
  
  private
  
  def todo_element
    find "li", text: title
  end
  
  def todo_list 
    find "ol.todos"
  end 
end
```
