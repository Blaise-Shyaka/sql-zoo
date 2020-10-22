/* SELECT basics */
SELECT population FROM world
  WHERE name = 'Germany';

SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000;

/* SELECT names */

SELECT name FROM world
  WHERE name LIKE 'Y%';

SELECT name FROM world
  WHERE name LIKE '%Y';

SELECT name FROM world
  WHERE name LIKE '%x%';

SELECT name FROM world
  WHERE name LIKE '%land';

SELECT name FROM world
  WHERE name LIKE 'C%ia';

SELECT name FROM world
  WHERE name LIKE '%oo%';

SELECT name FROM world
  WHERE name LIKE '%a%a%a%';

SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name;

SELECT name FROM world
 WHERE name LIKE '%o__o%';

SELECT name FROM world
 WHERE name LIKE '____';

SELECT name
  FROM world
 WHERE name LIKE capital;

SELECT name
  FROM world
 WHERE capital LIKE concat(name, ' ', 'City');

SELECT capital, name FROM world WHERE capital LIKE concat('%', name, '%');

SELECT capital, name FROM world WHERE capital LIKE concat(name, '%_%');

SELECT name, REPLACE(capital, name, '') FROM world WHERE capital LIKE concat(name, '%_%');

/* SELECT from WORLD Tutorial */

SELECT name FROM world
WHERE population >= 200000000;

SELECT name, (gdp/population) AS 'GDP/Capita' FROM world WHERE population >= 200000000;

SELECT name, (population/1000000) FROM world WHERE continent = 'South America';

SELECT name, population FROM world WHERE name IN ('France', 'Germany', 'Italy');

SELECT name FROM world WHERE name LIKE '%United%';

SELECT name, population, area FROM world WHERE area > 3000000 OR population > 250000000;

SELECT name, population, area FROM world WHERE area > 3000000 XOR population > 250000000;

SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2) FROM world WHERE continent = 'South America';

SELECT name, ROUND(gdp/population, -3) FROM world WHERE gdp > 1000000000000;

SELECT name, capital FROM world
 WHERE LENGTH(name) = LENGTH(capital);

SELECT name, capital
FROM world WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital;

SELECT name
   FROM world
WHERE name LIKE '%a%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%' AND name LIKE '%e%'
  AND name NOT LIKE '% %';

/* SELECT from Nobel Tutorial */

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature';

SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein';

SELECT winner FROM nobel WHERE subject = 'Peace' AND yr >= 2000;

SELECT yr, subject, winner FROM nobel WHERE subject = 'Literature' AND yr >= 1980 AND yr < 1990;

SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');

SELECT winner FROM nobel WHERE winner LIKE 'John%';

SELECT yr, subject, winner FROM nobel WHERE subject = 'Physics' AND yr = 1980 OR subject = 'Chemistry' AND yr = 1984;

SELECT yr, subject, winner FROM nobel WHERE yr = 1980 AND subject NOT IN ('Chemistry', 'Medicine');

SELECT yr, subject, winner FROM nobel WHERE subject = 'Medicine' AND yr <= 1909 OR subject = 'Literature' AND yr >= 2004;

SELECT * FROM nobel WHERE winner = 'PETER GRÜNBERG';

SELECT * FROM nobel WHERE winner = 'EUGENE O''NEILL';

SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%' ORDER BY yr DESC, winner;

SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY CASE WHEN subject IN ('Physics', 'Chemistry') THEN 1 ELSE 0 END, subject,winner;

/* SELECT within SELECT */

SELECT name FROM world WHERE continent = 'Europe' AND (gdp/population) > (SELECT (gdp/population) FROM world WHERE name = 'United Kingdom');

SELECT name, continent FROM world WHERE continent = (SELECT continent FROM world WHERE name = 'Argentina') OR continent = (SELECT continent FROM world WHERE name = 'Australia') ORDER BY name;

SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland');

SELECT name, CONCAT(ROUND((population * 100 /(SELECT population FROM world WHERE name = 'Germany'))), '%') FROM world WHERE continent = 'Europe';

SELECT name FROM world WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent = 'Europe');

SELECT continent, name, area FROM world x
  WHERE area =
    (SELECT MAX(area) FROM world y
        WHERE y.continent=x.continent);

SELECT continent, name FROM world x WHERE name = (SELECT name FROM world y WHERE x.continent = y.continent ORDER BY name LIMIT 1);

/* SUM and COUNT */

SELECT SUM(population)
FROM world;

SELECT DISTINCT continent FROM world;

SELECT SUM(gdp) FROM world WHERE continent = 'Africa';

SELECT COUNT(name) FROM world WHERE area >= 1000000;

SELECT SUM(population) FROM world WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

SELECT continent, COUNT(name) FROM world GROUP BY(continent);

SELECT continent, COUNT(name) FROM world WHERE population >= 10000000 GROUP BY continent;

SELECT continent FROM world GROUP BY continent HAVING SUM(population) >= 100000000;

/* JOIN and UEFA EURO 2012 */

SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';

SELECT id,stadium,team1,team2
  FROM game WHERE id = 1012;

SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid) WHERE teamid = 'GER';

SELECT team1, team2, player FROM goal JOIN game ON (goal.matchid = game.id) WHERE player LIKE 'Mario%';

SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam on teamid=id
 WHERE gtime<=10;

SELECT mdate, teamname FROM game JOIN eteam ON team1=eteam.id WHERE coach = 'Fernando Santos';

SELECT player FROM goal JOIN game ON matchid=id WHERE stadium = 'National Stadium, Warsaw';

SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND teamid NOT IN('GER');

SELECT teamname, COUNT(teamid)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname;

SELECT stadium, COUNT(player) FROM goal JOIN game ON matchid = id GROUP BY stadium;

SELECT matchid,mdate, COUNT(teamid)
  FROM game JOIN goal ON id = matchid 
 WHERE (team1 = 'POL' OR team2 = 'POL') GROUP BY mdate, matchid ORDER BY matchid;

SELECT matchid, mdate, COUNT(player) FROM goal JOIN game ON matchid = id WHERE teamid = 'GER' GROUP BY matchid, mdate ORDER BY matchid;

/* More JOIN operations */

SELECT id, title
 FROM movie
 WHERE yr=1962;

SELECT yr FROM movie WHERE title = 'Citizen Kane';

SELECT id, title, yr FROM movie WHERE title LIKE '%Star Trek%' ORDER BY yr;

SELECT id FROM actor WHERE name = 'Glenn Close';

SELECT id FROM movie WHERE title = 'Casablanca';

SELECT name FROM casting JOIN actor ON actorid = id WHERE movieid=11768;

SELECT name FROM casting JOIN actor ON actorid = id WHERE movieid=(SELECT id FROM movie WHERE title='Alien');

SELECT title FROM movie JOIN casting ON id=movieid WHERE actorid=(SELECT id FROM actor WHERE name='Harrison Ford');

SELECT title FROM movie JOIN casting ON id=movieid WHERE actorid=(SELECT id FROM actor WHERE name='Harrison Ford') AND ord<>1;

SELECT title, name FROM movie JOIN casting ON movie.id=casting.movieid JOIN actor ON casting.actorid=actor.id WHERE yr=1962 AND ord=1;

