1. Yankee Managers - List the name of everyone who has managed the New York Yankees.
```sql
SELECT DISTINCT namefirst, namelast
FROM managers 
    JOIN teams USING (teamid, yearid)
    JOIN master USING (masterid)
WHERE teams.name = 'New York Yankees'
ORDER BY namelast, namefirst
```

2. World Series Losers - List the name of each team that played in but lost the world series and number of world series that it has lost (the column WSWin in the Teams table has a N value if the team did not win the world series in that season, and has a Y in the LgWin column indicating it won the league). Each winner should be listed just once. 
```sql
SELECT teams.name, COUNT(*) AS losses
FROM teams
WHERE lgwin = 'Y' AND wswin = 'N'
GROUP BY teams.name
ORDER BY losses DESC
```

3. Good Hitters - List the name of each player with more than 200 hits in a season in their career (hits made is the "H" column in the "Batting" table).
```sql
SELECT namefirst, namelast
FROM master
WHERE masterid IN (
	SELECT masterid
    FROM batting
    GROUP BY masterid, yearid
    HAVING SUM(h) > 200
)
ORDER BY namelast, namefirst
```

4. Team Roger - List all the pitchers who have a first name of Roger.
```sql
SELECT DISTINCT namefirst, namelast
FROM master
	JOIN pitching USING(masterid)
WHERE namefirst = 'Roger'
ORDER BY namelast
```

5. Utah players - List the first name, last name, first year played, last year played, and lifetime batting average (h/ab) of every player who was born in Utah. 
```sql
SELECT
	ROUND(SUM(batting.h) * 1.0 / SUM(batting.ab), 3) AS batting_average,
	SUM(h) as hits,
	SUM(ab) as at_bats,
	namefirst,
	namelast, 
	MIN(batting.yearid) AS first_year_played, 
	MAX(batting.yearid) AS last_year_played
FROM
	master
	JOIN batting USING (masterid)
WHERE birthcountry = 'USA' AND birthstate = 'UT'
GROUP BY namefirst, namelast
HAVING SUM(batting.ab) > 0
ORDER BY namelast, namefirst
```

6. Expos Pitchers - List the first name and last name of every player that has pitched for the team named the "Montreal Expos". List each player only once.
```sql
SELECT DISTINCT namefirst, namelast
FROM master
JOIN pitching USING(masterid)
JOIN teams USING(teamid, yearid)
WHERE teams.name = 'Montreal Expos'
ORDER BY namelast, namefirst
```

7. Brooklyn - List the first name and last name of every player that has played (use the Appearances table) at any time in their career for the Brooklyn Dodgers. List each player only once. 
```sql
SELECT DISTINCT namefirst, namelast
FROM master
JOIN appearances USING(masterid)
JOIN teams USING(teamid, yearid)
WHERE teams.name = 'Brooklyn Dodgers'
ORDER BY namelast, namefirst
```

8. Error Prone Players - List the name of each player with more than 100 error s in some season in their career (errors made is the "E" column in the "fielding" table). 
```sql
SELECT namefirst, namelast, fielding.yearid, SUM(fielding.e)
FROM master
	JOIN fielding USING (masterid)
GROUP BY masterid, namefirst, namelast, fielding.yearid
HAVING SUM(fielding.e) > 100
ORDER BY namelast, namefirst
```

9. Brooklyn Dodgers Only - List the first name and last name of every player that has played only for the Brooklyn Dodgers (i.e., they did not play for any other team including the Los Angeles Dodgers, note that the Brooklyn Dodgers became the Los Angeles Dodgers in the 1950s). List each player only once.
```sql
SELECT namefirst, namelast
FROM master
	JOIN appearances USING (masterid)
	JOIN teams USING (yearid, teamid)
GROUP BY namefirst, namelast, masterid
HAVING COUNT(DISTINCT teams.name) = 1 AND MIN(teams.name) = 'Brooklyn Dodgers'
-- get players who played for one team name
-- then use MIN() to grab the team name from the "single-team" players
-- and check if it is 'Brooklyn Dodgers'
ORDER BY namelast, namefirst
```

10. Winningest Teams - List the winning percentage (wins divided by (wins + losses)) over a team's entire history. Consider a "team" to be a team with the same name, so if the team changes name, it is considered to be two different teams. Show the team name and win percentage.
```sql
SELECT 
	teams.name,
	ROUND((SUM(w)::NUMERIC / (SUM(w) + SUM(l))::NUMERIC), 4) AS win_percentage,
	SUM(w) AS total_wins,
	SUM(l) AS total_losses
FROM teams
GROUP BY teams.name
HAVING (SUM(w) + SUM(l)) > 0
ORDER BY teams.name
```