# Ruby is designed to make programmers happy.
– Yukhiro "Matz" Matsumoto

The next insights about writing clean and understable code in ruby is insipred by the book:
Confindent Ruby by Avdi Grimm.

> A single method is like a page in that story. And unfortunately, a lot of methods are just as convoluted, equivocal, and confusing as that made-up page above.


I believe that if we take a look at any given line of code in a method, we can nearly always categorize it as serving one of the following roles:

1. Collecting input
2. Performing work
3. Delivering output
4. Handling failures

For intsance, lets take a look at the next example which actually looks everwhelming, its not ordered.....🤔
![Screenshot 2023-05-05 at 18 02 24](https://user-images.githubusercontent.com/72522628/236586862-eb9a587f-8b8b-4608-94de-1b99442b3fa2.jpg)

## So how do we can create readble code and as tell a story with our methods?

> Let's start by defining "Performing the work", which is basically the core of every method.

#### Point 1: Sending the message:
1. We must identify the messages we want to send in order to accomplish the task at hand. (This is mostly like based on pseudocode, do something like:)

`Use the legacy record's product ID to find or create a product record in our system.`

Identified message:
`Use the record's #product_id to #get_product.`


2. We must identify the roles which correspond to those messages.

| Message  | Receiver Role | 
| #get_product | product_inventory |


4. We must ensure the method's logic receives objects which can play those
roles.
