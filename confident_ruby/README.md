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

# 1. Performing the work:
> Let's start by defining "Performing the work", which is basically the core of every method.

**We need 3 essential steps to achieve this**:
1. Identifying the messages we want to send (in language as close to that of the problem domain as possible); then...
2. Determining the roles which make sense to receive those messages; and finally...
3. Bridging the gap between the roles we've identified and the objects which actually exist in the system.

I added an example in [this file](https://github.com/daniel-enqz/ruby-corners-100/blob/master/confident_ruby/lib/identifying-messages.md), please check it to undertsand this step better 👌

# 2. Collecting input:
> Now that we know how the core system of our methods can be structured, lets take a look at the actual first step of our list.

Collecting input isn't just about finding needed inputs—it's about determining how lenient to be in accepting many types of input, and about whether to adapt the method's logic to suit the received collaborator types, or vice-versa.

### The goal is mapping the roles we need with the objects we have in our system.
I added more info in [this file](https://github.com/daniel-enqz/ruby-corners-100/tree/master/confident_ruby/lib/inputs.md), please check it to undertsand this step better 👌

## Whow can we do a better input collection?
1.- Be sure to use built-in conversion protocols (#to_str, #to_i, #to_path, or #to_ary.)
Here some cool examples:

<img src="https://user-images.githubusercontent.com/72522628/236654936-0063fce5-a949-4690-855f-4cb7ba33ec6f.jpg" alt="kublau" width="600" height="300">

I added some examples of the difference bewteen explicit and implict methods [here](https://github.com/daniel-enqz/ruby-corners-100/blob/master/confident_ruby/lib/built-in-methods.md).

> The key to working productively in an object-oriented language is to make the type system and polymorphic method dispatch do your work for you.

## Working with protocols

2.- Using our own built-in protocols.

> A well-documented protocol for making arbitrary objects convertible to our own types makes it possible to accept third-party objects as if they were "native".

- As you can see, in the next example we are only allowing `-`, can only be performed on instances of `Meters`.
- We are also crearing our own converison protocol .to_meters`
- We can now report changes in altitude without fear of mixed units. 
- We've ensured that any object which doesn't support the #to_meters protocol will trigger a NoMethodError.

```ruby

class Feet
  def to_meters
    Meters.new((value * 0.3048).round)
  end 
end


require 'forwardable' 

class Meters     
  extend Forwardable
  
  def_delegators :@value, :to_s, :to_int, :to_i

  def initialize(value) 
    @value = value
  end
  
  def to_meters 
    self
  end

  def -(other)
    self.class.new(value - other.to_meters.value)
  end

  protected
  
  attr_reader :value 
 end
 
 def report_altitude_change(current_altitude, previous_altitude) 
  change = current_altitude.to_meters - previous_altitude.to_meters
 end
```

3.- Use built-in conversion functions
- Integer()
- Array()


4.- Convert string type to classes

Imagine we are working on a Traffic Light system,where we can initialize new objects like:

```ruby
TrafficLight.new("green")
```
The problem is that we can ran into syntax errors, or non existent colors, etc. 
Also each color may have different behaviours, I added a code example here that show us how to take advantage of polymorphism and Dependency Inversion Principle.


5.- Reject unworkable values with preconditions

