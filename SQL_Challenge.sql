-- This is the query that finds the smallest country by population and surface area, with the largest GNP
select
		name,
		gnp,
		population,
		surfacearea
	from
		country
	where
		population < 10000

-- The above query resulted with 19 rows, this is the row that satisfied the parameters.
"Anguilla";63.20;8000;96

-- This is the query that finds the ten countries with the largest surface area
select
	name,
	surfacearea
from
	country
where
	surfacearea > 0
order by
	surfacearea desc limit 10

-- The top 10 are the following
"Russian Federation";1.70754e+07
"Antarctica";1.312e+07
"Canada";9.97061e+06
"China";9.5729e+06
"United States";9.36352e+06
"Brazil";8.5474e+06
"Australia";7.74122e+06
"India";3.28726e+06
"Argentina";2.7804e+06
"Kazakstan";2.7249e+06

-- This is the query that finds the ten countries with the smallest surface area
select
	name,
	surfacearea
from
	country
where
	surfacearea > 0
order by
	surfacearea asc limit 10

--The smallest 10 are the following
"Holy See (Vatican City State)";0.4
"Monaco";1.5
"Gibraltar";6
"Tokelau";12
"Cocos (Keeling) Islands";14
"United States Minor Outlying Islands";16
"Macao";18
"Nauru";21
"Tuvalu";26
"Norfolk Island";36

-- This query is to find the sum of the surface area of the ten smallest countries
with
	smallest_countries AS
	(select

		name,
		surfacearea
	from
		country
	where
		surfacearea > 0
	order by
		surfacearea asc limit 10)
select
	sum(surfacearea) AS total_area
from
	smallest_countries

--The result is listed as total_area
150.9

--This query is to find the sum of the surface area of the ten largest countries
with
largest_countries AS
(select
	name,
	surfacearea
from
	country
where
	surfacearea > 0
order by
	surfacearea desc limit 10)
select
sum(surfacearea) AS total_area
from
largest_countries

--The result is listed as total_area
8.41836e+07

--list the countries in africa that have a population smaller than 30,000,000 and a life expectancy of more than 45
select
	name,
	population,
	lifeexpectancy
from
	country
where
	continent = 'Africa' AND population < 30000000 AND lifeexpectancy > 45

-- The result is listed as name, population, lifeexpectancy
"Benin";6097000;50.2
"Burkina Faso";11937000;46.7
"Burundi";6695000;46.2
"Djibouti";638000;50.8
"Eritrea";3850000;55.8
"Gabon";1226000;50.1
"Gambia";1305000;53.2
"Ghana";20212000;57.4
"Guinea";7430000;45.6
"Guinea-Bissau";1213000;49
"Cameroon";15085000;54.8
"Cape Verde";428000;68.9
"Comoros";578000;60
"Congo";2943000;47.4
"Lesotho";2153000;50.8
"Liberia";3154000;51
"Libyan Arab Jamahiriya";5605000;75.5
"Western Sahara";293000;49.8
"Madagascar";15942000;55
"Mali";11234000;46.7
"Morocco";28351000;69.1
"Mauritania";2670000;50.8
"Mauritius";1158000;71
"Mayotte";149000;59.5
"Côte dIvoire";14786000;45.2
"Equatorial Guinea";453000;53.6
"Réunion";699000;72.7
"Saint Helena";6000;76.8
"Sao Tome and Principe";147000;65.3
"Senegal";9481000;62.2
"Seychelles";77000;70.4
"Sierra Leone";4854000;45.3
"Somalia";10097000;46.2
"Sudan";29490000;56.6
"Togo";4629000;54.7
"Chad";7651000;50.5
"Tunisia";9586000;73.7


--how many countries gained independence after 1910 that are also a republic
select
	count(name)
from
	country
where
	indepyear > 1910 AND governmentform = 'Republic'


--The result is listed as:
97

--which region has the highest ave gnp
select
	avg(gnp) AS average_gnp,
	region
from
	country
group by
	region
order by
	average_gnp desc

-- The result is the top row, listed as average_gnp, region:
1822378.000000000000;"North America"

-- Who is the head of state for the Top 10 highest ave gnp?
select
	name,
	headofstate,
	gnp
from
	country
order by
	gnp desc limit 10

-- The result is listed as name, headofstate, gnp
"United States";"George W. Bush";8510700.00
"Japan";"Akihito";3787042.00
"Germany";"Johannes Rau";2133367.00
"France";"Jacques Chirac";1424285.00
"United Kingdom";"Elisabeth II";1378330.00
"Italy";"Carlo Azeglio Ciampi";1161755.00
"China";"Jiang Zemin";982268.00
"Brazil";"Fernando Henrique Cardoso";776739.00
"Canada";"Elisabeth II";598862.00
"Spain";"Juan Carlos I";553233.00

-- What are the forms of government for the top ten countries by surface area?
select
	name,
	governmentform
from
	country
where
	surfacearea > 0
order by
	surfacearea desc limit 10

--The result listed as name, governmentform
"Russian Federation";"Federal Republic"
"Antarctica";"Co-administrated"
"Canada";"Constitutional Monarchy, Federation"
"China";"People'sRepublic"
"United States";"Federal Republic"
"Brazil";"Federal Republic"
"Australia";"Constitutional Monarchy, Federation"
"India";"Federal Republic"
"Argentina";"Federal Republic"
"Kazakstan";"Republic"


-- Which fifteen countries have the lowest life expectancy?
select
	name,
	lifeexpectancy
from
	country
where
	lifeexpectancy >= 0
order by
	lifeexpectancy asc limit 15

-- The result listed as name, lifeexpectancy
"Zambia";37.2
"Mozambique";37.5
"Malawi";37.6
"Zimbabwe";37.8
"Angola";38.3
"Botswana";39.3
"Rwanda";39.3
"Swaziland";40.4
"Niger";41.3
"Namibia";42.5
"Uganda";42.9
"Central African Republic";44
"Côte dIvoire";45.2
"Ethiopia";45.2
"Sierra Leone";45.3

-- Which five countries have the lowest population density?
select
	name
from
	country
order by
	population/surfacearea asc limit 5

-- The result listed by name
"Bouvet Island"
"British Indian Ocean Territory"
"Antarctica"
"Heard Island and McDonald Islands"
"South Georgia and the South Sandwich Islands"

-- Which countries are in the top 5% in terms of area?
select
	name,
	surfacearea
from
	country
order by
	surfacearea desc limit 239*.05

--The result listed as name, surfacearea
"Russian Federation";1.70754e+07
"Antarctica";1.312e+07
"Canada";9.97061e+06
"China";9.5729e+06
"United States";9.36352e+06
"Brazil";8.5474e+06
"Australia";7.74122e+06
"India";3.28726e+06
"Argentina";2.7804e+06
"Kazakstan";2.7249e+06
"Sudan";2.50581e+06
"Algeria";2.38174e+06
