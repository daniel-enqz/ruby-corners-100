# TESTING IN RAILS 🧶

- In the next documentation we review some concepts about tasting in Rails.
- We 2 two exercises, a todo app and a reddit clone, and specify different aspects of testing.

*Index*
- [Todo app exercise](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#Todo-app-exercise)
- [Testing in Rails by Josh Steiner](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/README.md#testing-in-rails-by-josh-steiner)
- [Testing Components]()
- [Test Isolation]()

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

Please dive into the [next part](https://github.com/daniel-enqz/ruby-corners-100/tree/master/TDD/RAILS_TDD/testing_components.md) in which you will see a more detail scenario testing every part of a RAILS APP. 🦆
