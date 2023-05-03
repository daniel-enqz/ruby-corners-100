# Failure as a breach of contract

This repo is a set of excercises to practice exceptions, failures and error handling.
Took inspiration from: [Exceptional Ruby by Avdi Grimn](https://drive.google.com/drive/folders/1pji-ot0DVqdIlnkz6SdCAVk0-EYsGAXU)

---

A method’s contract states “given the following inputs, I promise to return certain outputs and/or cause certain side-effects”. 
It is the callers responsibility to ensure that the method’s preconditions the inputs it depends on—are met. 
It is the method’s responsibility to ensure that its postconditions of those outputs and side-effects—are fulfilled.

---

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
not capture, including (but not limited to):
• NoMemoryError
• LoadError
• NotImplementedError
• SignalException
• Interrupt
• ScriptError

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

This fact is useful to us. Let’s say we wanted to log all fatal exception-
induced crashes. Let’s say, further, that our code is running in a context

where it is difficult or impossible to wrap the entire program in a begin . . .
rescue . . . end block. (E.g. a web application server running on hosted
server that we don’t control). We can still “catch” Exceptions before the
program exits using hooks.
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
