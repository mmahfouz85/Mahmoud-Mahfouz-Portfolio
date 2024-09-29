Select 
	*
	from
	(
		SELECT 
		    f.title AS Film_Title,
		    r.rental_date,
		    TO_CHAR(rental_date,'dd/mm/yyyy') as formated_date,
			date(rental_date),
		    f.length,
		    a.first_name || ' ' || a.last_name AS actor_name,
		    c.name AS category_name,
		    SUM(p.amount) AS total_revenue
		FROM 
		    actor a
		    JOIN film_actor fa ON a.actor_id = fa.actor_id
		    JOIN film f ON fa.film_id = f.film_id
		    JOIN film_category fc ON f.film_id = fc.film_id
		    JOIN category c ON fc.category_id = c.category_id
		    JOIN inventory i ON f.film_id = i.film_id
		    JOIN rental r ON i.inventory_id = r.inventory_id
		    JOIN payment p ON r.rental_id = p.rental_id
			where 
			f.length>150 
			-- and a.first_name || ' ' || a.last_name like '%Ray%'

	
			GROUP BY 
			1,2,3,4,5,6,7
		    -- f.title, a.actor_id, a.first_name, a.last_name, f.length, f.release_year, r.rental_date, c.name
			
			Having 
			SUM(p.amount)  > 6.99
	)
ORDER BY 
    length DESC
	