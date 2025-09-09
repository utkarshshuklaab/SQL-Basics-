CREATE DATABASE pw;
 /*conn=sqlite3.connect('test.db')
     
 1. Create a table called employees with the following structure?

 : emp_id (integer, should not be NULL and should be a primary key)

: emp_name (text, should not be NULL)

: age (integer, should have a check constraint to ensure the age is at least 18)

: email (text, should be unique for each employee)

: salary (decimal, with a default value of 30,000)

Write the SQL query to create the above table with all constraints.

Ans:- Certainly! Here's the SQL query to create your employees table with all the specified constraints, along with some emojis for a touch of fun! 🚀*/


     CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY NOT NULL,         -- 🔑 Employee ID, unique and required
    emp_name TEXT NOT NULL,                      -- 📝 Employee Name, required
    age INTEGER CHECK (age >= 18),               -- 🎂 Age, must be 18 or older
    email TEXT UNIQUE NOT NULL,                  -- 📧 Email, unique for each employee
    salary DECIMAL DEFAULT 30000.00              -- 💰 Salary, defaults to 30,000
);

     
/*Explanation of Constraints 🧐

PRIMARY KEY: The emp_id column is set as the primary key. This means each emp_id must be unique and cannot be NULL, ensuring a consistent way to identify each employee.

NOT NULL: Both emp_id and emp_name are marked as NOT NULL, which ensures that these fields must always have a value when a new employee record is added.

CHECK (age >= 18): This constraint on the age column prevents any employee from being added if their age is less than 18, ensuring legal employment age.

UNIQUE: The email column has a UNIQUE constraint, which means no two employees can have the same email address. This is crucial for individual identification and communication.

DEFAULT 30000.00: The salary column has a DEFAULT value of 30000.00. If a salary is not explicitly provided when a new employee is added, it will automatically be set to this value.

This table structure ensures data integrity and helps manage your employee records efficiently! 👍

2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.

Ans:- Constraints are rules applied to columns or tables in a database that limit the type of data that can be inserted, updated, or deleted. Their main purpose is to enforce data integrity 🛡️, which means ensuring the data is accurate, consistent, and reliable. By using constraints, you can prevent "garbage in, garbage out" scenarios and guarantee that the data adheres to predefined business rules. Instead of relying on application code to validate every data entry, constraints enforce these rules at the database level, ensuring they're always met, no matter how the data is being modified*/

/*How Constraints Maintain Data Integrity

Constraints maintain data integrity by acting as a safeguard against bad data. They help in three key areas:

Domain Integrity: Constraints ensure that a column's values fall within a specific domain or set of valid entries. For example, a CHECK constraint can ensure that an employee's age is never a negative number.

Entity Integrity: This ensures that each row in a table is uniquely identified. It prevents duplicate records and ensures that a primary key value is never NULL, which is essential for referencing individual records.

Referential Integrity: This maintains the relationships between tables. A constraint can ensure that a record in one table (the "child" table) refers to a valid and existing record in another table (the "parent" table), preventing "orphaned" records.

3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.

ANS:- You'd apply the NOT NULL constraint to a column when you want to ensure that every record in that column has a value, preventing it from being empty. This is crucial for maintaining data integrity 🛡️, as it guarantees that essential information is always present. For example, in an employees table, you'd apply a NOT NULL constraint to the first_name and last_name columns because an employee record is incomplete and not useful without these details. .

A primary key cannot contain NULL values. 🙅‍♀️

The primary key serves as the unique identifier for each record in a table. It's the cornerstone of entity integrity 🔗, which requires that every row in a table can be uniquely and reliably identified. If a primary key were allowed to contain NULL values, it would be impossible to guarantee this uniqueness. A NULL value represents an unknown or missing value, and therefore cannot be used to uniquely identify a specific record. The very purpose of the primary key is to provide a non-ambiguous way to reference each row, and NULL values would directly contradict this fundamental principle.

4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.

Ans:- The SQL command used to add or remove constraints on an existing table is ALTER TABLE 🛠️. This powerful command allows you to modify the structure of a table after it's been created, including adding new columns, dropping existing ones, and, most importantly, managing constraints.

Adding a Constraint ✨ To add a constraint, you use the ALTER TABLE statement followed by ADD CONSTRAINT. This is particularly useful when you've already populated a table and realize you need to enforce a new rule. The general syntax is:


ALTER TABLE table_name
ADD CONSTRAINT constraint_name constraint_type (column_name);
     
Example: Adding a UNIQUE constraint to an email column 📧

Let's say you have an employees table without an email constraint, and you want to ensure all emails are unique.


-- First, make sure there are no duplicate emails already in the table.
-- If there are, this command will fail.
ALTER TABLE employees
ADD CONSTRAINT uq_email UNIQUE (email);
     
In this example:

ALTER TABLE employees specifies the table to be modified.

ADD CONSTRAINT uq_email is the command to add a new constraint, and uq_email is a custom name you're giving to it for easy reference.

UNIQUE (email) specifies the type of constraint and the column it applies to.

Removing a Constraint ❌

To remove a constraint, you also use ALTER TABLE, but with the DROP CONSTRAINT clause. You must know the name of the constraint you want to drop. This is why it's a good practice to name your constraints when you add them. The general syntax is:


SQL*/

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
     
/*Example: Removing the UNIQUE constraint from the email column 🗑️

Following the previous example, if you need to remove the unique email constraint (for instance, to allow for multiple employees to share a generic email address), you'd use the following command:


SQL*/
ALTER TABLE employees
DROP CONSTRAINT uq_email;
     
/*In this case, DROP CONSTRAINT uq_email tells the database to find and remove the constraint with that specific name from the employees table.

5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.

Ans:- Attempting to modify data in a way that violates a constraint results in an immediate failure 🚫 of the operation and an error message 🚨 being returned by the database management system. The database will reject the transaction entirely, preventing the invalid data from being stored and preserving the integrity and consistency of the data already in the table. This is the core purpose of constraints—to act as a gatekeeper, ensuring that only valid data enters the system.

Consequences of Violating Constraints

Insertion Failures: If you try to INSERT a new row that violates a constraint, the entire row will be rejected. For example, trying to insert an employee with an age of 15 (when there's a CHECK (age >= 18) constraint) will cause the insertion to fail completely.

Update Failures: If you try to UPDATE a row in a way that would violate a constraint, the change will not be applied. For instance, attempting to change an employee's salary to a negative number or their email to one that already exists would be blocked.

Deletion Failures: This is most common with FOREIGN KEY constraints. If you try to DELETE a row from a "parent" table that is referenced by rows in a "child" table, the deletion will be blocked to prevent "orphaned" records. For example, you can't delete a customer record if there are still orders associated with that customer.

Example of a Violation Error Message

The error message you receive will be specific to the type of constraint you violated. Here’s a typical example for a UNIQUE constraint violation:

Let's assume you have an employees table where the email column has a UNIQUE constraint.


SQL*/

-- This INSERT works because the email is unique
INSERT INTO employees (emp_id, emp_name, email) VALUES (1, 'Alice', 'alice@company.com');

-- This INSERT will fail because the email 'alice@company.com' already exists
INSERT INTO employees (emp_id, emp_name, email) VALUES (2, 'Bob', 'ashishpal.com');
     
/*The database would immediately stop the second operation and return an error message similar to this:

ERROR: duplicate key value violates unique constraint "uq_email" DETAIL: Key (email)=(ashishpal.com) already exists.

This error message is informative 💡. It clearly states:

ERROR: duplicate key value: The specific type of error.

violates unique constraint "uq_email": The name of the constraint that was violated.

Key (email)=(alice@company.com) already exists: The exact value that caused the violation.

This level of detail helps a developer understand exactly what went wrong and how to fix it, which is why error messages from database constraints are so valuable.

You created a products table without constraints as follows:*/
CREATE TABLE products (

product_id INT,

product_name VARCHAR(50),

price DECIMAL(10, 2));

/*Now, you realise that
The product_id should be a primary key.

The price should have a default value of 50.00.

Ans:- Here are the SQL commands to modify the products table to add the specified constraints.

Modifying the Products Table

The ALTER TABLE command is used to add constraints to an existing table. You'll need two separate commands to add the primary key and the default value.

1. Add a Primary Key Constraint 🔑

To make product_id a primary key, you use the ADD PRIMARY KEY clause. This will enforce that all product_id values are unique and not null.


SQL*/
 ALTER TABLE products
ADD PRIMARY KEY (product_id);
     
/*2. Set a Default Value for the Price 💰

To set a default value of 50.00 for the price column, you use the ALTER COLUMN clause with the SET DEFAULT option.


SQL*/
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;
     
/*After executing these two commands, your products table will have the following constraints:

product_id: Will be a primary key.

price: Will have a default value of 50.00.

7. You have two tables:

HERE I CREATE OWN TABLE FROM USING PANDAS


import pandas as pd

students_data = {'student_id': [1, 2, 3],
                'student_name': ['Alice', 'Bob', 'Charlie'],
                'class_id': [101, 102, 101]}
students_df = pd.DataFrame(students_data)
print(" ")
classes_data = {'class_id': [101, 102, 103],
               'class_name': ['Math', 'Science', 'History']}
classes_df = pd.DataFrame(classes_data)

print("Students Table:")
print(students_df.to_markdown(index=False))
print("  ")
print("  ")
print("  ")
print("\nClasses Table:")
print(classes_df.to_markdown(index=False))

     
 
Students Table:
|   student_id | student_name   |   class_id |
|-------------:|:---------------|-----------:|
|            1 | Alice          |        101 |
|            2 | Bob            |        102 |
|            3 | Charlie        |        101 |
  
  
  

Classes Table:
|   class_id | class_name   |
|-----------:|:-------------|
|        101 | Math         |
|        102 | Science      |
|        103 | History      |
To fetch the student_name and class_name for each student using an INNER JOIN, you'd typically need two tables: one for students and one for classes, with a common column to link them (like class_id).

Here's the SQL query:


SQL*/

SELECT
    s.student_name,
    c.class_name
FROM
    students s
INNER JOIN
    classes c ON s.class_id = c.class_id;
     
/*Explanation 🧐

SELECT s.student_name, c.class_name: This specifies the columns you want to retrieve. s and c are aliases for the students and classes tables, respectively, making the query shorter and easier to read.

FROM students s: This indicates that you're starting the query with the students table and assigning it the alias s.

INNER JOIN classes c ON s.class_id = c.class_id: This is the core of the join operation.

INNER JOIN: This clause combines rows from two or more tables based on a related column between them. It returns only the rows that have matching values in both tables. Rows that don't have a match in the other table are excluded.

classes c: Specifies the second table to join (classes) and assigns it the alias c.

ON s.class_id = c.class_id: This is the join condition. It tells the database to match rows from the students table (s) with rows from the classes table (c) where the value in the class_id column is the same in both tables.

This query effectively links each student to their respective class, returning a result set that includes both their name and their class name. 🧑‍🎓📚

8. Consider the following three tables:

HERE I CREATE OWN TABLE FROM USING PANDAS


import pandas as pd
import numpy as np

orders_data = {'order_id': [1, 2, 3],
               'order_date': ['2024-01-01', '2024-01-02', '2024-01-03'],
               'customer_id': [101, 101, 102]}
orders_df = pd.DataFrame(orders_data)
print("Orders Table:")
print(orders_df.to_markdown(index=False))
print("\n")


Customers_data = {'customer_id':[101,102],
                  'customer_name':['Alice', 'Bob']}
Customers_df = pd.DataFrame(Customers_data)
print('Customers Table:')
print(Customers_df.to_markdown(index=False))
print("\n")


Product_data = {
    'Product_id':[1,2],
    'product_name':['Laptop','Phone'],
    'order_id':[1,'NULL']
}
Product_df_original = pd.DataFrame(Product_data)
print('Product Table (Original):')
print(Product_df_original.to_markdown(index=False))

     
Orders Table:
|   order_id | order_date   |   customer_id |
|-----------:|:-------------|--------------:|
|          1 | 2024-01-01   |           101 |
|          2 | 2024-01-02   |           101 |
|          3 | 2024-01-03   |           102 |


Customers Table:
|   customer_id | customer_name   |
|--------------:|:----------------|
|           101 | Alice           |
|           102 | Bob             |


Product Table (Original):
|   Product_id | product_name   | order_id   |
|-------------:|:---------------|:-----------|
|            1 | Laptop         | 1          |
|            2 | Phone          | NULL       |
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are

listed even if they are not associated with an order

Hint: (use INNER JOIN and LEFT JOIN)

HERE I USE PYTHON CODE FOR SOLVING THIS QUESTION:


import pandas as pd
import numpy as np

# Original DataFrames
orders_data = {'order_id': [1, 2, 3],
               'order_date': ['2024-01-01', '2024-01-02', '2024-01-03'],
               'customer_id': [101, 101, 102]}
orders_df = pd.DataFrame(orders_data)

Customers_data = {'customer_id':[101,102],
                  'customer_name':['Alice', 'Bob']}
Customers_df = pd.DataFrame(Customers_data) # Renamed for clarity

Product_data = {
    'Product_id':[1,2],
    'product_name':['Laptop','Phone'],
    'order_id':[1,'NULL'] # Original 'NULL' as string
}
Product_df_original = pd.DataFrame(Product_data)

# Pre-processing: Convert 'NULL' string to NaN in Product DataFrame for proper merging
Product_df = Product_df_original.copy()
Product_df['order_id'] = Product_df['order_id'].replace('NULL', np.nan).astype(float) # Convert to float to allow NaN

# Display original tables
print("Orders Table:")
print(orders_df.to_markdown(index=False))

print("\n")

print('Customers Table:')
print(Customers_df.to_markdown(index=False))

print("\n")

print('Product Table (Original):')
print(Product_df_original.to_markdown(index=False))

print("\n")

# --- Performing the Joins ---

# Step 1: INNER JOIN orders_df with Customers_df
# This links orders to customer names. We use an INNER JOIN because we only care
# about orders that have a valid customer associated with them.
orders_with_customers = pd.merge(orders_df, Customers_df, on='customer_id', how='inner')

# Step 2: LEFT JOIN Product_df with the result from Step 1
# We use Product_df as the LEFT DataFrame to ensure ALL products are listed,
# even those (like the 'Phone') that don't have an 'order_id' or a matching order.
# The `how='left'` ensures all rows from `Product_df` are kept.
final_merged_df = pd.merge(Product_df, orders_with_customers[['order_id', 'customer_name']],
                           on='order_id',
                           how='left')

# Select the required columns: order_id, customer_name, and product_name
result_df = final_merged_df[['order_id', 'customer_name', 'product_name']]

print('Resulting Query:')
print(result_df.to_markdown(index=False))
     
Orders Table:
|   order_id | order_date   |   customer_id |
|-----------:|:-------------|--------------:|
|          1 | 2024-01-01   |           101 |
|          2 | 2024-01-02   |           101 |
|          3 | 2024-01-03   |           102 |


Customers Table:
|   customer_id | customer_name   |
|--------------:|:----------------|
|           101 | Alice           |
|           102 | Bob             |


Product Table (Original):
|   Product_id | product_name   | order_id   |
|-------------:|:---------------|:-----------|
|            1 | Laptop         | 1          |
|            2 | Phone          | NULL       |


Resulting Query:
|   order_id | customer_name   | product_name   |
|-----------:|:----------------|:---------------|
|          1 | Alice           | Laptop         |
|        nan | nan             | Phone          |
/tmp/ipython-input-992087300.py:23: FutureWarning: Downcasting behavior in `replace` is deprecated and will be removed in a future version. To retain the old behavior, explicitly call `result.infer_objects(copy=False)`. To opt-in to the future behavior, set `pd.set_option('future.no_silent_downcasting', True)`
  Product_df['order_id'] = Product_df['order_id'].replace('NULL', np.nan).astype(float) # Convert to float to allow NaN
Explanation of the Query Steps 🚀

Data Preparation: We first create copies of your original DataFrames. Crucially, the order_id in the Product DataFrame is modified to replace the string 'NULL' with np.nan (a numerical "Not a Number") and converted to float. This ensures that pd.merge can correctly handle the missing order association when joining with the numeric order_id from the orders_df.

INNER JOIN Orders and Customers:


orders_with_customers = pd.merge(orders_df, Customers_df, on='customer_id', how='inner')
     
This step combines orders_df and Customers_df based on their common customer_id. An INNER JOIN is used because we only want to see orders that are actually linked to an existing customer. The result is a DataFrame containing order details along with the associated customer's name.

LEFT JOIN Products with Orders and Customers:


final_merged_df = pd.merge(Product_df, orders_with_customers[['order_id', 'customer_name']],
                           on='order_id',
                           how='left')
     
Here, we take our prepared Product_df as the left DataFrame. We then LEFT JOIN it with a subset of orders_with_customers (just order_id and customer_name). The how='left' parameter is key: it guarantees that all rows from the Product_df (our left table) are included in the final result.

For products that have a matching order_id (like 'Laptop'), their corresponding order_id and customer_name are pulled in from the orders_with_customers DataFrame.

For products that do not have a matching order_id (like 'Phone', which has NaN), the order_id and customer_name columns in the joined result will show NaN, fulfilling the requirement to list all products even if they aren't associated with an order.

4.Selecting Final Columns:


result_df = final_merged_df[['order_id', 'customer_name', 'product_name']]
     
Finally, we select only the order_id, customer_name, and product_name columns as requested to form the desired output. 🎉

9. Given the following tables:

HERE I USE PYTHON CODE FOR THIS QUESTION:


import pandas as pd
Sales={
    'sales_id':[1,2,3],
    'product_id':[101,102,101],
    'amount':[500,300,700]
}
Sales=pd.DataFrame(Sales)
print(" Sales :")
print(Sales.to_markdown(index=False))

print("\n")



Products={
    'product_id':[101,102],
    'product_name':['Laptop','Phone']
}
Products=pd.DataFrame(Products)
print("Products :")
print(Products.to_markdown(index=False))

print("\n")

     
 Sales :
|   sales_id |   product_id |   amount |
|-----------:|-------------:|---------:|
|          1 |          101 |      500 |
|          2 |          102 |      300 |
|          3 |          101 |      700 |


Products :
|   product_id | product_name   |
|-------------:|:---------------|
|          101 | Laptop         |
|          102 | Phone          |


Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

Ans:- Here's the SQL query to find the total sales amount for each product using an INNER JOIN and the SUM() function: 📊💰*/


SELECT
    p.product_name,        -- 🏷️ Select the product name
    SUM(s.amount) AS total_sales_amount -- 💲 Calculate the sum of sales for each product
FROM
    Sales s                 -- 📈 From the Sales table (aliased as 's')
INNER JOIN
    Products p ON s.product_id = p.product_id -- 🤝 Join with the Products table (aliased as 'p')
GROUP BY
    p.product_name          --  grouping by product name
ORDER BY
    total_sales_amount DESC; -- sort in descending order
     
/*Explanation 🧐

1.SELECT .product_name, SUM(s.amount) AS total_sales_amount:

We select the product_name from the Products table (aliased as p) because we want to see the total sales for each named product.

SUM(s.amount) calculates the total of the amount column from the Sales table (aliased as s).

AS total_sales_amount gives this calculated sum a descriptive name in the result.

2.FROM Sales s:

We start by specifying the Sales table as our primary table, giving it a short alias s.
3.INNER JOIN Products p ON s.product_id = p.product_id:

An INNER JOIN combines rows from Sales and Products where there's a match in the product_id column in both tables. This ensures that only sales records that correspond to an existing product are considered.

Products p refers to the Products table with the alias p.

ON s.product_id = p.product_id is the join condition, linking sales records to their respective product details.

4.GROUP BY p.product_name:

After joining, the GROUP BY clause is essential. It groups all the rows with the same product_name together. The SUM() function then calculates the total amount for each of these distinct product groups.
5.ORDER BY total_sales_amount DESC:

This optional clause sorts the results, showing products with higher total sales first. 🏆
10. You are given three tables:


import pandas as pd
import numpy as np

orders_data = {'order_id': [1, 2],
               'order_date': ['2024-01-02', '2024-01-05'],
               'customer_id': [1,2]}
orders_df = pd.DataFrame(orders_data)
print("Orders Table:")
print(orders_df.to_markdown(index=False))
print("\n")
print("\n")


Customers_data = {'customer_id':[101,102],
                  'customer_name':['Alice', 'Bob']}
Customers_df = pd.DataFrame(Customers_data)
print('Customers Table:')
print(Customers_df.to_markdown(index=False))
print("\n")
print("\n")

Order_details={
    'order_id':[1,1,2],
    'product_id':[101,102,101],
    'quantity':[2,1,3]
}
Order_details=pd.DataFrame(Order_details)
print("Oder_Details :")
print(Order_details.to_markdown(index=False))

     
Orders Table:
|   order_id | order_date   |   customer_id |
|-----------:|:-------------|--------------:|
|          1 | 2024-01-02   |             1 |
|          2 | 2024-01-05   |             2 |




Customers Table:
|   customer_id | customer_name   |
|--------------:|:----------------|
|           101 | Alice           |
|           102 | Bob             |




Oder_Details :
|   order_id |   product_id |   quantity |
|-----------:|-------------:|-----------:|
|          1 |          101 |          2 |
|          1 |          102 |          1 |
|          2 |          101 |          3 |
Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables.

Note - The above-mentioned questions don't require any dataset

Ans:- Here's the SQL query to display the order_id, customer_name, and the quantity of products ordered by each customer, 
using INNER JOIN across all three tables: 🛒🧑‍🤝‍🧑📦*/


SELECT
    o.order_id,         -- 📦 The ID of the order
    c.customer_name,    -- 👤 The name of the customer
    od.quantity         -- #️⃣ The quantity of products in that order detail
FROM
    Orders o            -- Start with the Orders table (aliased as 'o')
INNER JOIN
    Customers c ON o.customer_id = c.customer_id -- 🤝 Link Orders to Customers by customer_id
INNER JOIN
    Oder_Details od ON o.order_id = od.order_id; -- 🔗 Link Orders to Order_Details by order_id
     
/*Explanation 📝

1.SELECT o.order_id, c.customer_name, od.quantity:

This specifies the columns we want in our final result. We're getting the order_id from the Orders table (o), the customer_name from the Customers table (c), and the quantity from the Oder_Details table (od).
2.FROM Orders o:

We begin our query from the Orders table, giving it a shorthand alias o for brevity.
3.INNER JOIN Customers c ON o.customer_id = c.customer_id:

The first INNER JOIN connects the Orders table with the Customers table.

The ON o.customer_id = c.customer_id condition ensures that only orders that have a matching customer_id in the Customers table are included. This links each order to the specific customer who placed it.

4.INNER JOIN Oder_Details od ON o.order_id = od.order_id:

The second INNER JOIN then connects the result of the previous join with the Oder_Details table.

The ON o.order_id = od.order_id condition matches the orders with their specific product details (which include the quantity). This step ensures that for each order, we can see the individual products ordered and their respective quantities.

By chaining these INNER JOIN operations, we effectively bring together relevant information from all three tables, providing a comprehensive view of customer orders and product quantities. 👍

SQL Commands
1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences

Ans:- Maven Movies Database Keys 🔑

The Maven Movies database uses a combination of primary and foreign keys to define relationships between its tables and maintain data integrity.

Primary Keys (PK)

A primary key is a column or a set of columns that uniquely identifies each row in a table. It's like a unique ID card for every record. It must contain unique values and cannot be NULL.

actor table: actor_id

address table: address_id

category table: category_id

city table: city_id

Foreign Keys (FK)

A foreign key is a column or a set of columns in one table that references the primary key of another table. Its purpose is to link tables and enforce referential integrity 🔗. This ensures that the data in the foreign key column always corresponds to a valid record in the primary key table.

address table: city_id (refers to city.city_id)

city table: country_id (refers to country.country_id)

customer table: store_id (refers to store.store_id), address_id (refers to address.address_id)

film table: language_id (refers to language.language_id), original_language_id (refers to language.language_id)

2- List all details of actors

Here's the query to list all details of actors from the actor table. 🎬✨*/


SELECT
    * -- 📝 The asterisk selects all columns
FROM
    actor; -- 🎭 From the actor table
     
/*3 -List all customer information from DB

Ans:- Here's the query to list all customer information from the customer table. 🧑‍🤝‍🧑✨*/


SELECT
    * -- 📝 The asterisk selects all columns
FROM
    customer; -- 🧑‍🤝‍🧑 From the customer table
     
/*4 -List different countries.

Ans:-To get a list of all different countries from the Maven Movies database, you'll need to query the country table. 🗺️

Here's the SQL query:*/


SELECT
    country -- 🗺️ Select the country name
FROM
    country; -- 🌎 From the country table
     
/*5 -Display all active customers

Ans:- To display all active customers, you'll need to query the customer table and filter the results where the active column is set to 1 (or True, depending on the data type). 🟢

Here's the SQL query:*/


SELECT
    * -- 📝 Select all columns
FROM
    customer -- 🧑‍🤝‍🧑 From the customer table
WHERE
    active = 1; -- ✅ Where the customer is active
     
/*6 -List of all rental IDs for customer with ID 1.

Ans:- To get all rental IDs for a customer with ID 1, you'll need to query the rental table and filter by customer_id. 🎬

Here is the SQL query:*/


SELECT
    rental_id -- 🔑 Select the rental ID
FROM
    rental -- 📦 From the rental table
WHERE
    customer_id = 1; -- 🧑‍🤝‍🧑 For customer with ID 1
     
/*7 - Display all the films whose rental duration is greater than 5 .

Ans:- To display all films with a rental duration greater than 5, you'll need to query the film table and use a WHERE clause to filter the results. 🎞️

Here is the SQL query:*/


SELECT
    * -- 📝 Select all columns to see full film details
FROM
    film -- 🎥 From the film table
WHERE
    rental_duration > 5; -- ⏳ Filter for films with rental duration greater than 5
     
/*8 - List the total number of films whose replacement cost is greater than 
20.

Ans:- To find the total number of films whose replacement cost is greater than 
20, you'll need to use the COUNT() function with a WHERE clause that includes a range. 💰🎬

Here is the SQL query:*/


SELECT
    COUNT(*) -- 🔢 Count all films that meet the criteria
FROM
    film -- 🎥 From the film table
WHERE
    replacement_cost > 15 AND replacement_cost < 20; -- 💲 Filter for the specified cost range
     
/*9 - Display the count of unique first names of actors.

Ans:- To count the number of unique first names of actors, you'll need to use the COUNT() function with the DISTINCT keyword on the first_name column in the actor table. 📝

Here is the SQL query:*/


SELECT
    COUNT(DISTINCT first_name) AS unique_first_names_count -- 🔢 Count unique first names
FROM
    actor; -- 🎭 From the actor table
     
-- 10- Display the first 10 records from the customer table .

-- Ans:- To display the first 10 records from the customer table, you can use the LIMIT clause in your SQL query. 🔟

-- **Here's the SQL query: **


SELECT
    * -- 📝 Select all columns
FROM
    customer -- 🧑‍🤝‍🧑 From the customer table
LIMIT 10; -- ➡️ Limit the result to the first 10 records
     
/*11 - Display the first 3 records from the customer table whose first name starts with ‘b’.

Ans:-To display the first 3 records from the customer table where the first name starts with ‘b’, you can use the WHERE clause with the LIKE operator and a LIMIT clause. 🅱️

Here is the SQL query:*/


SELECT
    * -- 📝 Select all columns
FROM
    customer -- 🧑‍🤝‍🧑 From the customer table
WHERE
    first_name LIKE 'B%' -- 🔍 Filter for first names that start with 'B'
LIMIT 3; -- ➡️ Limit the result to the first 3 records
     
/*12 -Display the names of the first 5 movies which are rated as ‘G’.

Ans:- Here's the SQL query to display the names of the first 5 movies with a 'G' rating. 🎬🌟*/


SELECT
    title -- 🎥 Select the movie title
FROM
    film -- 🎞️ From the film table
WHERE
    rating = 'G' -- 👶 Filter for movies with a 'G' rating
LIMIT 5; -- 🔟 Limit the result to the first 5 movies
     
/*13-Find all customers whose first name starts with "a".

Ans:- To find all customers whose first name starts with "a", you can use the LIKE operator with a wildcard character. 🔍

Here is the SQL query:*/


SELECT
    * -- 📝 Select all customer details
FROM
    customer -- 🧑‍🤝‍🧑 From the customer table
WHERE
    first_name LIKE 'A%'; -- 🅰️ Filter for names that begin with 'A'
     
/*14- Find all customers whose first name ends with "a".

Ans:- To find all customers whose first name ends with "a", you can use the LIKE operator with a wildcard character. 🔍

Here is the SQL query:*/


SELECT
    * -- 📝 Select all customer details
FROM
    customer -- 🧑‍🤝‍🧑 From the customer table
WHERE
    first_name LIKE '%a'; -- 🅰️ Filter for names that end with 'a'
     
/*15- Display the list of first 4 cities which start and end with ‘a’ .

Ans:- To display the first 4 cities that start and end with 'a', you can use the LIKE operator with a wildcard character and a LIMIT clause. 🏙️

Here is the SQL query:*/


SELECT
    city -- 🌆 Select the city name
FROM
    city -- 🗺️ From the city table
WHERE
    city LIKE 'a%a' -- 🔍 Filter for cities that start and end with 'a'
LIMIT 4; -- ➡️ Limit the result to the first 4 cities
     
/*16- Find all customers whose first name have "NI" in any position.

Ans:- To find all customers whose first name contains "NI" in any position, you'll use the LIKE operator with wildcard characters on both sides of the string. 🔍

Here is the SQL query:*/

SELECT  * -- 📝 Select all customer details FROM customer -- 🧑‍🤝‍🧑 From the customer table WHERE first_name LIKE '%NI%'; -- 🔍 Filter for names containing 'NI' anywhere

/*17- Find all customers whose first name have "r" in the second position .

Ans:- To find all customers whose first name has an "r" in the second position, you'll use the LIKE operator with the underscore _ and percentage % wildcards. 🔍

Here is the SQL query:*/


SELECT
    * -- 📝 Select all customer details
FROM
    customer -- 🧑‍🤝‍🧑 From the customer table
WHERE
    first_name LIKE '_r%'; -- 🔍 Filter for names with 'r' in the second position
     
/*18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.

Ans:- To find all customers whose first name starts with "a" and has at least 5 characters, you can use the LIKE operator with the _ (underscore) and % (percentage) wildcards. 🔍

Here is the SQL query:*/


SELECT
    * -- 📝 Select all customer details
FROM
    customer -- 🧑‍🤝‍🧑 From the customer table
WHERE
    first_name LIKE 'A____%'; -- 🅰️ Filter for names starting with 'A' and at least 5 characters long
     
/*19- Find all customers whose first name starts with "a" and ends with "o".

Ans:- To find all customers whose first name starts with "a" and ends with "o", you'll use the LIKE operator with a wildcard pattern. 🔍

Here is the SQL query:*/


SELECT
    * -- 📝 Select all customer details
FROM
    customer -- 🧑‍🤝‍🧑 From the customer table
WHERE
    first_name LIKE 'A%o'; -- 🅰️ Filter for names that begin with 'A' and end with 'o'
     
/*20 - Get the films with pg and pg-13 rating using IN operator.

Ans:- To get the films with a rating of 'PG' or 'PG-13', you can use the IN operator. It's a clean way to check for multiple values in a single column without writing multiple OR conditions. 🎬

Here's the SQL query:*/


SELECT
    * -- 📝 Select all film details
FROM
    film -- 🎞️ From the film table
WHERE
    rating IN ('PG', 'PG-13'); -- 📋 Filter for films with a 'PG' or 'PG-13' rating
     
/*21 - Get the films with length between 50 to 100 using between operator.

Ans:- To get the films with a length between 50 and 100 minutes (inclusive), you can use the BETWEEN operator. 🎞️⏱️

Here is the SQL query:*/


SELECT
    * -- 📝 Select all film details
FROM
    film -- 🎥 From the film table
WHERE
    length BETWEEN 50 AND 100; -- 📏 Filter for films with a length between 50 and 100 minutes
     
/*22 - Get the top 50 actors using limit operator.

Ans:- To get the top 50 actors, you can use the LIMIT operator. It's a simple way to restrict the number of rows returned by your query. 🎭🌟

Here's the SQL query:*/


SELECT
    * -- 📝 Select all columns for the actors
FROM
    actor -- 🧑‍🤝‍🧑 From the actor table
LIMIT 50; -- ➡️ Limit the result to the first 50 records
     
/*23 - Get the distinct film ids from inventory table.

Ans:- To get the distinct film IDs from the inventory table, you should use the DISTINCT keyword on the film_id column. 🎞️

Here's the SQL query:*/


SELECT DISTINCT
    film_id -- 🎬 Select only unique film IDs
FROM
    inventory; -- 📦 From the inventory table
     
/*Functions
Question 1: Retrieve the total number of rentals made in the Sakila database.

Hint: Use the COUNT() function.

Ans:-*/


SELECT COUNT(*) FROM rental;
     
/*2.Find the average rental duration (in days) of movies rented from the Sakila database.

Hint: Utilize the AVG() function.

Ans:- To find the average rental duration of movies, you need to use the film table, as it contains the rental_duration column. The AVG() function will calculate the average for you. ⏱️

Here's the SQL query:*/


SELECT
    AVG(rental_duration)
FROM
    film;
     
/*3.Display the first name and last name of customers in uppercase.

Hint: Use the UPPER () function.

Ans:- To display the first and last names of customers in uppercase, you'll use the UPPER() function in your query on the customer table. 🗣️

Here's the SQL query:*/


SELECT
    UPPER(first_name),
    UPPER(last_name)
FROM
    customer;
     
/*4.Extract the month from the rental date and display it alongside the rental ID.

Hint: Employ the MONTH() function.

Ans:- To extract the month from the rental date and display it alongside the rental ID, you'll need to query the rental table and use the MONTH() function. 🗓️

Here is the SQL query:*/


SELECT
    rental_id,
    MONTH(rental_date) AS rental_month
FROM
    rental;
     
/*5.Retrieve the count of rentals for each customer (display customer ID and the count of rentals).

Hint: Use COUNT () in conjunction with GROUP BY.

Ans:- To retrieve the count of rentals for each customer, you'll need to join the customer table with the rental table. However, since the user is only asking for the count of rentals per customer ID, a simple aggregation on the rental table is sufficient.

Here's the SQL query: 🧑‍🤝‍🧑🎬*/


SELECT
    customer_id,        -- 🔑 Select the customer ID
    COUNT(rental_id) AS rental_count -- 🔢 Count the number of rentals for each customer
FROM
    rental              -- 📦 From the rental table
GROUP BY
    customer_id;        -- 🧑‍🤝‍🧑 Group the results by customer ID
     
/*6.Find the total revenue generated by each store. Hint: Combine SUM() and GROUP BY

Ans:- To find the total revenue generated by each store, you'll need to join the payment and store tables. Then, you'll use the SUM() function on the amount column and group the results by store_id. 💰🛍️

Here is the SQL query:*/


SELECT
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM
    store s
JOIN
    staff st ON s.manager_staff_id = st.staff_id
JOIN
    payment p ON st.store_id = p.store_id
GROUP BY
    s.store_id;
     
/*7.Determine the total number of rentals for each category of movies.

Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY

Ans:- To determine the total number of rentals for each movie category, you'll need to join three tables: film_category, inventory, and rental. 🎬📊

Here is the SQL query to accomplish this*/


SELECT
    c.name AS category_name,       -- 🏷️ Select the category name
    COUNT(r.rental_id) AS rental_count -- 🔢 Count the number of rentals for each category
FROM
    category c                     -- From the category table (aliased as 'c')
INNER JOIN
    film_category fc ON c.category_id = fc.category_id -- 🤝 Link categories to films
INNER JOIN
    inventory i ON fc.film_id = i.film_id             -- 🔗 Link films to inventory
INNER JOIN
    rental r ON i.inventory_id = r.inventory_id         -- 📦 Link inventory to rentals
GROUP BY
    c.name                         -- 🗂️ Group the results by category name
ORDER BY
    rental_count DESC;             -- 🔽 Sort by the count of rentals in descending order
     
/*8.Find the average rental rate of movies in each language.

Hint: JOIN film and language tables, then use AVG () and GROUP BY.

Ans:- To find the average rental rate of movies in each language, you'll need to join the film and language tables. 🗣️🎬 You'll then use the AVG() function on the rental_rate column and group the results by the language name.

Here is the SQL query:*/


SELECT
    l.name AS language,         -- 🗣️ Select the language name
    AVG(f.rental_rate) AS average_rental_rate -- 💲 Calculate the average rental rate for each language
FROM
    film f                     -- From the film table (aliased as 'f')
INNER JOIN
    language l ON f.language_id = l.language_id -- 🤝 Join with the language table (aliased as 'l')
GROUP BY
    l.name;                     -- 🗂️ Group the results by language
     
/* 9.Display the title of the movie, customer s first name, and last name who rented it.

Hint: Use JOIN between the film, inventory, rental, and customer tables.

Ans:- To display the movie title along with the first and last names of the customer who rented it, you'll need to join four tables: film, inventory, rental, and customer. 🎥🧑‍🤝‍🧑

Here is the SQL query:*/


SELECT
    f.title AS movie_title,      -- 🎥 Select the movie title
    c.first_name,                -- 👤 Select the customer's first name
    c.last_name                  -- 👤 Select the customer's last name
FROM
    film f                       -- Start with the film table (aliased as 'f')
INNER JOIN
    inventory i ON f.film_id = i.film_id -- 🔗 Join film to inventory
INNER JOIN
    rental r ON i.inventory_id = r.inventory_id -- 🤝 Join inventory to rental
INNER JOIN
    customer c ON r.customer_id = c.customer_id -- 🧑‍🤝‍🧑 Join rental to customer
ORDER BY
    f.title;                     -- 🔠 Optional: Sort the results by movie title
     
/* 10.Retrieve the names of all actors who have appeared in the film "Gone with the Wind."

Hint: Use JOIN between the film actor, film, and actor tables.

Ans:-To find the names of all actors who appeared in the film "Gone with the Wind," you need to join the actor, film_actor, and film tables. 🎭🎥

Here's the SQL query:*/


SELECT
    a.first_name,        -- 👤 Select the actor's first name
    a.last_name          -- 👤 Select the actor's last name
FROM
    actor a              -- Start with the actor table (aliased as 'a')
INNER JOIN
    film_actor fa ON a.actor_id = fa.actor_id -- 🤝 Link actors to film_actor table
INNER JOIN
    film f ON fa.film_id = f.film_id          -- 🔗 Link film_actor to the film table
WHERE
    f.title = 'Gone with the Wind'; -- 🔍 Filter for the movie title
     
/* 11.Retrieve the customer names along with the total amount they've spent on rentals.

Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.

Ans:- To retrieve customer names and the total amount they've spent on rentals, you'll need to join the customer and payment tables, as the payment table holds the transaction amounts. Then, you'll use the SUM() function and GROUP BY to aggregate the total spent for each customer. 💸

Here is the SQL query:*/


SELECT
    c.first_name,        -- 👤 Select the customer's first name
    c.last_name,         -- 👤 Select the customer's last name
    SUM(p.amount) AS total_spent -- 💰 Calculate the total amount spent
FROM
    customer c           -- Start with the customer table (aliased as 'c')
INNER JOIN
    payment p ON c.customer_id = p.customer_id -- 🤝 Join with the payment table using customer_id
GROUP BY
    c.customer_id,       -- 🗂️ Group the results by customer ID
    c.first_name,        -- 🗂️ and first name
    c.last_name          -- 🗂️ and last name
ORDER BY
    total_spent DESC;    -- 🔽 Sort by the total amount spent in descending order
     
/* 12.List the titles of movies rented by each customer in a particular city (e.g., 'London').

Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.

Ans:- To get a list of movie titles rented by customers in a specific city, you need to link all the necessary tables. This involves joining customer to address, address to city, customer to rental, rental to inventory, and inventory to film.

Here is the SQL query to accomplish this for customers in 'London': 🏙️🎬*/


SELECT
    f.title AS movie_title,      -- 🎥 Select the movie title
    c.first_name,                -- 👤 The customer's first name
    c.last_name                  -- 👤 The customer's last name
FROM
    customer c                   -- Start with the customer table (aliased as 'c')
INNER JOIN
    address a ON c.address_id = a.address_id    -- 🤝 Link customer to their address
INNER JOIN
    city ci ON a.city_id = ci.city_id           -- 🔗 Link address to the city
INNER JOIN
    rental r ON c.customer_id = r.customer_id    -- 🤝 Link customer to their rentals
INNER JOIN
    inventory i ON r.inventory_id = i.inventory_id  -- 📦 Link rentals to inventory
INNER JOIN
    film f ON i.film_id = f.film_id             -- 🎞️ Link inventory to films
WHERE
    ci.city = 'London'           -- 🔍 Filter for a specific city
GROUP BY
    f.title,                     -- 🗂️ Group the results to avoid duplicates
    c.first_name,
    c.last_name
ORDER BY
    c.last_name, c.first_name, f.title; -- 🔡 Sort for easy reading
     
/*Advanced Joins and GROUP BY:
13.Display the top 5 rented movies along with the number of times they've been rented.

Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.

Ans:- To display the top 5 rented movies and the number of times they've been rented, you'll need to join the film, inventory, and rental tables. 🏆🎬

Here is the SQL query:*/


SELECT
    f.title AS movie_title,          -- 🎥 Select the movie title
    COUNT(r.rental_id) AS rental_count -- 🔢 Count the number of times each movie has been rented
FROM
    film f                           -- Start with the film table (aliased as 'f')
INNER JOIN
    inventory i ON f.film_id = i.film_id -- 🔗 Link films to their inventory copies
INNER JOIN
    rental r ON i.inventory_id = r.inventory_id -- 🤝 Link inventory to rental transactions
GROUP BY
    f.title                          -- 🗂️ Group all rentals for the same movie together
ORDER BY
    rental_count DESC                -- 🔽 Sort the results from most rented to least
LIMIT 5;                             -- 🖐️ Limit the output to the top 5
     
/* 14.Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.

Ans:- To find the customers who have rented movies from both stores, you'll need to join the customer, rental, and inventory tables. Then you'll group the results by customer and use a HAVING clause to filter for customers who have rentals from both distinct store IDs. 🏢🏢

Here's the SQL query: 🧑‍🤝‍🧑🎥*/


SELECT
    c.first_name,         -- 👤 Select the customer's first name
    c.last_name,          -- 👤 Select the customer's last name
    COUNT(DISTINCT i.store_id) AS store_count -- 🔢 Count the unique stores they rented from
FROM
    customer c            -- Start with the customer table (aliased as 'c')
INNER JOIN
    rental r ON c.customer_id = r.customer_id -- 🤝 Link customers to their rentals
INNER JOIN
    inventory i ON r.inventory_id = i.inventory_id -- 🔗 Link rentals to the inventory to get the store ID
GROUP BY
    c.customer_id,        -- 🗂️ Group the results for each customer
    c.first_name,
    c.last_name
HAVING
    COUNT(DISTINCT i.store_id) = 2; -- 🔍 Filter for customers who have rented from exactly 2 distinct stores
     
/* Windows Function:
1. Rank the customers based on the total amount they've spent on rentals.

Ans:- To rank customers based on their total spending, you can use the SUM() function on the payment table and then rank the results using a window function like RANK(). 🏆

Here is the SQL query:*/


SELECT
    c.customer_id,                     -- 🔑 Select the customer's ID
    c.first_name,                      -- 👤 Select the customer's first name
    c.last_name,                       -- 👤 Select the customer's last name
    SUM(p.amount) AS total_spent,      -- 💰 Calculate the total amount spent by each customer
    RANK() OVER (ORDER BY SUM(p.amount) DESC) as customer_rank -- 🥇 Rank customers by total spending
FROM
    customer c                         -- Start with the customer table (aliased as 'c')
JOIN
    payment p ON c.customer_id = p.customer_id -- 🤝 Join with the payment table
GROUP BY
    c.customer_id, c.first_name, c.last_name -- 🗂️ Group results for each unique customer
ORDER BY
    customer_rank ASC;                 -- 🔝 Display the highest-ranking customers first
     
/*2. Calculate the cumulative revenue generated by each film over time.

Ans:- To calculate the cumulative revenue for each film over time, you can use a window function with an OVER clause. This allows you to perform an aggregate calculation (SUM in this case) across a set of table rows that are related to the current row. 📈

Here is the SQL query:*/


SELECT
    f.title,                           -- 🎥 The title of the movie
    p.payment_date,                    -- 📅 The date of the payment
    p.amount,                          -- 💲 The amount of the individual payment
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue -- 💰 Calculate the cumulative revenue
FROM
    payment p                          -- Start with the payment table (aliased as 'p')
JOIN
    rental r ON p.rental_id = r.rental_id  -- 🤝 Join payments to rentals
JOIN
    inventory i ON r.inventory_id = i.inventory_id -- 🔗 Join rentals to inventory
JOIN
    film f ON i.film_id = f.film_id      -- 🎞️ Join inventory to films
ORDER BY
    f.title,                           -- 🔠 Sort by movie title
    p.payment_date;                    -- 🗓️ Then by date to show the progression
     
/*3. Determine the average rental duration for each film, considering films with similar lengths.

Ans:- To determine the average rental duration for each film, grouping them by similar lengths, you can use the NTILE() window function. This function divides the result set into a specified number of ranked groups, allowing you to categorize movies into buckets based on their length. 🎬📏

Here's the SQL query:*/


WITH FilmLengthGroups AS (
    SELECT
        title,
        length,
        rental_duration,
        NTILE(4) OVER (ORDER BY length) AS length_group
    FROM
        film
)
SELECT
    length_group,
    AVG(rental_duration) AS average_rental_duration,
    COUNT(*) AS film_count
FROM
    FilmLengthGroups
GROUP BY
    length_group
ORDER BY
    length_group;
     
/*4. Identify the top 3 films in each category based on their rental counts.

Ans:- To identify the top 3 films in each category based on their rental counts, you can use a combination of JOINs, a GROUP BY clause, and the RANK() window function. This approach first calculates the rental count for each film and then ranks the films within each category. 🥇🎬

Here's the SQL query:*/


WITH FilmRentalCounts AS (
    SELECT
        f.title,
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM
        film f
    JOIN
        inventory i ON f.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    JOIN
        film_category fc ON f.film_id = fc.film_id
    JOIN
        category c ON fc.category_id = c.category_id
    GROUP BY
        f.title, c.name
)
, RankedFilms AS (
    SELECT
        title,
        category_name,
        rental_count,
        RANK() OVER (PARTITION BY category_name ORDER BY rental_count DESC) as category_rank
    FROM
        FilmRentalCounts
)
SELECT
    title,
    category_name,
    rental_count
FROM
    RankedFilms
WHERE
    category_rank <= 3
ORDER BY
    category_name, category_rank;
     
/*5. Calculate the difference in rental counts between each customer's total rentals and the average rentals

across all customers.

Ans:- To calculate the difference between each customer's total rentals and the average rentals across all customers, you'll first need to determine each customer's total rental count and the overall average. Then, you can subtract the average from each customer's total. 🎬📊

Here's the SQL query:*/


WITH CustomerRentalCounts AS (
    SELECT
        customer_id,
        COUNT(rental_id) AS total_rentals_by_customer
    FROM
        rental
    GROUP BY
        customer_id
),
AverageRentals AS (
    SELECT
        AVG(total_rentals_by_customer) AS average_rentals_across_all_customers
    FROM
        CustomerRentalCounts
)
SELECT
    crc.customer_id,
    crc.total_rentals_by_customer,
    ar.average_rentals_across_all_customers,
    crc.total_rentals_by_customer - ar.average_rentals_across_all_customers AS difference_from_average
FROM
    CustomerRentalCounts crc,
    AverageRentals ar
ORDER BY
    difference_from_average DESC;
     
/*6. Find the monthly revenue trend for the entire rental store over time.

Ans:- To find the monthly revenue trend for the entire rental store, you need to calculate the total revenue for each month from the payment table. This can be achieved by using the SUM() function in combination with GROUP BY and a date function to extract the month and year from the payment_date. 📈🗓️

Here's the SQL query:*/


SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS rental_month, -- 📅 Format the date to show year and month
    SUM(amount) AS total_revenue     -- 💰 Calculate the total revenue for each month
FROM
    payment                         -- From the payment table
GROUP BY
    rental_month                    -- 🗂️ Group the results by the formatted month
ORDER BY
    rental_month;                   -- 🔽 Order the results chronologically
     
/*7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

Ans:- To find the customers whose total spending on rentals falls within the top 20% of all customers, you'll need to calculate each customer's total spending, and then use a window function to determine their rank and filter the results. 💸🔝

Here's the SQL query:*/


WITH CustomerTotalSpending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM
        payment
    GROUP BY
        customer_id
),
RankedCustomers AS (
    SELECT
        customer_id,
        total_spent,
        NTILE(5) OVER (ORDER BY total_spent DESC) as spending_quartile -- 5 is used for 20% (100/20=5)
    FROM
        CustomerTotalSpending
)
SELECT
    c.first_name,
    c.last_name,
    rc.total_spent
FROM
    customer c
JOIN
    RankedCustomers rc ON c.customer_id = rc.customer_id
WHERE
    rc.spending_quartile = 1
ORDER BY
    rc.total_spent DESC;
     
/*8. Calculate the running total of rentals per category, ordered by rental count.

Ans:- To calculate the running total of rentals per category, ordered by the rental count, you'll need to use a window function. This function will compute a cumulative sum of rentals within each movie category. 🏃‍♂️🎬

Here is the SQL query:*/


WITH RentalCounts AS (
    SELECT
        c.name AS category,
        COUNT(r.rental_id) AS rental_count
    FROM
        category c
    JOIN
        film_category fc ON c.category_id = fc.category_id
    JOIN
        inventory i ON fc.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name
)
SELECT
    category,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total_of_rentals
FROM
    RentalCounts
ORDER BY
    rental_count DESC;
     
/*9. Find the films that have been rented less than the average rental count for their respective categories.

Ans:- To find the films that have been rented less than the average rental count for their respective categories, you'll need a multi-step query using Common Table Expressions (CTEs) or subqueries. This approach first calculates the rental count for each film and the average rental count for each category, then compares them to identify films that fall below their category's average. 📉🎬

Here is the SQL query:*/


WITH FilmRentalCounts AS (
    -- Step 1: Calculate the rental count for each film.
    SELECT
        f.film_id,
        f.title,
        fc.category_id,
        COUNT(r.rental_id) AS rental_count
    FROM
        film f
    JOIN
        film_category fc ON f.film_id = fc.film_id
    JOIN
        inventory i ON fc.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        f.film_id, f.title, fc.category_id
),
CategoryAverageRentals AS (
    -- Step 2: Calculate the average rental count for each category.
    SELECT
        category_id,
        AVG(rental_count) AS average_rental_count
    FROM
        FilmRentalCounts
    GROUP BY
        category_id
)
-- Step 3: Find films with a rental count less than their category's average.
SELECT
    frc.title,
    frc.rental_count,
    car.average_rental_count
FROM
    FilmRentalCounts frc
JOIN
    CategoryAverageRentals car ON frc.category_id = car.category_id
WHERE
    frc.rental_count < car.average_rental_count
ORDER BY
    frc.rental_count DESC;
     
/* 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

Ans:- To identify the top 5 months with the highest revenue, you need to calculate the total revenue for each month from the payment table. 💸🗓️

Here's the SQL query:*/


SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS rental_month,
    SUM(amount) AS total_revenue
FROM
    payment
GROUP BY
    rental_month
ORDER BY
    total_revenue DESC
LIMIT 5;
     
/*Normalisation & CTE
1.first Normal Form (1NF):

a. Identify a table in the Sakila database that violates 1NF. Explain how you

would normalize it to achieve 1NF.

Ans:- Based on the Sakila database schema provided, the film table violates the First Normal Form (1NF). 🚫

Violation of 1NF A table is in 1NF if all its column values are atomic, meaning they cannot be further broken down into smaller, meaningful parts. The film table has a special_features column with a data type of SET. This column can hold multiple values, such as 'Trailers', 'Commentaries', or 'Deleted Scenes', all within a single field. This makes the column non-atomic, which is a direct violation of 1NF. .

Normalization to 1NF

To normalize the film table to 1NF, you would need to decompose the non-atomic column into a separate table. This involves the following steps:

1.Create a new table called film_special_features to store the atomic values. This table would have:

A primary key (feature_id).

A foreign key (film_id) to link back to the original film table.

A column to hold each individual feature (feature_name).

2.Populate the new table by taking each feature from the film.special_features column and inserting it as a separate row in the new film_special_features table, along with the corresponding film_id.

3.Drop the original special_features column from the film table.

This restructuring ensures that each column in both tables holds a single, atomic value, thus satisfying the requirements of First Normal Form. 💡

2. Second Normal Form (2NF):

a. Choose a table in Sakila and describe how you would determine whether it is in 2NF.

If it violates 2NF, explain the steps to normalize it.

Ans:- To determine if a table is in Second Normal Form (2NF), you first need to confirm that it is already in First Normal Form (1NF). A table is in 2NF if it meets the following two criteria:

It is in 1NF.
All non-key attributes are fully dependent on the entire primary key. This means there are no partial dependencies, where a non-key column depends on only part of a composite primary key.
Let's examine the film_actor table from the Sakila database, as it has a composite primary key.

How to Determine if film_actor is in 2NF
Primary Key: The primary key of the film_actor table is a composite key consisting of two columns: (actor_id, film_id).
Non-Key Attributes: The only other column is last_update.
To check for a 2NF violation, we must ask if the non-key attribute (last_update) is fully dependent on the entire composite primary key. In this case, last_update is a timestamp that is updated whenever a change is made to a record in the film_actor table. It depends on both actor_id and film_id to uniquely identify the record being updated. Therefore, last_update is fully dependent on the entire primary key.

Conclusion: The film_actor table is already in 2NF because it is in 1NF and has no partial dependencies.

Example of a Violation and Normalization
To illustrate a 2NF violation, let's consider a hypothetical scenario with an orders table that stores information about individual items in an order.

Original Table (Not in 2NF):

order_id	product_id	order_date	product_name	product_price
101	A	2023-01-01	Laptop	1200
101	B	2023-01-01	Mouse	50
102	A	2023-01-02	Laptop	1200
Composite Primary Key: (order_id, product_id)
Partial Dependency: The order_date column depends only on order_id, not on the full primary key. Similarly, product_name and product_price depend only on product_id.
To normalize this table to 2NF, you would decompose it into three separate tables:

Orders Table: Contains information that depends only on order_id.

order_id (PK)
order_date
Products Table: Contains information that depends only on product_id.

product_id (PK)
product_name
product_price
Order_Details Table: This is the linking table that holds the composite key and any attributes dependent on the full key (in this simple case, none).

order_id (PK, FK to Orders)
product_id (PK, FK to Products)
This normalization process removes the partial dependencies, ensuring that each piece of data is stored logically and efficiently.

3. Third Normal Form (3NF):

a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies

present and outline the steps to normalize the table to 3NF.

Ans:- A table is in Third Normal Form (3NF) if it is in 2NF and all of its non-key columns are directly dependent on the primary key, with no dependencies on other non-key columns. This type of dependency is known as a transitive dependency. 🔄

Based on the provided Sakila database schema, the actor_award table violates 3NF.

Transitive Dependency in actor_award 🕵️‍♀️
The actor_award table has the following structure:

actor_award_id (Primary Key)
actor_id (Non-key attribute)
first_name (Non-key attribute)
last_name (Non-key attribute)
awards (Non-key attribute)
last_update (Non-key attribute)
Here's the transitive dependency:

The primary key is actor_award_id.
The first_name and last_name columns are non-key attributes.
first_name and last_name are directly dependent on the actor_id (which is itself a non-key attribute), not on the primary key (actor_award_id).
In other words: actor_award_id -> actor_id -> (first_name, last_name)

This chain of dependency, where first_name and last_name are indirectly linked to the primary key through the actor_id, is a clear violation of 3NF.

Steps to Normalize to 3NF 🛠️
To normalize this table to 3NF, we must remove the transitive dependency by placing the dependent columns (first_name and last_name) into a separate table that already exists in the database: the actor table.

Identify the dependency: The columns first_name and last_name are determined by actor_id.
Separate the data: The database already has an actor table with actor_id as its primary key and the first_name and last_name columns. We don't need to create a new table.
Refactor the violating table: We remove the first_name and last_name columns from the actor_award table. The actor_id remains as a foreign key, which is all that's needed to reference the actor's details from the actor table.
After normalization, the actor_award table would look like this:

actor_award_id	actor_id	awards	last_update
PK	FK		
The actor table would continue to store the unique actor details:

actor_id	first_name	last_name	last_update
PK			
This new structure eliminates the transitive dependency and ensures that each non-key attribute in the actor_award table (awards) is directly dependent only on the primary key. ✅

4. Normalization Process:

a. Take a specific table in Sakila and guide through the process of normalizing it from the initial

unnormalized form up to at least 2NF.

Ans:- ### Normalization from Unnormalized Form to 2NF 🛠️

Let's walk through the normalization process using a hypothetical table that combines information from the film, actor, and film_actor tables in an unnormalized state.

1. Unnormalized to First Normal Form (1NF)
An unnormalized table contains columns with repeating groups or non-atomic values.

Hypothetical Unnormalized Table: film_actors_unnormalized

film_id	title	actors
1	ACADEMY DINOSAUR	{"id": 1, "name": "PENELOPE GUINESS"}, {"id": 106, "name": "GARY PHOENIX"}
2	ACE GOLDFINGER	{"id": 3, "name": "ED CHASE"}, {"id": 105, "name": "SIDNEY CROWE"}
This table violates 1NF because the actors column holds multiple, non-atomic values (a list of actor IDs and names).

To achieve 1NF: We must eliminate the repeating groups by placing each actor-film combination on its own separate row.

Normalized to 1NF:

film_id	title	actor_id	actor_name
1	ACADEMY DINOSAUR	1	PENELOPE GUINESS
1	ACADEMY DINOSAUR	106	GARY PHOENIX
2	ACE GOLDFINGER	3	ED CHASE
2	ACE GOLDFINGER	105	SIDNEY CROWE
This new table is now in 1NF as every column contains a single, atomic value. The composite primary key for this table would be (film_id, actor_id).

2. First Normal Form to Second Normal Form (2NF)
A table is in 2NF if it's in 1NF and all non-key attributes are fully dependent on the entire composite primary key. The 1NF table above has two non-key attributes: title and actor_name. Let's check their dependencies on the composite primary key (film_id, actor_id).

title is dependent on film_id, but not on actor_id. Knowing the film_id is enough to know the title. This is a partial dependency. 💔
actor_name is dependent on actor_id, but not on film_id. Knowing the actor_id is enough to know the actor_name. This is another partial dependency. 💔
To achieve 2NF: We must remove these partial dependencies by splitting the table into new tables. The non-key attributes that depend on only part of the key are moved to a new table with that part of the key becoming its primary key. This is exactly how the Sakila database is structured!

Normalized to 2NF (as seen in the Sakila schema):

film Table:

film_id (Primary Key)
title This table stores information that depends solely on the film.
actor Table:

actor_id (Primary Key)
first_name
last_name This table stores information that depends solely on the actor.
film_actor Table (The Junction Table):

film_id (Foreign Key, part of Composite Primary Key)
actor_id (Foreign Key, part of Composite Primary Key) This table links the other two, holding only the composite primary key.
This final structure eliminates all partial dependencies, ensuring that each table is focused on a single topic and adheres to 2NF. ✅

5.CTE Basics:

a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they

have acted in from the actor and film_actor tables.

Ans:- Here's a query using a Common Table Expression (CTE) to get a distinct list of actor names and the number of 
films they've acted in. 🎭🎬*/

WITH ActorFilmCounts AS (
    SELECT
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name, -- Combine first and last names for full actor name
        COUNT(fa.film_id) AS film_count -- Count the number of films each actor has been in
    FROM
        actor a -- Start with the actor table (aliased as 'a')
    JOIN
        film_actor fa ON a.actor_id = fa.actor_id -- Join with film_actor to link actors to films
    GROUP BY
        a.actor_id, actor_name -- Group by actor to count films per actor
)
SELECT
    actor_name, -- Select the actor's full name
    film_count -- Select the count of films they've acted in
FROM
    ActorFilmCounts
ORDER BY
    film_count DESC, actor_name; -- Order by film count (descending) then by actor name
/* Explanation 💡
The query uses a CTE named ActorFilmCounts to first gather and aggregate the necessary data.

ActorFilmCounts CTE:

It joins the actor table (aliased as a) with the film_actor table (aliased as fa) on actor_id. This links each actor to the films they've participated in.
CONCAT(a.first_name, ' ', a.last_name) creates a single column actor_name for the full name.
COUNT(fa.film_id) counts how many film entries exist for each actor.
GROUP BY a.actor_id, actor_name ensures that the count is performed for each unique actor.
Final SELECT Statement:

This selects the actor_name and film_count directly from the ActorFilmCounts CTE.
ORDER BY film_count DESC, actor_name sorts the results to show actors with the most films first, and then alphabetically by name for ties.
6. CTE with Joins:

a. Create a CTE that combines information from the film and language tables to display the film title,

language name, and rental rate.

Ans:- Here's a query using a CTE that combines information from the film and language tables to display the film title, 
language name, and rental rate. 🎥🗣️*/

WITH FilmLanguageDetails AS (
    SELECT
        f.title AS film_title,     -- 🎬 Select the film title
        l.name AS language_name,   -- 🗣️ Select the language name
        f.rental_rate              -- 💲 Select the rental rate
    FROM
        film f                     -- From the film table (aliased as 'f')
    JOIN
        language l ON f.language_id = l.language_id -- 🤝 Join with the language table (aliased as 'l')
)
SELECT
    film_title,
    language_name,
    rental_rate
FROM
    FilmLanguageDetails
ORDER BY
    film_title; -- 🔠 Order the results by film title
/* Explanation 💡
The FilmLanguageDetails CTE is used to first join the film and language tables.

FilmLanguageDetails CTE:

It selects the title from the film table, the name from the language table, and the rental_rate from the film table.
The JOIN condition f.language_id = l.language_id links films to their corresponding language based on the language_id.
Final SELECT Statement:

This simply retrieves all the columns defined in the FilmLanguageDetails CTE.
The ORDER BY film_title clause sorts the final output alphabetically by movie title.
7. CTE for Aggregation:

a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments)

from the customer and payment tables.

Ans:- Here's a query using a CTE to find the total revenue generated by each customer from the customer and payment tables. 💰🧑‍🤝‍🧑*/

WITH CustomerRevenue AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_revenue_spent -- Calculate the sum of payments for each customer
    FROM
        customer c -- From the customer table (aliased as 'c')
    JOIN
        payment p ON c.customer_id = p.customer_id -- Join with the payment table (aliased as 'p')
    GROUP BY
        c.customer_id, c.first_name, c.last_name -- Group by customer to aggregate their total spending
)
SELECT
    customer_id,
    first_name,
    last_name,
    total_revenue_spent
FROM
    CustomerRevenue
ORDER BY
    total_revenue_spent DESC; -- Order by total revenue spent in descending order
/* Explanation 💡
The CustomerRevenue CTE is used to first calculate the total amount each customer has spent.

CustomerRevenue CTE:

It selects the customer_id, first_name, and last_name from the customer table.
It calculates the SUM(p.amount) to get the total revenue for each customer, aliasing it as total_revenue_spent.
The JOIN condition c.customer_id = p.customer_id links customers to their payment records.
GROUP BY c.customer_id, c.first_name, c.last_name ensures that the sum is calculated for each unique customer.
Final SELECT Statement:

This simply retrieves all the columns defined in the CustomerRevenue CTE.
The ORDER BY total_revenue_spent DESC clause sorts the final output to show the highest-spending customers first.
8.CTE with Window Functions:

a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

Ans:- Here's a query using a Common Table Expression (CTE) and a window function to rank films based on their rental duration. 🎬🏆*/

WITH RankedFilmsByDuration AS (
    SELECT
        title,                       -- 🎥 Select the film title
        rental_duration,             -- ⏱️ The film's rental duration in days
        RANK() OVER (ORDER BY rental_duration DESC) as rental_duration_rank -- 🥇 Rank films based on rental duration, from longest to shortest
    FROM
        film                         -- From the film table
)
SELECT
    title,
    rental_duration,
    rental_duration_rank
FROM
    RankedFilmsByDuration
ORDER BY
    rental_duration_rank; -- 🔝 Order the final results by rank
/*Explanation 💡
RankedFilmsByDuration CTE: This creates a temporary result set. It selects each film's title and rental duration. The RANK() OVER (ORDER BY rental_duration DESC) part is the key:

RANK(): This is the window function that assigns a rank to each row.
OVER (ORDER BY rental_duration DESC): This defines the window for ranking. It sorts all films by their rental_duration in descending order, meaning the longest durations get the highest rank (rank 1).
Final SELECT Statement: This simply retrieves the film title, rental duration, and the newly created rank from the CTE, displaying the films in order from the highest to the lowest rank.

9.CTE and Filtering:

a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the

customer table to retrieve additional customer details.

Ans:- Here's a query that uses a CTE to first identify customers who have made more than two rentals and then joins that result with the 
customer table to retrieve their full details. 🧑‍🤝‍🧑✅*/

WITH ActiveCustomers AS (
    SELECT
        customer_id,
        COUNT(rental_id) as rental_count -- Count the number of rentals per customer
    FROM
        rental
    GROUP BY
        customer_id
    HAVING
        COUNT(rental_id) > 2 -- Filter for customers with more than 2 rentals
)
SELECT
    c.first_name,
    c.last_name,
    c.email,
    ac.rental_count
FROM
    customer c
JOIN
    ActiveCustomers ac ON c.customer_id = ac.customer_id
ORDER BY
    ac.rental_count DESC, c.last_name;
/* Explanation 💡
ActiveCustomers CTE: This CTE is the core of the filtering logic.

It groups the records in the rental table by customer_id.
COUNT(rental_id) calculates the total number of rentals for each customer.
The HAVING clause then filters these groups, keeping only the customers who have a COUNT(rental_id) greater than 2.
Final SELECT Statement: This query joins the customer table with the ActiveCustomers CTE.

It selects the customer's first_name, last_name, email, and the rental_count from the CTE.
This allows you to get a full list of details for only the customers who met the condition, without having to nest subqueries or perform complex joins in the main query.
10. CTE for Date Calculations:

a. Write a query using a CTE to find the total number of rentals made each month, considering the

rental_date from the rental table

Ans:- Here's a query using a CTE to find the total number of rentals made each month. 🗓️*/

WITH MonthlyRentals AS (
    SELECT
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month, -- 📅 Extract year and month from rental_date
        COUNT(rental_id) AS total_rentals                  -- 🔢 Count rentals for each month
    FROM
        rental
    GROUP BY
        rental_month                                       -- 🗂️ Group by the extracted month
)
SELECT
    rental_month,
    total_rentals
FROM
    MonthlyRentals
ORDER BY
    rental_month;                                          -- 🔽 Order chronologically
/* Explanation 💡
MonthlyRentals CTE: This CTE calculates the total number of rentals for each distinct month.

DATE_FORMAT(rental_date, '%Y-%m') extracts the year and month from the rental_date and formats it as 'YYYY-MM'. This is crucial for grouping rentals by month across different years.
COUNT(rental_id) counts all the rental IDs for each month.
GROUP BY rental_month aggregates these counts for each unique month-year combination.
Final SELECT Statement: This simply retrieves the rental_month and total_rentals from the MonthlyRentals CTE, ordered chronologically. This provides a clear trend of rental activity over time. 📈

11.CTE and Self-Join:

a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film

together, using the film_actor table.

Ans:- Here's a query using a Common Table Expression (CTE) to generate a report of all pairs of actors who have appeared in the same film 
together. 👯‍♀️🎬*/

WITH ActorFilms AS (
  SELECT
    fa1.film_id,
    fa1.actor_id AS actor_id_1,
    fa2.actor_id AS actor_id_2
  FROM
    film_actor fa1
  JOIN
    film_actor fa2 ON fa1.film_id = fa2.film_id
  WHERE
    fa1.actor_id < fa2.actor_id -- This condition prevents duplicate pairs (e.g., A-B and B-A)
)
SELECT
  a1.first_name AS actor1_first_name,
  a1.last_name AS actor1_last_name,
  a2.first_name AS actor2_first_name,
  a2.last_name AS actor2_last_name,
  COUNT(af.film_id) AS number_of_films
FROM
  ActorFilms af
JOIN
  actor a1 ON af.actor_id_1 = a1.actor_id
JOIN
  actor a2 ON af.actor_id_2 = a2.actor_id
GROUP BY
  actor1_first_name, actor1_last_name, actor2_first_name, actor2_last_name
ORDER BY
  number_of_films DESC, actor1_first_name, actor2_first_name;
/* Explanation 💡
ActorFilms CTE: This CTE uses a self-join on the film_actor table.

The table is joined with itself (fa1 and fa2) on the film_id column. This creates a virtual table where every row represents two actors who appeared in the same film.
WHERE fa1.actor_id < fa2.actor_id is a clever and essential trick. It ensures that each pair of actors is listed only once (e.g., Penelope and Nick, not Nick and Penelope), and it prevents an actor from being paired with themself.
Final SELECT Statement: This query then takes the results from the ActorFilms CTE and joins them with the actor table twice (once for each actor in the pair) to get their first and last names.

COUNT(af.film_id) counts how many films each unique pair has appeared in together.
GROUP BY aggregates the results by the two actors' names.
ORDER BY sorts the results to show the most frequently collaborating pairs at the top.
12.CTE for Recursive Search:

a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager,

considering the reports_to column

Ans:- Based on the provided schema for the staff table, there is no reports_to column that could be used for a recursive 
CTE to find a reporting hierarchy. The staff table schema is as follows:*/

CREATE TABLE staff (
  staff_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  address_id SMALLINT UNSIGNED NOT NULL,
  picture BLOB DEFAULT NULL,
  email VARCHAR(50) DEFAULT NULL,
  store_id TINYINT UNSIGNED NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  username VARCHAR(16) NOT NULL,
  password VARCHAR(40) BINARY DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (staff_id),
  KEY idx_fk_store_id (store_id),
  KEY idx_fk_address_id (address_id),
  CONSTRAINT fk_staff_store FOREIGN KEY (store_id) REFERENCES store (store_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_staff_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
/* The staff table can be related to itself using the manager_staff_id in the store table, which references the staff_id of a manager.
 However, the user is asking for a direct reports_to column on the staff table itself, which doesn't exist in the provided schema.

Therefore, I cannot fulfill the request as written. However, I can explain how a recursive CTE would work if the staff table had a reports_to column, as an educational example. 💡

How a Recursive CTE Would Work (Hypothetical Example) 👩‍🏫
If the staff table had a reports_to column that contained the staff_id of the employee's manager, 
the query to find all employees reporting up to a specific manager would look something like this:*/

WITH RECURSIVE StaffHierarchy AS (
  -- The Anchor Member: Start with the top-level manager
  SELECT
    staff_id,
    first_name,
    last_name,
    reports_to
  FROM
    staff
  WHERE
    staff_id = [manager_id] -- ➡️ Replace with the ID of the manager you want to start with

  UNION ALL

  -- The Recursive Member: Find all employees who report to the anchor member
  SELECT
    e.staff_id,
    e.first_name,
    e.last_name,
    e.reports_to
  FROM
    staff e
  JOIN
    StaffHierarchy sh ON e.reports_to = sh.staff_id -- 🤝 Join on the reports_to column
)
-- The Final SELECT Statement
SELECT
  staff_id,
  first_name,
  last_name
FROM
  StaffHierarchy;
-- Explanation of the Recursive CTE 🧠
/* WITH RECURSIVE StaffHierarchy AS (...): This declares a recursive CTE named StaffHierarchy.
The Anchor Member: The first SELECT statement is the non-recursive part. It establishes the starting point for the recursion, which is the manager with the specified [manager_id].
The UNION ALL Operator: This combines the results of the anchor member with the results of the recursive member.
The Recursive Member: The second SELECT statement is the recursive part. It selects employees (e) whose reports_to value matches the staff_id of the current set of rows in the StaffHierarchy CTE (sh). This process repeats, adding more levels of the hierarchy with each iteration until no new employees are found.
Since the staff table in the provided schema does not have a reports_to column, this specific query cannot be run. However, this 
structure is the correct way to model and query hierarchical data using a recursive CTE in SQL.*/