### Assignment Questions of SQL ###
-- 1. Create a table called employees with the following structure
-- emp_id (integer, should not be NULL and should be a primary key)
-- emp_name (text, should not be NULL)
 -- age (integer, should have a check constraint to ensure the age is at least 18)
 -- email (text, should be unique for each employee)
 -- salary (decimal, with a default value of 30,000).
 -- Write the SQL query to create the above table with all constraints. 
 
 create database assignment;
 use assignment;
 create table employees(emp_id int(10) not null primary key,
 emp_name varchar(50) not null,
 age int(3) check(age >= 18),
 email varchar(60) unique,
 salary decimal(10,2) default 30000);
 
 select * from employees;
 
 -- 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide 
--  examples of common types of constraints.

-- Ans-  Constraints in SQL are rules applied to table columns that ensure the accuracy and reliability of data within a database. 
#  They help maintain data integrity by enforcing certain conditions on the data,
#  By using constraints, databases ensure that only valid, meaningful, and well-structured data is entered into tables, 
#  which helps in maintaining the quality of the data.

#Examples of Common Types of Constraints-
#1.NOT NULL-Ensures a column cannot have NULL values
#2.UNIQUE-Ensures all values in a column are unique
#3.PRIMARY KEY-Uniquely identifies each row in a table
#4.FOREIGN KEY-Enforces referential integrity between tables
#5.CHECK-Ensures values in a column meet a specific condition
#6.DEFAULT-Sets a default value for a column when none is provided


-- 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.

#ans- Not null Ensures that a column cannot have a NULL (empty) value. No primary key not containing NULL values because
#     A primary key is used to uniquely identify each row in a table and ensuring that a column cannot have a Null Vlaue, it must meet two main criteria.


-- 4.Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an 
#example for both adding and removing a constraint.

-- adding constraint
alter table employees
add constraint unique_email unique(email);

-- removing constraint
alter table employees
drop constraint unique_email;

-- 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. 
# Provide an example of an error message that might occur when violating a constraint.
# Ans.
-- insert violates
insert into Employees(emp_id, emp_name) values (1,NULL)
#In this case, if the name column is defined as NOT NULL, it will violates constraints not null.

# insert into Employees (emp_id, email) VALUES (2, 'john@example.com');
# insert into Employees (emp_id, email) VALUES (3, 'john@example.com');
#If the email column is defined as UNIQUE, the second insert will fail because the email 'john@example.com' already exists.

-- update violates

update employees
set age = 15
where emp_id = 1;
#In this scenario check constraint violates due age is under 18.

-- delete violates

delete from employees
where emp_id = 1;
#Deleting records that are linked to other tables may fail due to FOREIGN KEY constraints, preventing orphaned data.


-- 6.You created a products table without constraints as follows:
 CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));
 
 # Now, you realise that
 # The product_id should be a primary key
 # The price should have a default value of 50.00
 
 -- ANS.
 
 alter table products
 add constraint product_id primary key (product_id);
 
 alter table products
 alter column price 
 set default 50.00;
 
 
 -- 7.You have two tables:
 
 
 
 -- 8.
 
 
 
 -- 9. Given the following tables:
-- sales(sale_id,product_id, amount), 
-- products(product_id, product_name)
 
 # Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
 -- ANS>
 select p.product_name, sum(s.amount) as Total sales
 from products as p
 inner join sales as s
 on p.product_id = s.product_id
 group by p.product_name;
 
 -- 10.You are given three tables:
 -- orders(order_id, order_date, customer_id),
 -- customers(customer_id, customer_name)
 -- order_details(order_id, product_id, quantity)
 
 #  Write a query to display the order_id, customer_name, and the quantity of products ordered by each 
# customer using an INNER JOIN between all three tables.

 -- ANS-
 select o.order_id, c.customer_name, od.quantity
 from orders as o
 inner join customers c on o.customer_name =c.customer_name
 inner join order_details od on o.order_id = od.order_id;
 
 
### SQL commands ###
# Note- i do not have mavenmovie dataset so i am using sakila.
-- 1.-Identify the primary keys and foreign keys in sakila db. Discuss the differences
 # ANS.
-- primary
 use sakila;
 SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME 
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE 
    TABLE_SCHEMA = 'sakila' 
      AND CONSTRAINT_NAME IN (
        SELECT CONSTRAINT_NAME 
        FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
        WHERE TABLE_SCHEMA = 'sakila' 
          AND CONSTRAINT_TYPE = 'PRIMARY KEY'
    );
    
    -- foreign key
    
    SELECT 
    TABLE_NAME, 
    COLUMN_NAME, 
    CONSTRAINT_NAME, 
    REFERENCED_TABLE_NAME, 
    REFERENCED_COLUMN_NAME 
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE 
    TABLE_SCHEMA = 'sakila' 
    AND CONSTRAINT_NAME IN (
        SELECT CONSTRAINT_NAME 
        FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
        WHERE TABLE_SCHEMA = 'sakila' 
          AND CONSTRAINT_TYPE = 'FOREIGN KEY'
    );
    
    -- 2- List all details of actor
    #ANS- 
    select * from actor;
    -- 3 -List all customer information from DB.
    
    #ans-
    
    select * from customer;
    
    
    -- 4.List different countries.
    #ans-
    
    select * from country;
    
    
    -- 5.-Display all active customers.
    #Ans-
    select * from customer
    where active =1;
    
    -- 6.List of all rental IDs for customer with ID 1.
    # Ans-
    select rental_id from rental
    where customer_id =1;
    
    
    -- 7.- Display all the films whose rental duration is greater than 5.
    #Ans- 
    select * from film
    where rental_duration > 5;
    
    -- 8.List the total number of films whose replacement cost is greater than $15 and less than $20.
    # ANS-
    
    select * from film
    where replacement_cost between 15 and 20;
    
    
    -- 9. Display the count of unique first names of actors.
    #Ans-
    select count(distinct first_name) unique_firstname from actor;
    
    -- 10.Display the first 10 records from the customer table.
    #Ans-
    select  * from customer
    limit 10;
    
    -- 11. Display the first 3 records from the customer table whose first name starts with ‘b’.
    # Ans- 
    select * from customer
    where first_name like 'b%'
    limit 3;
    
    --  12.Display the names of the first 5 movies(film) which are rated as ‘G’.
    # Ans- 
    select * from film
    where rating = 'G';
    
    -- 13.Find all customers whose first name starts with "a".
    #ANS-
    select * from customer
    where first_name like "a%";
    
    -- 14. Find all customers whose first name ends with "a".
    #ANS-
    select * from customer
    where first_name like "%a";
    
    -- 15.Display the list of first 4 cities which start and end with ‘a’ .
    #ANS-
    select * from city
    where city like "a%a"
    limit 4;
    
    -- 16.Find all customers whose first name have "NI" in any position
    #Ans-
    select * from customer
    where first_name like "%NI%";
    
    -- 17.Find all customers whose first name have "r" in the second position .
    #Ans-
    
    select * from customer
    where first_name like "_r%";
    
    -- 18. Find all customers whose first name starts with "a" and are at least 5 characters in length.
    select * from customer
    where first_name like "a%" and length(first_name) > 5;
    
    -- 19.Find all customers whose first name starts with "a" and ends with "o".
    # Ans-
    
    select * from customer
    where first_name like "a%o";
    
    
    -- 20.Get the films with pg and pg-13 rating using IN operator.
    # Ans-
    select * from film
    where rating in ('PG', 'PG-13');
    
    -- 21. Get the films with length between 50 to 100 using between operator.
    #Ans-
    select * from film
    where length between 50 and 100;
    
    -- 22.Get the top 50 actors using limit operator.
    #Ans-
    select * from actor
    limit 50;
    
    -- 23.Get the distinct film ids from inventory table.
    #Ans-
    select distinct film_id from inventory;
    
    
    
    ### functions  ###
    
    # Basic Aggregate Functions:
    --  Question 1:
 #Retrieve the total number of rentals made in the Sakila database.
 #Hint: Use the COUNT() function.
    -- ANS-
    
    use sakila;
    select count(rental_id) as total_num_of_rental from rental;
    
    
    
    --  Question 2:
 #Find the average rental duration (in days) of movies rented from the Sakila database.
 #Hint: Utilize the AVG() function
 
   -- Ans
   
   select avg(rental_duration) as avg_rental_duration from film;
   
   
   ##  String Functions:  ##
   
     -- Question 3:
 #Display the first name and last name of customers in uppercase.
 #Hint: Use the UPPER () function.
     -- Ans
     
 select upper(first_name), upper(last_name) from customer;
 
    -- Question 4:
 #Extract the month from the rental date and display it alongside the rental ID.
 #Hint: Employ the MONTH() function.
 
 # Ans-
 select rental_id, month(rental_date) as rental_month
 from rental;
 
 ## GROUP BY: ##
 
   -- Question 5:
 # Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
 # Hint: Use COUNT () in conjunction with GROUP BY.
 
   -- Ans-
   select customer_id, count(rental_id) from rental
   group by customer_id;
   
   
  -- Question 6:
 #Find the total revenue generated by each store.
 #Hint: Combine SUM() and GROUP BY.
 
 -- Ans-
 
 select s.store_id, sum(p.amount) as total_revenue
 from store s
 join inventory i on s.store_id = i.store_id
 join rental r on i.inventory_id = r.inventory_id
 join payment p on r.rental_id = p.rental_id
 group by s.store_id;
 
 
  -- Question 7:
 #Determine the total number of rentals for each category of movies.
 #Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
 
   -- Ans
   
    SELECT fc.category_id, c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM film_category fc
JOIN film f ON fc.film_id = f.film_id
JOIN rental r ON f.film_id = r.inventory_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY fc.category_id, c.name;
   
   --  Question 8:
 #Find the average rental rate of movies in each language.
 #Hint: JOIN film and language tables, then use AVG () and GROUP BY
 
  -- Ans-

select l.language_id, l.name as language_name, avg(f.rental_rate) as avg_rental_rate from film f
join language l on f.language_id = l.language_id
group by l.language_id, language_name;


### joins ###
   -- Questions 9 -
 #Display the title of the movie, customer s first name, and last name who rented it.
 #Hint: Use JOIN between the film, inventory, rental, and customer tables.

--  ANS-
use sakila;
select f.title rentalas movie_title , c.first_name as Customer_first_name , c.last_name as customer_last_name from rental r
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join customer c on r.customer_id = c.customer_id;customer



  -- Question 10:
 #Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
 #Hint: Use JOIN between the film actor, film, and actor tables
 
   -- Ans-
   
   SELECT a.first_name, a.last_name
   FROM actor a
   JOIN film_actor fa ON a.actor_id = fa.actor_id
   JOIN film f ON fa.film_id = f.film_id
   WHERE f.title = 'Gone with the Wind';
   
   
     -- Question 11:
 #Retrieve the customer names along with the total amount they've spent on rentals.
 #Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
 
  -- ANS-
  
  select c.first_name, c.last_name , sum(p.amount) as total_amount_spent from customer c
  join rental r on c.customer_id = r.customer_id
  join payment p on r.rental_id = p.rental_id
  group by c.customer_id, c.first_name, c.last_name;


  -- Question 12:
 # List the titles of movies rented by each customer in a particular city (e.g., 'London').
 # Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
 
 -- Ans-
 

 
 SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.first_name, c.last_name, f.title;




###  Advanced Joins and GROUP BY ###

  -- Question 13:
 #Display the top 5 rented movies along with the number of times they've been rented.
 #Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
 
 -- Ans-
 select f.title as Movie_title , count(rental_id) as rental_counts
 from film f
 join inventory i on f.film_id = i.film_id
 join rental r on i.inventory_id = r.inventory_id
 group by f.title 
 order by rental_counts desc
 limit 5;
 
 
   --  Question 14:
 #Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
 #Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
 
  -- Ans-
  select c.customer_id,c.first_name, c.last_name from rental r
  join inventory i on r.inventory_id = i.inventory_id
  join customer c on r.customer_id = c.customer_id
  where i.store_id in(1,2)
  group by c.customer_id, c.first_name, c.last_name
  having count(distinct i.store_id) = 2;
  
  
  ###  Windows Function:###
  
  
 --  1. Rank the customers based on the total amount they've spent on rentals.
 -- Ans-
 
 use sakila;
 select c.customer_id,c.first_name,c.last_name,sum(p.amount) as total_amount_spent,
 rank() over(order by sum(p.amount) desc) as RANK_
 from customer c 
 join rental r on c.customer_id = r.customer_id
 join payment p on r.rental_id= p.rental_id
 group by c.customer_id, c.first_name , c.last_name
 order by total_amount_spent desc;
 

 
 --  2. Calculate the cumulative revenue generated by each film over time.
 -- ANS-
 
select f.title, r.rental_date, sum(p.amount) over (partition by f.film_id order by r.rental_date) as cumulative_revenue
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
order by f.title, r.rental_date;


-- 3.Determine the average rental duration for each film, considering films with similar lengths.
-- Ans-


select * from rental;
select f.title, f.length, avg(datediff(r.return_date,r.rental_date)) as avg_rental_duration
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.length, f.title
order by f.length;


-- 4.Identify the top 3 films in each category based on their rental counts.
-- Ans

    SELECT c.name AS category_name, f.title AS film_title, 
        COUNT(r.rental_id) AS rental_count,
        RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rank_
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.name, f.title

-- # 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
-- # Ans-

use sakila;
SELECT customer_id,
       COUNT(rental_id) AS total_rentals,
       AVG(COUNT(rental_id)) OVER () AS avg_rentals,
       (COUNT(rental_id) - AVG(COUNT(rental_id)) OVER ()) AS rental_difference
FROM rental
GROUP BY customer_id;


#6.Find the monthly revenue trend for the entire rental store over time.
-- Ans

SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month_year,
       SUM(amount) AS monthly_revenue
FROM payment
GROUP BY month_year
ORDER BY month_year desc;


#7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
-- Ans-

WITH CustomerSpending AS (
    SELECT customer_id,
           SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
),
RankedSpending AS (
    SELECT customer_id,
           total_spent,
           PERCENT_RANK() OVER (ORDER BY total_spent DESC) AS spending_rank
    FROM CustomerSpending
)
SELECT customer_id, total_spent
FROM RankedSpending
WHERE spending_rank <= 0.2
ORDER BY total_spent DESC;


#8. Calculate the running total of rentals per category, ordered by rental count.
-- Ans

WITH CategoryRentalCounts AS (
    SELECT fc.category_id,
           c.name AS category_name,
           COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY fc.category_id, c.name
)
SELECT category_name,
       rental_count,
       SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total_rentals
FROM CategoryRentalCounts
ORDER BY rental_count DESC;


#9. Find the films that have been rented less than the average rental count for their respective categories.
-- Ans-

SELECT f.title AS film_title,
       c.name AS category_name,
       COUNT(r.rental_id) AS rental_count,
       AVG(COUNT(r.rental_id)) OVER (PARTITION BY fc.category_id) AS avg_rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY f.film_id, f.title, fc.category_id, c.name
HAVING COUNT(r.rental_id) < AVG(COUNT(r.rental_id)) OVER (PARTITION BY fc.category_id)
ORDER BY category_name, rental_count;
    
#10.. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
-- Ans-

SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       SUM(amount) AS total_revenue
FROM payment
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 5;

###   Normalisation & CTE   ###

#1. First Normal Form (1NF):
			# a. Identify a table in the Sakila database that violates 1NF. Explain how you
			# would normalize it to achieve 1NF
            
-- Ans- In the Sakila database, a table that might violate First Normal Form (1NF) is the address table if it
#  hypothetically contained multiple values in a single field. For instance, if the address field had
# multiple addresses listed in a single row, it would violate 1NF.which requires each column to contain only
# atomic (indivisible) values.



#2.. Second Normal Form (2NF):
   -- a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
		# If it violates 2NF, explain the steps to normalize it.
        
        
	-- Ans-The rental table has a single primary key, rental_id. Since there’s no composite primary key in this table,
          #  it inherently satisfies the 2NF requirement—there can’t be any partial dependencies if there’s only one attribute 
          #   in the primary key.
          
          -- steps to normalize
          #1.Identify Partial Dependencies
          #2.Separate into New Tables
          #3.Resulting Tables in 2NF
          
	#3. Third Normal Form (3NF):
    -- a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
         #      present and outline the steps to normalize the table to 3NF.
         
         
	-- Ans- In the Sakila database, the payment table could potentially violate Third Normal Form (3NF) due to a transitive dependency on non-key attributes.
          #payment table includes customer_name and staff_name columns. These columns lead to a transitive dependency on non-primary key attributes.
    
      #Steps to Normalize the payment Table to 3NF
-- 1.Identify Transitive Dependencies
-- 2.Separate Dependent Data
-- 3.Establish Foreign Key Relationships


#4. Normalization Process:
		-- a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.
        
        -- ANS-unnormalized form-City and country information are duplicated and stored with each address.
        #STEPS--1.Step 1: Convert to First Normal Form (1NF)
        #2.Convert to Second Normal Form (2NF)
        #3.Step-by-Step Normalization to 2NF- Create a city Table,Create a country Table,Update the address Table
        
        #Summary of Normalization Changes
#1NF: Ensured atomic values and identified a primary key (address_id).
#2NF: Removed partial dependencies by creating separate city and country tables, reducing redundancy and improving data integrity.


-- 5. CTE Basics: a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
	# have acted in from the actor and film_actor tables
    
    -- ANS-
    WITH ActorFilmCount AS (
    SELECT 
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM 
        actor AS a
    JOIN 
        film_actor AS fa ON a.actor_id = fa.actor_id
    GROUP BY 
        a.actor_id, a.first_name, a.last_name
)
SELECT 
    DISTINCT actor_name,
    film_count
FROM 
    ActorFilmCount
ORDER BY 
    film_count DESC;
        
-- 6.CTE with Joins:
#  a. Create a CTE that combines information from the film and language tables to display the film title, 
     # Language name, and rental rate.
     
     -- ANS-

WITH FilmLanguageInfo AS (
    SELECT 
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM 
        film AS f
    JOIN 
        language AS l ON f.language_id = l.language_id
)
SELECT 
    film_title,
    language_name,
    rental_rate
FROM 
    FilmLanguageInfo
ORDER BY 
    film_title;

-- 6. CTE for Aggregation:
#Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
  #from the customer and payment tables.
  
  -- ANS
  WITH CustomerRevenue AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM 
        customer AS c
    JOIN 
        payment AS p ON c.customer_id = p.customer_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name
)
SELECT 
    customer_id,
    customer_name,
    total_revenue
FROM 
    CustomerRevenue
ORDER BY 
    total_revenue DESC;

-- 7.. CTE with Window Functions:
#a.Utilize a CTE with a window function to rank films based on their rental duration from the film table.

-- Ans-

WITH FilmRankings AS (
    SELECT 
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_duration_rank
    FROM 
        film
)
SELECT 
    title,
    rental_duration,
    rental_duration_rank
FROM 
    FilmRankings
ORDER BY 
    rental_duration_rank;

-- 8. CTE and Filtering:
#a.Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
           # customer table to retrieve additional customer details.
           
           
-- Ans
WITH FrequentRenters AS (
    SELECT 
        customer_id,
        COUNT(rental_id) AS rental_count
    FROM 
        rental
    GROUP BY 
        customer_id
    HAVING 
        COUNT(rental_id) > 2
)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    fr.rental_count
FROM 
    customer AS c
JOIN 
    FrequentRenters AS fr ON c.customer_id = fr.customer_id
ORDER BY 
    fr.rental_count DESC;
    
    
    
    -- 9. CTE for Date Calculations:
    #a. Write a query using a CTE to find the total number of rentals made each month, considering the
       #rental_date from the rental table.
       
       
       -- Ans
       
       WITH MonthlyRentalCount AS (
    SELECT 
        DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM 
        rental
    GROUP BY 
        rental_month
)
SELECT 
    rental_month,
    total_rentals
FROM 
    MonthlyRentalCount
ORDER BY 
    rental_month;


-- 10. CTE and Self-Join:
# a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
#together, using the film_actor table

-- Ans-
WITH ActorPairs AS (
    SELECT 
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        fa1.film_id
    FROM 
        film_actor AS fa1
    JOIN 
        film_actor AS fa2 ON fa1.film_id = fa2.film_id
    WHERE 
        fa1.actor_id < fa2.actor_id
)
SELECT 
    a1.actor_id AS Actor1_ID,
    a2.actor_id AS Actor2_ID,
    ActorPairs.film_id
FROM 
    ActorPairs
JOIN 
    actor AS a1 ON ActorPairs.actor1_id = a1.actor_id
JOIN 
    actor AS a2 ON ActorPairs.actor2_id = a2.actor_id
ORDER BY 
    ActorPairs.film_id, Actor1_ID, Actor2_ID;

-- 11. CTE for Recursive Search:
 #a.Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
#considering the reports_to column

-- Ans-
WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: select the specific manager (starting point)
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM 
        staff
    WHERE 
        staff_id = 1  -- Replace '1' with the specific manager's ID

    UNION ALL

    -- Recursive member: find employees who report to the staff selected in the previous level
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM 
        staff s
    JOIN 
        EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)
-- Final query to get all the employees reporting to the manager
SELECT 
    staff_id,
    first_name,
    last_name,
    reports_to
FROM 
    EmployeeHierarchy
WHERE 
    staff_id != 1  -- Exclude the manager from the results
ORDER BY 
    staff_id;


