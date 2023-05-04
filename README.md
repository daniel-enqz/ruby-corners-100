# Failure as a breach of contract

This repo is a set of excercises to practice exceptions, failures and error handling.
Took inspiration from: [Exceptional Ruby by Avdi Grimn](https://drive.google.com/drive/folders/1pji-ot0DVqdIlnkz6SdCAVk0-EYsGAXU)

---

A method’s contract states “given the following inputs, I promise to return certain outputs and/or cause certain side-effects”. 

---

# WHEN TO USE EXCEPTIONS
> Use exceptions only for exceptional situations. [. . . ] Exceptions are often overused. 
> Because they distort the flow of control, they can lead to convoluted constructions that are prone to bugs. 
> It is hardly exceptional to fail to open a file; generating an exception in this case strikes us as over-engineering.

- Jared Carroll wrote a great blog post14 about this point back in 2007, in which he puts it this way:
> When writing an application you expect invalid input from users.
> Since we expect invalid input we should NOT be handling it via exceptions because exceptions should only be used for unexpected situations.

1.- Consider using `throw`or `catch`. <br>
2.- Sometimes, the caller should be the one to handle the exception rather than the callee. 👇👇👇

A similar example is the #detect method on Enumerable. Since the block
was already taken, #detect uses a parameter for its caller-specified fallback
handler.

```ruby 
arr.detect(lambda{"None found"}) {|x| ... }
```
3.- Ask yourself if the failure really justifies terminating the program.

For example, this...
```ruby 
@ug = UserGreeting.find_by_name!("winter_holidays")
```

...could become this:

```ruby 
@ug = UserGreeting.find_by_name("winter_holidays")
unless @ug
logger.error "Someone forgot to run db:populate!"
@ug = OpenStruct.new(:welcome
```
### Another cool example:

```ruby
def render_user(user)
  if user.fname && user.lname
    "#{user.lname}, #{user.fname}"
  else
    yield
  end
end

# Fall back to a benign placeholder value:
render_user(u){ "UNNAMED USER" }

# Fall back to an exception:
render_user(u){ raise "User missing a name" }
```

### Remember to use Ruby implicit begin blocks...
In this case, the “better way” is to use Ruby’s implicit begin blocks. Every
method in Ruby is implicitly a begin block. We can put a rescue clause at
the end of the method and omit the begin and the extra end:

```ruby
def foo
  # mainline logic goes here
  rescue # -------------------
  # failure handling goes here
end
```

# EXCEPTIONS LIFECYCLE

_"Whatever the reason for the failure, a robust Ruby program needs to have
a coherent plan in place for handling exceptional conditions"_

```ruby
def handle_message(message)
  if message.type == "success"
handle_success(message)
  else
handle_failure(message)
  end
end

message.type # => "stats"
10 handle_message(message) # Uh oh!
```

`raise` syntax:
`raise [EXCEPTION_CLASS], [MESSAGE], [BACKTRACE]`

<br>
When calling rescue consider the following:

```ruby
rescue
# ...
end

#. . . is equivalent to:
rescue StandardError
# ...
end
```

There is a fairly long list of built-in exception types that a bare rescue will
not capture, including (but not limited to):<br>

• NoMemoryError<br>
• LoadError<br>
• NotImplementedError<br>
• SignalException<br>
• Interrupt<br>
• ScriptError<br>

### More about rescue:

```ruby
def errors_matching(&block)
  m = Module.new
  (class << m; self; end).instance_eval do
    define_method(:===, &block)
  end
  m
end

class RetryableError < StandardError
  attr_reader :num_tries

  def initialize(message, num_tries)
    @num_tries = num_tries
    super("#{message} (##{num_tries})")
  end
end

puts "About to raise"
begin
  raise RetryableError.new("Connection timeout", 2)
rescue errors_matching{|e| e.num_tries < 3} => e
  puts "Ignoring #{e.message}"
end
puts "Continuing..."

```

### About "Retry" in ruby

In the next example tries gets inremented by one feore trying, then te rescue block
evaluates if it will run begin again.

The exception "raise" is being caught and handled by the "rescue" block, and the program flow continues executing from the "retry" statement.

```ruby
tries = 0
begin
  tries += 1
  puts "Trying #{tries}..."
  raise "Didn’t work"
rescue
  puts e.message
  retry if tries < 3
  puts "I give up"
end

# Output

# Trying 1...
# Didn’t work
# Trying 2...
# Didn’t work
# Trying 3...
# Didn’t work
# I give up
```

### About else

else after a rescue clause is the opposite of rescue; where the rescue
clause is only hit when an exception is raised, else is only hit when no
exception is raised by the preceding code block.

```ruby
def foo
  yield
rescue
  puts "Only on error"
else
  puts "Only on success"
ensure
  puts "Always executed"
end

foo{ raise "Error" }
puts "---"
foo{ "No error" }

# Output

# Only on error
# Always executed
# ---
# Only on success
# Always executed
```

### About exit handlers

This fact is useful to us. Let’s say we wanted to log all fatal exception-induced crashes. Let’s say, further, that our code is running in a context where it is difficult or impossible to wrap the entire program in a begin...
rescue... end block. (E.g. a web application server running on hosted server that we don’t control). 
We can still “catch” Exceptions before the program exits using hooks.
Here’s a simple crash logger implemented with at_exit:

```ruby
at_exit do
  if $!
    open(’crash.log’, ’a’) do |log|
      error = {
        :timestamp => Time.now,
        :message => $!.message,
        :backtrace => $!.backtrace,
        :gems => Gem.loaded_specs.inject({}){
          |m, (n,s)| m.merge(n => s.version)
          }
        }
      YAML.dump(error, log)
    end
  end
end
```

# RESPONDING TO FALIURES
> If a faliure isn't a major one, consider adding a nil value in rescue block:

```ruby
  def save
    # ...
  rescue
    nil
  end
```
> Returning bengin value:

```ruby
begin
  response = HTTP.get_response(url)
  JSON.parse(response.body)
rescue Net::HTTPError
  {"stock_quote" => "<Unavailable>"}
end
```
  
> Consider using warn, and make them all exceptions:

 ```ruby
 if Rails.env.development?
  module Kernel
    def warn(message)
      raise message
    end
  end
end

warn "Uh oh"

# Output
# -:3:in ‘warn’: Uh oh (RuntimeError)
# from -:7
```

# Avoiding Bulkheads

Where to put bulkheads:

- External services
- External processes

One way to avoid failure cascades is to erect bulkheads in your system.
A bulkhead (or “barricade”, depending on who is describing it) is a wall
beyond which failures cannot have an effect on other parts of the system. A
simple example of a bulkhead is a rescue block that catches all Exceptions
and writes them to a log:

```ruby
begin
  SomeExternalService.some_request
rescue Exception => error
  logger.error "Exception intercepted calling SomeExternalService"
  logger.error error.message
  logger.error error.backtrace.join("\n")
end
```
# About ending the program
Calling "exit" when some situations are severe. We are actually rising an exception here: "SystemExit"
![Screenshot 2023-05-03 at 17 59 58](https://user-images.githubusercontent.com/72522628/236076076-c93d8b0e-3315-45a9-9ab6-e247ccfcb381.jpg)


# About the circut breaker pattern
- Closed state: In the normal state, when the circuit breaker is closed, all requests are allowed to pass through to the service. The Circuit Breaker keeps track of the number of failures and their frequency. If the failure rate surpasses a predefined threshold, the Circuit Breaker "trips" and moves to the open state.
- Open state: When the Circuit Breaker is in the open state, it blocks all requests to the service. This prevents further load on the failing service and allows it to recover. After a predefined timeout period, the Circuit Breaker moves to the half-open state to check if the service has recovered.
- Half-open state: In this state, the Circuit Breaker allows a limited number of requests to pass through to the service to test its availability. If the service responds successfully to these requests, the Circuit Breaker assumes that the service has recovered, and it moves back to the closed state, allowing all requests to pass through again. If the service is still experiencing failures, the Circuit Breaker goes back to the open state and continues to block requests.

### Different ways of handling errors:
```ruby
class Provisionment
  attr_reader :problems
  
  def initialize
    @problems = []
  end
  
  def perform
    @problems << "Failure downloading key file..."
  end
end

p = Provisionment.new
p.perform

if p.problems.size > 0
  handle errors
end
```

# Having Libraries to handle this errors:

There are three different types of errors:

1. User Error. The user did something invalid or not allowed. Usually
handled by notifying the user and giving them an opportunity to fix the
problem.

2. Logic Error. There is an error in the system. Typically handled by no-
tifying the system administrator and/or development team, and letting the user know that the problem is being looked into.

3. Transient Failure. Something is over capacity or temporarily offline.
Usually handled by giving the user a hint about when to come back
and try again, or, in the case of batch jobs, by arranging to re-try the
failed operation a little later.

```ruby
failures = 0
begin
  # ...
rescue MyLib::UserError => e
  puts e.message
  puts "Please try again"
  retry
rescue MyLib::TransientFailure => e
  failures += 1
  if failures < 3
    warn e.message
    sleep 10
    retry
  else
    abort "Too many failures"
   end
rescue MyLib::LogicError => e
  log_error(e)
  abort "Internal
end
```

When building a library, you may find it useful to break LogicError into two
subclasses:
1. InternalError, for errors (bugs) in the library itself; and
2. ClientError, for incorrect use of the library.
