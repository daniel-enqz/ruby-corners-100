# Writing clean code in ruby

> Ruby is designed to make programmers happy.
> - Yukhiro "Matz" Matsumoto

--- 
The next insights are insipred by the book:
Confindent Ruby by Avdi Grimm. 
---

> A single method is like a page in that story. And unfortunately, a lot of methods are just as convoluted, equivocal, and confusing as that made-up page above.

I believe that if we take a look at any given line of code in a method, we can nearly always categorize it as serving one of the following roles:

1. Collecting input
2. Performing work
3. Delivering output
4. Handling failures

For intsance, lets take a look at the next example which actually looks everwhelming, its not ordered.....🤔
<img src="https://user-images.githubusercontent.com/72522628/236586862-eb9a587f-8b8b-4608-94de-1b99442b3fa2.jpg" alt="kublau" width="600" height="300">


## So how can we create readable code and tell a story with our methods?

#### 1. Performing the work:
> Let's start by defining "Performing the work", which is basically the core of every method.

**We need 3 essential steps to achieve this**:
1. Identifying the messages we want to send (in language as close to that of the problem domain as possible); then...
2. Determining the roles which make sense to receive those messages; and finally...
3. Bridging the gap between the roles we've identified and the objects which actually exist in the system.

I added an example in [this file](https://github.com/daniel-enqz/ruby-corners-100/tree/master/confident_ruby/lib), please check it to undertsand this step better 👌

#### 2. Collecting input:
> Now that we know how the core system of our methods can be structured, lets take a look at the actual first step of our list.

What about methods with no input? 🤔

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
