1. 
```sql
SELECT DISTINCT namefirst, namelast
FROM managers 
    JOIN master USING (masterid) as mm 
    JOIN teams as t ON mm.teamID = t.teamID AND mm.yearID = t.yearID
WHERE t.name = 'New York Yankees'
ORDER BY namelast
```

2.
```sql
SELECT name, COUNT(wswin) AS losses FROM teams
WHERE lgwin = 'Y' AND wswin = 'N'
GROUP BY name
ORDER BY losses DESC;
```

3.
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

4.
```sql
SELECT DISTINCT namefirst, namelast
FROM master
	JOIN pitching USING(masterid)
WHERE namefirst = 'Roger'
ORDER BY namelast
```

5.
```sql
SELECT DISTINCT 
	CASE
		WHEN bs.ab_sum = 0 THEN 0.0
		ELSE CAST((bs.h_sum :: NUMERIC / bs.ab_sum :: NUMERIC) AS DECIMAL(10,3))
	END AS batting_avg,
	h_sum,
	ab_sum,
	namefirst,
	namelast, 
	EXTRACT(YEAR FROM debut) AS first_year_played, 
	EXTRACT(YEAR FROM finalgame) AS last_year_played
FROM
	master
	JOIN (
		SELECT masterid, SUM(h) as h_sum, SUM(ab) as ab_sum
		FROM batting
		GROUP BY masterid
	) as bs USING(masterid)
WHERE ab_sum > 0 AND birthcountry = 'USA' AND birthstate = 'UT'
ORDER BY namelast, namefirst
```

6.
```sql
SELECT DISTINCT namefirst, namelast
FROM master
JOIN pitching USING(masterid)
JOIN teams USING(teamid, yearid)
WHERE teams.name = 'Montreal Expos'
ORDER BY namelast, namefirst
```

7.
```sql
SELECT DISTINCT namefirst, namelast
FROM master
JOIN appearances USING(masterid)
JOIN teams USING(teamid, yearid)
WHERE teams.name = 'Brooklyn Dodgers'
ORDER BY namelast, namefirst
```

8.
```sql
SELECT namefirst, namelast, seasonerrors.yearid, seasonerrors.errors
FROM master JOIN (
	SELECT masterid, yearid, SUM(e) as errors
	FROM fielding
	GROUP BY masterid, yearid
	HAVING SUM(e) > 100
) as seasonerrors USING(masterid)
ORDER BY namelast, namefirst
```
select * from fielding where masterid='burnsoy01' and yearid=1887

9.
```sql
SELECT DISTINCT namefirst, namelast
FROM master
JOIN (
	SELECT masterid
	FROM appearances
	JOIN teams USING(yearid, teamid)
	GROUP BY masterid
	HAVING COUNT(DISTINCT teams.name) = 1 AND MIN(teams.name) = 'Brooklyn Dodgers'
	-- get players who played for one team name
	-- then use MIN() to grab the (only) team name from the row and check if it is 'Brooklyn Dodgers'
) USING(masterid)
ORDER BY namelast, namefirst
```

10. 
```sql
SELECT 
	teams.name,
	CAST((SUM(w)::NUMERIC / (SUM(w) + SUM(l))::NUMERIC) AS DECIMAL(10, 4)) AS win_percentage,
	SUM(w) AS total_wins,
	SUM(l) AS total_losses
FROM teams
GROUP BY teams.name
HAVING (SUM(w) + SUM(l)) > 0 -- at least played one game
ORDER BY teams.name;
```