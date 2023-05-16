# Identifying messages in our code:

**Feature:** Write a method which handles imports of CSV data from the old system to the new system.

_NOTE: The next is a example of how can cover identfy the message out of a list of pseudocode to complete a feature._

PSEUDOCODE:
1. Parse the purchase records from the CSV contained in a provided IO object.
2. For each purchase record, use the record's email address to get the associated customer record, or, if the email hasn't been seen before, create a new customer record in our system.
3. Use the legacy record's product ID to find or create a product record in our system. 👈 
4. Add the product to the customer record's list of purchases.
5. Notify the customer of the new location where they can download their files and update their account info.
6. Log the successful import of the purchase record.

---

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

-- So we end up having each step of our method converted into something like: --

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
