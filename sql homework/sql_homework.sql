-- 1a. Display the first and last names of all actors from the table actor. 

select first_name,last_name from sakila.actor;


-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name. 

select upper(concat(first_name," ",last_name)) as "Actor Name" from sakila.actor;

-- 2a. You need to find the ID number, first name, and last name of an actor,
 -- of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
 
 select actor_id,first_name,last_name from sakila.actor where upper(first_name) = 'JOE';
 
 
-- 2b. Find all actors whose last name contain the letters GEN:
-- 
select upper(concat(first_name," ",last_name)) as "Actor Name" from sakila.actor where upper(concat(first_name," ",last_name)) like '%GEN%';


-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
-- 
select first_name,last_name from sakila.actor where upper(last_name) like '%LI%' order by last_name,first_name;
-- 
-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
-- 
select * from country where upper(country) in ('AFGHANISTAN','BANGLADESH','CHINA');

-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.

ALTER TABLE sakila.actor ADD middle_name VARCHAR(45) after first_name;

-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.

ALTER TABLE sakila.actor MODIFY COLUMN middle_name BLOB;

-- 3c. Now delete the middle_name column.

ALTER TABLE sakila.actor DROP COLUMN middle_name;


-- 4a. List the last names of actors, as well as how many actors have that last name.

select last_name,count(1) as actor_count from sakila.actor group by last_name order by count(1) desc;


-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

select last_name,count(1) as actor_count from sakila.actor group by last_name having count(1)>=2 order by count(1) desc;


-- 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.

select * from sakila.actor where first_name='GROUCHO' and last_name='WILLIAMS';

update sakila.actor set first_name='HARPO' where first_name='GROUCHO' and last_name='WILLIAMS';

commit;

select * from sakila.actor where first_name='HARPO' and last_name='WILLIAMS';


-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO,
 -- change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error. BE CAREFUL 
 -- NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)
update sakila.actor a
inner join (SELECT IF(first_name='HARPO','GROUCHO','MUCHO GROUCHO') as first_name FROM actor WHERE actor_id=172) b
set a.first_name=b.first_name
where actor_id=172;

 
-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it? 

SHOW CREATE TABLE sakila.address;

CREATE TABLE `address` (
  `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `district` varchar(20) NOT NULL,
  `city_id` smallint(5) unsigned NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `location` geometry NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_id`),
  KEY `idx_fk_city_id` (`city_id`),
  SPATIAL KEY `idx_location` (`location`),
  CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8 


-- Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html
-- 
-- 
-- 
-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:

select a.first_name,a.last_name,b.address,b.address2,b.district,b.city_id,b.postal_code from sakila.staff a inner join sakila.address b where a.address_id=b.address_id ;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment. 

SELECT s.staff_id,sum(p.amount) total_amount
FROM sakila.staff s
		INNER JOIN sakila.payment p
WHERE s.staff_id=p.staff_id;
GROUP BY s.staff_id



-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

SELECT f.film_id,title,count(actor_id) num_of_actors
FROM sakila.film f
		INNER JOIN sakila.film_actor fa
WHERE f.film_id=fa.film_id
GROUP BY f.film_id,title;



-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT count(inventory_id)
FROM sakila.inventory i
		INNER JOIN sakila.film f
WHERE i.film_id=f.film_id
	AND f.title = 'HUNCHBACK IMPOSSIBLE' ;



-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:

SELECT c.first_name,c.last_name,sum(p.amount) total_paid
FROM sakila.customer c
		INNER JOIN sakila.payment p
WHERE c.customer_id = p.customer_id
GROUP BY c.customer_id
order by last_name;

-- 
-- 
    -- ![Total amount paid](Images/total_payment.png)
-- 
-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English. 

SELECT title,language_id
FROM sakila.film
WHERE (title like 'K%'
	OR title like 'Q%')
	AND language_id = (
SELECT language_id
FROM sakila.language
WHERE upper(name) = 'ENGLISH');

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.

SELECT first_name,last_name
FROM sakila.actor
WHERE actor_id IN (
SELECT actor_id
FROM sakila.film_actor
WHERE film_id = (
SELECT film_id
FROM sakila.film
WHERE upper(title)='ALONE TRIP')) ;

SELECT first_name,last_name
FROM sakila.actor
WHERE actor_id IN (
SELECT actor_id
FROM sakila.film_actor fa
		INNER JOIN sakila.film f
WHERE f.film_id=fa.film_id
	AND upper(f.title)='ALONE TRIP') ;


-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.

SELECT c.first_name,c.last_name,c.email,cy.country
FROM sakila.customer c
		INNER JOIN sakila.address a
		ON (c.address_id=a.address_id)
		INNER JOIN sakila.city ct
		ON (a.city_id =ct.city_id)
		INNER JOIN sakila.country cy
		ON (ct.country_id = cy.country_id)
WHERE upper(cy.country) = 'CANADA';


-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.

SELECT f.title
FROM sakila.film f
		INNER JOIN sakila.film_category fc
		ON (f.film_id=fc.film_id)
		INNER JOIN sakila.category c
		ON (fc.category_id = c.category_id)
WHERE c.name = 'Family';


-- 7e. Display the most frequently rented movies in descending order.

SELECT title,count(1) rented
FROM sakila.film f
		INNER JOIN sakila.inventory i
		ON (f.film_id=i.film_id)
		INNER JOIN sakila.rental r
		ON (i.inventory_id=r.inventory_id)
GROUP BY title
ORDER BY count(1) desc;


-- 7f. Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id,sum(p.amount) bus_in_dollars
FROM sakila.store s
		INNER JOIN sakila.inventory i
		ON (s.store_id=i.store_id)
		INNER JOIN sakila.rental r
		ON (i.inventory_id = r.inventory_id)
		INNER JOIN sakila.payment p
		ON (r.rental_id=p.rental_id)
GROUP BY s.store_id;


-- 7g. Write a query to display for each store its store ID, city, and country.

SELECT s.store_id,c.city,ctry.country
FROM sakila.store s
		INNER JOIN sakila.address a
		ON (s.address_id=a.address_id)
		INNER JOIN sakila.city c
		ON (a.city_id=c.city_id)
		INNER JOIN sakila.country ctry
		ON (c.country_id=ctry.country_id);



-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory,
--payment, and rental.)

SELECT cat.name,sum(p.amount) gross_rev
FROM sakila.category cat
		INNER JOIN sakila.film_category fc
		ON (cat.category_id=fc.category_id)
		INNER JOIN sakila.inventory i
		ON (i.film_id=fc.film_id)
		INNER JOIN sakila.rental r
		ON (i.inventory_id=r.inventory_id)
		INNER JOIN sakila.payment p
		ON (r.rental_id=p.rental_id)
GROUP BY cat.name
ORDER BY sum(p.amount) desc limit 5;


-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view.
-- If you haven't solved 7h, you can substitute another query to create a view.

CREATE VIEW sakila.top5_genres AS SELECT cat.name,sum(p.amount) gross_rev
FROM sakila.category cat
		INNER JOIN sakila.film_category fc
		ON (cat.category_id=fc.category_id)
		INNER JOIN sakila.inventory i
		ON (i.film_id=fc.film_id)
		INNER JOIN sakila.rental r
		ON (i.inventory_id=r.inventory_id)
		INNER JOIN sakila.payment p
		ON (r.rental_id=p.rental_id)
GROUP BY cat.name
ORDER BY sum(p.amount) desc limit 5;

-- 8b. How would you display the view that you created in 8a?

select * from sakila.top5_genres;

show create view sakila.top5_genres;

CREATE ALGORITHM=UNDEFINED DEFINER=`super`@`localhost` SQL SECURITY DEFINER VIEW `sakila`.`top5_genres` AS
SELECT `cat`.`name` AS `name`,sum(`p`.`amount`) AS `gross_rev`
FROM ((((`sakila`.`category` `cat` JOIN `sakila`.`film_category` `fc`
		ON((`cat`.`category_id` = `fc`.`category_id`))) JOIN `sakila`.`inventory` `i`
		ON((`i`.`film_id` = `fc`.`film_id`))) JOIN `sakila`.`rental` `r`
		ON((`i`.`inventory_id` = `r`.`inventory_id`))) JOIN `sakila`.`payment` `p`
		ON((`r`.`rental_id` = `p`.`rental_id`)))
GROUP BY `cat`.`name`
ORDER BY sum(`p`.`amount`) desc limit 5

-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.

drop view sakila.top5_genres;