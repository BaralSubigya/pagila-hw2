/*
 * Compute the total revenue for each film.
 * The output should include a new column "rank" that shows the numerical rank
 *
 * HINT:
 * You should use the `rank` window function to complete this task.
 * Window functions are conceptually simple,
 * but have an unfortunately clunky syntax.
 * You can find examples of how to use the `rank` function at
 * <https://www.postgresqltutorial.com/postgresql-window-function/postgresql-rank-function/>.
 */
SELECT
    RANK() OVER (ORDER BY COALESCE(SUM(p.amount),0.00) DESC) AS rank,
    f.title,
    COALESCE(SUM(p.amount),0.00) AS revenue
FROM film f
LEFT JOIN inventory i
    ON f.film_id = i.film_id
LEFT JOIN rental r
    ON i.inventory_id = r.inventory_id
LEFT JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY f.film_id, f.title
ORDER BY rank, f.title;
