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

/* Using Null */

SELECT name FROM teacher WHERE dept IS NULL;

SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id);

SELECT teacher.name, dept.name FROM teacher LEFT JOIN dept ON teacher.dept=dept.id;

SELECT teacher.name, dept.name FROM dept LEFT JOIN teacher ON dept.id=teacher.dept;

SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher;

SELECT teacher.name, COALESCE(dept.name, 'None') FROM teacher LEFT JOIN dept ON teacher.dept=dept.id;

SELECT COUNT(teacher.name), COUNT(teacher.mobile) FROM teacher;

SELECT dept.name, count(teacher.name) FROM teacher RIGHT JOIN dept ON teacher.dept=dept.id GROUP BY dept.name;

SELECT teacher.name, 
CASE 
  WHEN teacher.dept=1 OR teacher.dept=2 
    THEN 'Sci'
  ELSE 'Art'
END
FROM teacher;

SELECT teacher.name, 
       CASE WHEN teacher.dept=1 OR teacher.dept=2
         THEN 'Sci'
            WHEN teacher.dept =3
         THEN 'Art'
         ELSE 'None'
       END
FROM teacher;

/* NSS Tutorial */

SELECT A_STRONGLY_AGREE
  FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science';

SELECT institution, subject
  FROM nss
 WHERE score>=100 AND question='Q15';

SELECT institution, score
  FROM nss
 WHERE score<50 AND question='Q15' AND subject='(8) Computer Science';

SELECT subject, SUM(response)
  FROM nss
 WHERE question='Q22'
   AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design') GROUP BY subject;

SELECT subject, SUM(response * A_STRONGLY_AGREE/100) 
  FROM nss
 WHERE question='Q22'
   AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design') GROUP BY subject;

/* Window functions */

SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC;

SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party;

SELECT yr,party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000021'
ORDER BY party,yr;

SELECT constituency, party
FROM ge x 
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
AND yr  = 2017 AND votes >= ALL(SELECT votes FROM ge y  WHERE x.constituency = y. constituency AND y.yr = 2017)
ORDER BY constituency,votes DESC;

SELECT party , COUNT(*)
FROM ge x 
WHERE constituency like 'S%'
AND yr  = 2017 AND votes >= ALL(SELECT votes FROM ge y  WHERE x.constituency = y. constituency AND y.yr = 2017)
GROUP BY party;

/* Self join */

SELECT COUNT(name) FROM stops;

SELECT id FROM stops WHERE name='Craiglockhart';

SELECT id, name FROM stops INNER JOIN route ON stops.id=route.stop WHERE route.num='4' AND company='LRT';

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*)=2;

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
WHERE a.stop = 53 AND b.stop=149;

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
(a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name='London Road';

SELECT R1.company, R1.num
FROM route R1, route R2, stops S1, stops S2
WHERE R1.num=R2.num AND R1.company=R2.company
AND R1.stop=S1.id AND R2.stop=S2.id
AND S1.name='Craiglockhart'
AND S2.name='Tollcross';

SELECT DISTINCT S2.name, R2.company, R2.num
FROM stops S1, stops S2, route R1, route R2
WHERE S1.name='Craiglockhart'
AND S1.id=R1.stop
AND R1.company=R2.company AND R1.num=R2.num
AND R2.stop=S2.id;

SELECT DISTINCT bus1.num, bus1.company, name, bus2.num, bus2.company FROM (SELECT start1.num, start1.company, stop1.stop FROM route AS start1 JOIN route AS stop1 ON start1.num = stop1.num AND start1.company = stop1.company AND start1.stop != stop1.stop WHERE start1.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart')) AS bus1 JOIN (SELECT start2.num, start2.company, start2.stop FROM route AS start2 JOIN route AS stop2 ON start2.num = stop2.num AND start2.company = stop2.company and start2.stop != stop2.stop WHERE stop2.stop = (SELECT id FROM stops WHERE name = 'Sighthill')) AS bus2 ON bus1.stop = bus2.stop JOIN stops ON bus1.stop = stops.id;
