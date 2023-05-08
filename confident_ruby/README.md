# Writing clean code in ruby

> Ruby is designed to make programmers happy.
> - Yukhiro "Matz" Matsumoto

--- 
The next insights are insipred by the book:
Confindent Ruby by Avdi Grimm. 
---

> A single method is like a page in that story. And unfortunately, a lot of methods are just as convoluted, equivocal, and confusing as that made-up page above.

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

I added an example in [this file](https://github.com/daniel-enqz/ruby-corners-100/blob/master/confident_ruby/lib/identifying-messages.md), please check it to undertsand this step better 👌

# 2. Collecting input:
> Now that we know how the core system of our methods can be structured, lets take a look at the actual first step of our list.

Collecting input isn't just about finding needed inputs—it's about determining how lenient to be in accepting many types of input, and about whether to adapt the method's logic to suit the received collaborator types, or vice-versa.

> Methods may be dominated by handling for edge cases. This is hardly confident code.

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

```ruby
Kernel#Float is stricter than String#to_f:
   Float("$1.23")
   # ~> -:1:in `Float': invalid value for Float(): "$1.23"
   (ArgumentError)
   # ~>    from -:1:in `<main>'

```

4.- Convert string type to classes

Imagine we are working on a Traffic Light system,where we can initialize new objects like:

```ruby
TrafficLight.new("green")
```
The problem is that we can ran into syntax errors, or non existent colors, etc. 
Also each color may have different behaviours, I added a code example [here](https://github.com/daniel-enqz/ruby-corners-100/blob/master/confident_ruby/lib/traffic-light.md) that show us how to take advantage of polymorphism and Dependency Inversion Principle.


5.- Reject unworkable values with preconditions

In this next example we are using a precondition to check date is not nil and that it always is what we expect, we are using our constructor here.
```ruby
  require 'date' 

  class Employee

  attr_accessor :name 
  attr_reader :hire_date

  def initialize(name, hire_date) 
    @name = name self.hire_date = hire_date
  end

  def hire_date=(new_hire_date)
    raise TypeError, "Invalid hire date" unless
    new_hire_date.is_a?(Date) @hire_date = new_hire_date
  end

  # [...]
```

We can also use preconditions not only in clases for setting instance variable but for individual methods as well.

```ruby
def issue_service_award(employee_address, hire_date, award_date) 
  unless (FOUNDING_DATE..Date.today).include?(hire_date)
    raise RangeError, "Fishy hire_date: #{hire_date}" 
  end
  years_employed = ((Date.today - hire_date) / 365).to_i

  # $10 for every year employed
  issue_gift_card(address: employee_address, amount: 10 * years_employed)
end
```

This is great because we the first we are seeing on methods or clases, is a precondtion statement, which serves to know the expected type.

6.- Use #fetch to assert the presence of Hash keys.
> This one was one of my favourite ones in the book, when we are sending a hash to a method, there are multiple ways in which we can check for existent and non existent keys.

The next example is taking advantage of the precodintions pattern we learned before. 
```ruby
def add_user(attributes)
  login = attributes[:login] 
  unless login
    raise ArgumentError, 'Login must be supplied' 
   end
   
  password = attributes[:password] 
   unless password
     raise ArgumentError, 'Password (or false) must be supplied' 
   end
[...]
```
Reasons this is bad code:
- Its to many lines of code
- We will ran in the next error:

```ruby
add_user(login: 'bob', password: '12345', dry_run: true) # >> useradd --password 12345 bob
add_user(login: 'bob', dry_run: true) # ~> #<ArgumentError: Password (or false) must be supplied>
add_user(login: 'bob', password: false, dry_run: true) # >> #<ArgumentError: Password (or false) must be supplied>
# Uh-oh. In theory, passing :password => false should function as a flag to cause the method to create an account with login disabled.
# But this will not pass the unless conditional
```
We can rewrite the method as follows:

```ruby
def add_user(attributes)
  login = attributes.fetch(:login) 
  password = attributes.fetch(:password) do
    raise KeyError, "Password (or false) must be supplied" 
   end
# ...
end
```

The good think about fetch is that it will raise an exception when no key is given, we can also use fetch with Arrays or ENV objects.
See how we are also giving custom error messages by givinga block to fetch. 

```ruby
test{ h.fetch(:a) } # => "truthy (123)"
test{ h.fetch(:b) } # => "falsey (false)"
test{ h.fetch(:c) } # => "falsey (nil)"
test{ h.fetch(:x) } # => "Password (or false) must be supplied" 
```

- Note how we can also give rescue actions insead of throwing errors. Check page 122 where this is explained with more detail.
We will use a default logger if no :logger is given.

```ruby
DEFAULT_LOGGER = -> { Logger.new($stderr) }

def emergency_kittens(options={})
  logger = options.fetch(:logger) { &DEFAULT_LOGGER }
  # ...
end
```

7.- Representing Special Case Objects.
  

When we work with sessions we have the special case when the user is not logged in. This is how Ruby on Rails handles it:
```ruby
def current_user
  if session[:user_id]
    User.find(session[:user_id]) 
  end
end
```
🤔 But this will return just nil when theres not user logged in. Many methods in our codebase will look like this:

```ruby
def greeting "Hello, " +
 current_user ? current_user.name : "Anonymous" +
 ", how are you today?"
end
```
  
We can create a special case object that handles this not session given case:

```ruby
def current_user
  if session[:user_id]
    User.find(session[:user_id]) 
  else
    GuestUser.new(session) 
  end
end
```
  
This will help us not relly on unexpected nil values.
  
```ruby
class GuestUser
  def name 
    "Anonymous"
  end 
end
  
# This simplifies the greeting code nicely.
def greeting
  "Hello, #{current_user.name}, how are you today?"
end
```
The cool think about this is that we can gradually be changing methods in our program. Gretting is sort of like our "test pilot". We can add more methods to the GuestUser class.
We can even take advantage of polymorpishm and handle this cases:

```ruby
if current_user.authenticated? 
  render_logout_button
else
  render_login_button
end
```
In this example we constructed a Special Case object which fully represents the case of "no logged-in user".
  
We can isolate test scenarios in Rspec like:

```ruby
shared_examples_for 'a user' do
  it { should respond_to(:name) }
  it { should respond_to(:authenticated?) } it { should respond_to(:has_role?) }
  it { should respond_to(:visible_listings) } it { should respond_to(:last_seen_online=) } it { should respond_to(:cart) }
end

describe GuestUser do
  subject { GuestUser.new(stub('session')) } 
  it_should_behave_like 'a user'
end
 
describe User do
  subject { User.new } 
  it_should_behave_like 'a user'
end
```
  
By using a Special Case object, we isolate the differences between the typical case and the special case to a single location in the code, and let polymorphism ensure that the right code gets executed. The end product is code that reads more cleanly and succinctly, and which has better partitioning of responsibilities.

5.- Using a special object to represent "do nothing" cases is a powerful way to clean up code by eliminating spurious conditionals.
6.- A known-good placeholder can eliminate tedious checks for the presence of optional information.
 For example, when no location is given we can just substitute for a bengin value. `group.city_location` serves as a fallback that will not harm our program.
 ```ruby
  location = Geolocatron.locate(member.address) || group.city_location
 ```
7.- We can find nil values all over the program. Because of their ubiquity, communicate little or no meaning when they turn up unexpectedly. So how can we communicate problems more effectively?

  
Sometimes tracking where the nil value comes from, its easier to give a meaninfgul way to show the erro with a symbol
  
 ```ruby
  credentials = options.fetch(:credentials) { :credentials_not_set }
   -:7:in `list_widgets': undefined method `fetch' for
     :credentials_not_set:Symbol (NoMethodError)
   from -:19:in `<main>'
 ```
  
By supplying a symbolic placeholder value, we've enabled the method to communicate more clearly with the client coder. And we've done it with the smallest of changes to the code.

8.- Bundle arguments into parameter objects (Check Map/Points example in page 182)
Relying on objects, will let us going from this:
 ```ruby
map = Map.new
map.draw_point(23, 32, starred: true, fuzzy_radius: 100)
 ```
  
 ```ruby
map = Map.new
p1 = FuzzyPoint.new(StarredPoint.new(23, 32), 100)
map.draw_point(p1)
 ```
We added a Point class to act as a parameter object, and then elaborated with various specializations and decorations of the Point class. 
 
9.- Yield a parameter builder object

When working with methods that may require options, this is a super cool example of how we can send multiple and custom options by having isolated objects created and using a yield/block to send to methods. (Faraday gem uses this pattern 🙌) 
  
```ruby
class Map
  def draw_point(point_or_x, y=:y_not_set_in_draw_point)
    point = point_or_x.is_a?(Integer) ? Point.new(point_or_x, y) : point_or_x
    builder = PointBuilder.new(point) yield(builder) if block_given? builder.point.draw_on(self)
  end
  
  def draw_starred_point(x, y, &point_customization) 
    draw_point(StarredPoint.new(x, y), &point_customization)
  end
# ...
end
  
map.draw_starred_point(7, 9) do |point| 
  point.name = "gold buried here" 
  point.magnitude = 15 
  point.fuzzy_radius = 50
end

10.- Sending Procs
As we see in the next example, we can send procs to handle errors and edge cases.

```ruby
def delete_files(files, options={})
  error_policy =
    options.fetch(:on_error) { ->(file, error) { raise error } } symlink_policy =
    options.fetch(:on_symlink) { ->(file) { File.delete(file) } } files.each do |file|
  begin
    if File.symlink?(file)
      symlink_policy.call(file) 
    else
      File.delete(file) 
    end
  rescue => error 
    error_policy.call(file, error)
  end 
end
```

```ruby
  delete_files(
  ['file1', 'file2'],
  on_error: ->(file, error) { warn error.message }, on_symlink: ->(file) { File.delete(File.realpath(file)) })
```
