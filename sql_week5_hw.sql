-- inner join on the actor and film_actor table
select actor.actor_id, first_name, last_name, film_id
from film_actor 
inner join actor
on actor.actor_id = film_actor.actor_id

-- left join on the actor and film_actor table
select actor.actor_id, first_name, last_name, film_id
from film_actor 
left join actor 
on actor.actor_id = film_actor.actor_id

-- join that will produce info about a customer from the country for Angola
select customer.first_name, customer.last_name, customer.email, country
from customer  
full join address
on customer.address_id = address.address_id 
full join city  on address.city_id = city.city_id 
full join country
on city.country_id = country.country_id where country = 'Angola';

-- subqueries

-- two queries split apart

-- find a customer id that has an amount greater than 175 in total payments
select customer_id
from payment 
group by customer_id 
having sum(amount) > 175
order by sum(amount) desc;

select store_id, first_name, last_name
from customer c
where customer_id in (
	select customer_id 
	from payment 
	group by customer_id 
	having sum(amount) > 175
	order by sum(amount) desc
)


-- basic subquery

select *
from customer
where customer_id in (
	select customer_id 
	from payment 
	group by customer_id
	having sum(amount) > 175
	order by sum(amount) desc
);

-- another basic subquery where all films are in english
-- Find all films with a language of 'English'
SELECT *
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English'
);


-- Homework

-- 1. List all customers who live in Texas (use
-- JOINs)
select customer.first_name, customer.last_name, customer.email, customer.address_id, address.district 
from customer  
full join address
on customer.address_id  = address.address_id
where address.district  = 'Texas';


--2. Get all payments above $6.99 with the Customer's Full
-- Name
select customer.first_name, customer.last_name, payment.payment_id, payment.amount 
from customer  
join payment  on customer.customer_id = payment.customer_id 
where payment.amount > 6.99;

--3. Show all customers names who have made payments over $175(use subqueries)

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (SELECT customer_id 
FROM payment 
WHERE amount > 175);

--4. List all customers that live in Nepal (use the city table)
select customer.first_name, customer.last_name, customer.address_id
from customer  
full join address  
on customer.address_id = address.address_id
full join city on address.city_id = city.city_id 
where city.city = 'Nepal';

--5. Which staff member had the most transactions?
select s.staff_id, s.first_name, s.last_name, COUNT(p.payment_id) as transaction_count
from staff s
join payment p on s.staff_id = p.staff_id
group by s.staff_id, s.first_name, s.last_name
order by transaction_count DESC
limit 1;


--6. How many movies of each rating are there?
select rating, count(*) as film_count
from film f 
group by rating; 

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select c.customer_id, c.first_name, c.last_name
from customer c
where c.customer_id in (
    select p.customer_id
    from payment p
    where p.amount > 6.99
);

--8. How many rentals did our store give away?
select count(*) as free_rentals
from payment p 
join rental r on p.rental_id = r.rental_id 
where p.amount is null or p.amount = 0;



