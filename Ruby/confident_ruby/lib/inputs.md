# What about methods with no input? 🤔

```ruby
def seconds_in_day 
  24 * 60 * 60
end
```

```ruby
# This method could just as easily be a constant:
  SECONDS_IN_DAY = 24 * 60 * 60
```

Overall a method can have many kinds of input, lets cover the most important ones in one simple example:
- Through an instance variable
- Arguments
- Constant / Objects (like Time)
- Thourgh a method in the same class
- Constant inside the class


```ruby
class TimeCalc
  SECONDS_IN_DAY = 24 * 60 * 60

  def initialize
    @start_date = Time.now 
  end
  
  def time_n_days_from_now(num_days) 
    @start_date + num_days * 24 * 60 * 60
  end
  
  def seconds_in_week
    seconds_in_days(7) 
  end
  
  def seconds_in_days(num_days) 
    num_days * SECONDS_IN_DAY
  end
end
```

> Any time we send a message to an object other than self in order to use its return value, we're using indirect inputs.

In the next example we see how the first three lines are incharged of collecting input. Where only the last one is actually performing the work of the method.
Also note how we are combining two inirect inouts (We are using the `user`to get the `prefs`, both indirect inputs.

```ruby
def format_time
  user = ENV['USER']
  prefs = YAML.load_file("/home/#{user}")
  Time.now.strftime(format) 
end

```
