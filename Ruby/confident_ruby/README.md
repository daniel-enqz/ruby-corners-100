# Writing clean code in ruby

> Ruby is designed to make programmers happy.
> - Yukhiro "Matz" Matsumoto

--- 
The next insights are insipred by the book:
Confindent Ruby by Avdi Grimm. 
---

> A single method is like a page in that story. And unfortunately, a lot of methods are just as convoluted, equivocal, and confusing.

> Method construction and object design are not two independent disciplines. They are more like a dance, where each partner's movements influence the other's. The system's object design is reflected down into methods, and method construction in turn can be reflected up to the larger design.

_"I believe that if we take a look at any given line of code in a method, we can nearly always categorize it as serving one of the following roles:"_

1. Collecting input
2. Performing work
3. Delivering output
4. Handling failures

For intsance, lets take a look at the next example which actually looks everwhelming, its not ordered.....🤔
<img src="https://user-images.githubusercontent.com/72522628/236586862-eb9a587f-8b8b-4608-94de-1b99442b3fa2.jpg" alt="kublau" width="600" height="300">


## So how can we create readable code and tell a story with our methods?

# 1. Performing the work:
> Let's start by defining "Performing the work", which is basically the core of every method.

**We need 3 essential steps to achieve this**:
1. Identifying the messages we want to send (in language as close to that of the problem domain as possible); then...
2. Determining the roles which make sense to receive those messages; and finally...
3. Bridging the gap between the roles we've identified and the objects which actually exist in the system.

I added an example in [this file](https://github.com/daniel-enqz/ruby-corners-100/blob/master/Ruby/confident_ruby/lib/identifying-messages.md), please check it to undertsand this step better 👌

# 2. Collecting input:
> Now that we know how the core system of our methods can be structured, lets take a look at the actual first step of our list.

Collecting input isn't just about finding needed inputs—it's about determining how lenient to be in accepting many types of input, and about whether to adapt the method's logic to suit the received collaborator types, or vice-versa.

[What about explicit and implicit methos? 🤔](https://github.com/daniel-enqz/ruby-corners-100/blob/master/Ruby/confident_ruby/lib/built-in-methods.md)

> Methods may be dominated by handling for edge cases. This is hardly confident code.

### The goal is mapping the roles we need with the objects we have in our system.
I added more info in [this file](https://github.com/daniel-enqz/ruby-corners-100/tree/master/Ruby/confident_ruby/lib/inputs.md), please check it to undertsand this step better 👌

## Whow can we do a better input collection?

I choose the top 10 approaches that were more intresting for me from the book and put them [here](https://github.com/daniel-enqz/ruby-corners-100/blob/master/Ruby/confident_ruby/lib/collecting-input.md), clear descriptions and code examples can also be found there 🪴

# 3. Delivering Output
> _"We should also ensure that our outputs make it easy for the clients of our code to be written in a confident style as well."_

1.- Writing total functions:
Methods that may or may not return an array put an extra burden on callers to check the type of the result. Ensuring that an array is always returned no matter what enables callers to handle the result in a consistent, confident fashion.

```ruby
def method
 [...]
 Array(result)
end
```
2.- Call back instead of returning.
> A callback on success is more meaningful than a true or false return value.

The next is great example because its like reading plain english: "If the files are nor imported, send book invitation (run the block given `&impoort_callback`)".
```ruby
def import_purchase(date, title, user_email, &import_callback) 
  user = User.find_by_email(user_email)
  unless user.purchased_titles.include?(title)
    purchase = user.purchases.create(title: title, purchased_at: date)
   import_callback.call(user, purchase) 
 end
end

import_purchases(purchase_data) do |user, purchase| 
 send_book_invitation_email(user.email, purchase.title)
end
```
3.- Returning bengin values
nil is the worst possible representation of a failure: it carries no meaning but can still break things, a workable but semantically blank object—such as an empty string—may be the most appropriate result. 

4.- Represent failure with a special case object
We show a clear example in ["Collecting Input"](https://github.com/daniel-enqz/ruby-corners-100/blob/master/Ruby/confident_ruby/lib/collecting-input.md) point 7

5.- Returning special case objects for readiness.
> Command-query separation (CQS). CQS is a simplifying principle of OO design which advises us to write methods which either have side effects (commands), or return values (queries), but never both.
The next is a good example because its clear we are usuing the status object we created, and readiness as well as more customization is enhanced.

```ruby
def import_purchase(date, title, user_email) user = User.find_by_email(user_email)
 if user.purchased_titles.include?(title)
  ImportStatus.redundant 
 else
   purchase = user.purchases.create(title: title, purchased_at: date)
  ImportStatus.success 
 end
 rescue => error 
  ImportStatus.failed(error)
end
```
```ruby
result = import_purchase(date, title, user_email) 
if result.success?
 send_book_invitation_email(user_email, title) 
elsif result.redundant?
 logger.info "Skipped #{title} for #{user_email}" 
else
 logger.error "Error importing #{title} for #{user_email}: #{result.error}"
end
```
6.- consider using throw and catch

# 4. Handling failure

Do we have alternatives to: begin/rescue/end (BRE) block. ??? 🤔

1.- Prefer top-level rescue clause
```ruby
def bar
 # happy path goes up here
rescue #--------------------------- 
 # failure scenarios go down here
end
```

2.- Use a check popen method that handles errors. Why?

begin/rescue/end blocks obstruct the narrative flow of a method. They distract from the primary intent of the code and instead put the focus on edge cases. A checked method encapsulates the error case, and centralizes the code needed to handle that case if it ever crops up in another method. It is a stepping stone to a fully-fledged adapter class for external code.

```ruby
def checked_popen(command, mode, error_policy=->{raise}) 
 IO.popen(command, mode) do |process|
  return yield(process) 
 end
 rescue Errno::EPIPE 
  error_policy.call
end
```

3.- Enter a Bouncer Method.

```ruby
# This is our Bouncer method
def check_child_exit_status 
 unless $?.success?
  raise ArgumentError,
  "Command exited with status "\ "#{$?.exitstatus}"
 end 
end
```
As you can see with a minimum of disruption to the method flow, we are usuing the check_child_exit_status to raise an exception un case of error

```ruby
def filter_through_pipe(command, message)
 result = checked_popen(command, "w+", ->{message}) do |process|
        process.write(message)
        process.close_write
        process.read
 end
 check_child_exit_status
 result
end
```


![Screenshot 2023-05-08 at 10 28 39](https://user-images.githubusercontent.com/72522628/236878369-e1254a6c-1048-4195-910d-08e53deff3d1.jpg)
