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
<img src="https://user-images.githubusercontent.com/72522628/236586862-eb9a587f-8b8b-4608-94de-1b99442b3fa2.jpg" alt="kublau" width="600" height="300">


## So how can we create readable code and tell a story with our methods?

> Let's start by defining "Performing the work", which is basically the core of every method.

#### Point 1: Sending the message:
1. We must identify the messages we want to send in order to accomplish the task at hand. (This is mostly like based on pseudocode, do something like:)

`Use the legacy record's product ID to find or create a product record in our system.`

Identified message:
`Use the record's #product_id to #get_product.`


2. We must identify the roles which correspond to those messages.

| Message       | Receiver Role     |
|---------------|-------------------|
| #get_product  | product_inventory |
| #email_address, #product_id | purchase_record |

So we can rewrite this is step as:
`Use the purchase_record.product_id to product_inventory.get_product.


4. We must ensure the method's logic receives objects which can play those
roles.

NOTE: The step we describe above is just one of the multiple ones we see in the next method. But this covers our first step.
```ruby
def import_legacy_purchase_data(data)
  purchase_list = legacy_data_parser.parse_purchase_records(data) purchase_list.each do |purchase_record|
       customer = customer_list.get_customer(purchase_record.email_address)
       product  = product_inventory.get_product(purchase_record.product_id)
       customer.add_purchased_product(product)
       customer.notify_of_files_available(product)
       log_successful_import(purchase_record)
  end 
end
```
