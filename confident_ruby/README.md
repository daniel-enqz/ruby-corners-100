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

I choose the top 10 approaches that were more intresting for me from the book and put them [here](https://github.com/daniel-enqz/ruby-corners-100/blob/master/confident_ruby/lib/collecting-input.md), clear descriptions and code examples can also be found there 🪴

# 3. Delivering Output
> _"We should also ensure that our outputs make it easy for the clients of our code to be written in a confident style as well."_

1.- Writing total functions:
Methods that may or may not return an array put an extra burden on callers to check the type of the result. Ensuring that an array is always returned no matter what enables callers to handle the result in a consistent, confident fashion.
