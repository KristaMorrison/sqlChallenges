-- What languages are spoken in the 20 poorest (GNP/ capita) countries in the world?
with
	poorest20 as
	(select
		name,
		gnp/population as gnp_per_capita,
		code
	from
		country
	where
		population > 0 and gnp > 0
	order by
		gnp_per_capita limit 20)

select
	distinct cl.language AS Language
from
	poorest20 p JOIN countrylanguage cl
	ON (p.code = cl.countrycode)
order by
	language

-- The result
"Afar"
"Amhara"
"Arabic"
"Asami"
"Bambara"
"Bhojpuri"
"Bilin"
"Boa"
"Bullom-sherbro"
"Busansi"
"Chaga and Pare"
"Chichewa"
"Chinese"
"Chokwe"
"Chuabo"
"Crioulo"
"Dagara"
"Dyula"
"Dzongkha"
"French"
"Ful"
"Gogo"
"Gorane"
"Gurage"
"Gurma"
"Ha"
"Hadareb"
"Hadjarai"
"Hausa"
"Haya"
"Hehet"
"Hindi"
"Kanem-bornu"
"Kanuri"
"Kirundi"
"Kongo"
"Kono-vai"
"Korean"
"Kuranko"
"Lao"
"Lao-Soung"
"Limba"
"Lomwe"
"Luba"
"Luguru"
"Maithili"
"Makonde"
"Makua"
"Malagasy"
"Marendje"
"Mayo-kebbi"
"Mende"
"Mon-khmer"
"Mongo"
"Mossi"
"Nepali"
"Newari"
"Ngala and Bangi"
"Ngoni"
"Nyakusa"
"Nyamwesi"
"Nyanja"
"Oromo"
"Ouaddai"
"Ronga"
"Rundi"
"Rwanda"
"Saho"
"Sara"
"Sena"
"Senufo and Minianka"
"Shambala"
"Shona"
"Sidamo"
"Somali"
"Songhai"
"Songhai-zerma"
"Soninke"
"Swahili"
"Tamang"
"Tamashek"
"Tandjile"
"Teke"
"Temne"
"Thai"
"Tharu"
"Tigre"
"Tigrinja"
"Tsonga"
"Tswa"
"Walaita"
"Yalunka"
"Yao"
"Zande"

-- What are the cities in the countries with no official language?

with officialCountry AS
	(select
	cl.countrycode
  from
  	country c JOIN countrylanguage cl
  	ON (c.code = cl.countrycode)
  except
  select
  	cl.countrycode
  from
  	country c JOIN countrylanguage cl
  	ON (c.code = cl.countrycode)
  where
  	cl.isofficial = true
	 )
select
	oc.countrycode,
	cities.name
from
	officialCountry oc JOIN city cities ON (cities.countrycode = oc.countrycode)

-- There are 193

-- Which languages are spoken in the ten largest (area) countries?
with
	largestCountries AS
	(select
		name,
		surfacearea,
		code
	from
		country
	order by
		surfacearea desc limit 10)
select
	DISTINCT cl.language
from
	largestCountries lc JOIN countrylanguage cl ON(lc.code = cl.countrycode)
order by
	cl.language

-- What is the total population of cities where English is the offical language? HINT: The official language of a city is based on country.

with
	englishOfficial AS
	(select
		countrycode
	from
		countrylanguage
	where
		language = 'English' AND isofficial = true)
select
	SUM (c.population)
from
	englishOfficial eo JOIN city c ON (eo.countrycode = c.countrycode)

--English answer:
149,478,361
--Spanish answer
176,842,275

-- Are there any countries without an official language?
select
cl.countrycode
from
  country c JOIN countrylanguage cl
  ON (c.code = cl.countrycode)
except
select
  cl.countrycode
from
  country c JOIN countrylanguage cl
  ON (c.code = cl.countrycode)
where
  cl.isofficial = true
-- Yes.  43.

-- How many countries have no cities?
select code from country

EXCEPT

select countrycode from city

-- 7

-- Which countries have the 100 biggest cities in the world?
with biggest AS
(select
	countrycode

from
	city
order by
	population desc limit 100)
select
	distinct c.name
from
	country c JOIN biggest b ON(c.code = b.countrycode)
order by
	c.name
-- there are 48 countries with the 100 biggest cities

-- What languages are spoken in the countries with the 100 biggest cities in the world?
with biggest AS
(select
	countrycode

from
	city
order by
	population desc limit 100)
select
	distinct cl.language
from
	country c JOIN biggest b ON(c.code = b.countrycode) JOIN countrylanguage cl ON(cl.countrycode = c.code)
order by
	cl.language
-- there are 202 languages spoken in the countries with the 100 biggest cities

-- Which countries have the highest proportion of official language speakers? The lowest?
select
	c.name,
	percentage
from
	countrylanguage cl JOIN country c ON(cl.countrycode = c.code)
where
	isofficial = true
order by
	percentage desc limit 8
--8 countries have 100% of its population speaking its official language

-- 36 countries have 0% of its population speaking its official language



-- Which customer placed an order on the earliest date? What did they order?
select
	c.first_name,
	c.last_name,
	f.title
from
	rental r JOIN customer c ON(r.customer_id = c.customer_id)
	JOIN inventory i ON (r.inventory_id = i.inventory_id)
	JOIN film f ON (i.film_id = f.film_id)
order by
	r.rental_date

-- result
"Charlotte";"Hunter";"Blanket Beverly"

-- Which product do we have the most of?
select
	count(film_id),
	film_id

from
	inventory
group by
	film_id
order by
	count desc

--1 result of 72 results total is 8 copies of film id # 789
8;789

--Find the order ids and customer names for all orders for that item.
select
	c.first_name,
	c.last_name,
	r.rental_id,
	r.rental_date
from
	rental r JOIN inventory i ON(i.inventory_id = r.inventory_id)
	JOIN customer c ON(c.customer_id = r.customer_id)

where
	film_id=789
order by
	r.rental_date

--There are 30 bozos who ordered this terrible movie.


-- What orders have there been from Texas?
select
	*
from
	address a JOIN customer c ON(a.address_id = c.address_id)
	JOIN rental r ON (r.customer_id = c.customer_id)

where
	a.district = 'Texas'

-- The above results in 154 rentals from Texas.

--In June?
select
	*
from
	address a JOIN customer c ON(a.address_id = c.address_id)
	JOIN rental r ON (r.customer_id = c.customer_id)

where
	a.district = 'Texas' AND r.rental_date >= '2005-06-01'
	AND r.rental_date <= '2005-06-30'

--23 rental bozos used this awful service in JUNE from TEXAS


-- How many orders have we had for sci-fi films?
select
	count(r.inventory_id)
from
	film_category fc JOIN category c ON(c.category_id = fc.category_id)
	JOIN film f ON (fc.film_id = f.film_id)
	JOIN inventory i ON (i.film_id = f.film_id)
	JOIN rental r ON(r.inventory_id = i.inventory_id)
where
	c.name = 'Sci-Fi'
--1101 sci-fi rentals

--From Texas?
with
	fromTexas AS
	(select
	*
from
	address a JOIN customer c ON(a.address_id = c.address_id)
	JOIN rental r ON (r.customer_id = c.customer_id)

where
	a.district = 'Texas' )

select
	count(r.inventory_id)
from
	film_category fc JOIN category c ON(c.category_id = fc.category_id)
	JOIN film f ON (fc.film_id = f.film_id)
	JOIN inventory i ON (i.film_id = f.film_id)
	JOIN rental r ON(r.inventory_id = i.inventory_id)
	JOIN fromTexas ft ON(r.rental_id = ft.rental_id)
where
	c.name = 'Sci-Fi'
--10 sci-fi rentals from Texas

-- Which actors have not appeared in a Sci-Fi film?
select
	DISTINCT a.first_name,
	a.last_name

from
	category c JOIN film_category fc ON(c.category_id = fc.category_id)
	JOIN film f ON(f.film_id = fc.film_id)
	JOIN film_actor fa ON(fa.film_id = f.film_id)
	JOIN actor a ON(a.actor_id = fa.actor_id)
where
	c.name != 'Sci-Fi'
--There are 199 actors not in sci-fi films

-- Find all customers who have not ordered a Sci-Fi film.
