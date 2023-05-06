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
**Feature:** Write a method which handles imports of CSV data from the old system to the new system.

_NOTE: The next is a example of how can cover identfy the message out of a list of pseudocode to complete a feature._

PSEUDOCODE:
1. Parse the purchase records from the CSV contained in a provided IO object.
2. For each purchase record, use the record's email address to get the associated customer record, or, if the email hasn't been seen before, create a new customer record in our system.
3. Use the legacy record's product ID to find or create a product record in our system. 👈 
4. Add the product to the customer record's list of purchases.
5. Notify the customer of the new location where they can download their files and update their account info.
6. Log the successful import of the purchase record.


1. We must identify the messages we want to send in order to accomplish the task at hand. (This is mostly like based on pseudocode, do something like:)

`Use the legacy record's product ID to find or create a product record in our system.`

Identified message:
`Use the record's #product_id to #get_product.`


2. We must identify the roles which correspond to those messages.

By identifying roles (objects that we are using to get the information) we can rewrite our steps like:
`Use the purchase_record.product_id to product_inventory.get_product.`

| Message       | Receiver Role     |
|---------------|-------------------|
| #get_product  | product_inventory |
| #email_address, #product_id | purchase_record |

-- So we end up having each step of our method converted into something like:

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
