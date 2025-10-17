1. Yankee Batters - For each year, list how many different players batted for the New York Yankees.

```sql
SELECT b.yearid, COUNT(DISTINCT masterid) as num_batters
FROM batting as b
	JOIN teams USING(teamid, yearid)
WHERE teams.name = 'New York Yankees'
GROUP BY b.yearid
ORDER BY b.yearid
```

2.  Winning streaks - Which teams (and years) won more games in each year for five consecutive years?

```sql
SELECT
    t1.name,
    t1.yearid AS start_year,
    t5.yearid AS end_year,
    t1.w AS wins_year_one,
    t2.w AS wins_year_two,
    t3.w AS wins_year_three,
    t4.w AS wins_year_four,
    t5.w AS wins_year_five
FROM teams AS t1
JOIN teams AS t2
    ON t1.teamid = t2.teamid AND t1.yearid = t2.yearid - 1 AND t1.w < t2.w
JOIN teams AS t3
    ON t2.teamid = t3.teamid AND t2.yearid = t3.yearid - 1 AND t2.w < t3.w
JOIN teams AS t4
    ON t3.teamid = t4.teamid AND t3.yearid = t4.yearid - 1 AND t3.w < t4.w
JOIN teams AS t5
    ON t4.teamid = t5.teamid AND t4.yearid = t5.yearid - 1 AND t4.w < t5.w
```

3. Returning players - Let a stint be defined as a consecutive number of years in which a player appeared for 
some team (not necessarily the same team) and then did not appear for any team. List all players that had at 
least five stints.

```sql
SELECT namefirst, namelast, SUM(new_stint) as num_stints
FROM (
    SELECT
        masterid,
        yearid,
        teamid,
        CASE
            WHEN
                -- first appearance is first stint
                LAG(yearid) OVER (PARTITION BY masterid ORDER BY yearid) IS NULL
                -- ex: 1929 - 1927 = 2 > 1 => player missed one or more years, so count new stint
                OR yearid - LAG(yearid) OVER (PARTITION BY masterid ORDER BY yearid) > 1
            THEN 1
            ELSE 0
        END AS new_stint
    FROM appearances
)
    JOIN master USING (masterid)
GROUP BY masterid, namefirst, namelast
HAVING SUM(new_stint) >= 5
ORDER BY masterid
```

4. Triples ranking - Rank players by the number of triples (column 3B in the Batting table) they have hit in
any season and list the top ten such rankings of players. For instance, the player(s) who hit the most in a 
season would have rank 1, the second most would be rank 2, etc. Note that there could be several players in 
a rank, e.g., five players with rank 4.

```sql
WITH best_threb_season AS (
	SELECT
		namefirst,
		namelast,
		MAX(threb) as threb_best
	FROM batting
		JOIN master USING (masterid)
	GROUP BY namefirst, namelast, masterid)

SELECT *
FROM (
	SELECT
		namefirst,
		namelast,
		DENSE_RANK() OVER (ORDER BY threb_best DESC NULLS LAST) AS threb_rank,
		threb_best
	FROM best_threb_season
)
WHERE threb_rank <= 10
```

5. Yankee Run Kings - List the name, year, and number of home runs hit for each New York Yankee batter,
but only if they hit the most home runs for any player in that season.

```sql
WITH best_hr_by_season AS (
	SELECT
		masterid,
		namefirst,
		namelast,
		teamid,
		yearid,
		hr
	FROM (
		SELECT 
			*,
			DENSE_RANK() OVER (PARTITION BY yearid ORDER BY hr DESC NULLS LAST) AS hr_rank
		FROM batting
			JOIN master USING (masterid)
	)
	WHERE hr_rank = 1
)

SELECT namefirst, namelast, yearid, bhrs.hr
FROM best_hr_by_season as bhrs
	JOIN teams USING (teamid, yearid)
WHERE teams.name = 'New York Yankees'
```

6. Third best home run hitters each year - List the first name, last name, year and number of home runs
(column HR in the Batting table) of every player that hit the third most number of home runs for that year.
Order by the year.

```sql
SELECT
	namefirst,
	namelast,
	yearid,
	hr
FROM (
	SELECT *,
	DENSE_RANK() OVER (PARTITION BY yearid ORDER BY hr DESC NULLS LAST) AS hr_rank
	FROM batting
		JOIN master USING (masterid)
)
WHERE hr_rank = 3
ORDER BY yearid, namelast, namefirst
```


7. Two degrees from Yogi Berra - List the name of each player who appeared on a team with a player that was 
at one time was a teammate of Yogi Berra. So suppose player A was a teammate of Yogi Berra. Then player A is
one-degree of separation from Yogi Berra. Let player B be related to player A because A played on a team in 
the same year with player B. Then player B is two-degrees of separation from Yogi Berra.

```sql
WITH yogi_berra_id AS (
	SELECT masterid
	FROM master
	WHERE namefirst = 'Yogi' AND namelast = 'Berra'
),

first_degree AS (
	SELECT DISTINCT a2.masterid
	FROM appearances AS a1
		JOIN appearances AS a2 USING (teamid, yearid)
	WHERE
		a1.masterid = (SELECT masterid FROM yogi_berra_id) 
		AND a2.masterid != (SELECT masterid FROM yogi_berra_id)
),

second_degree AS (
	SELECT DISTINCT a4.masterid
	FROM appearances AS a3
		JOIN appearances AS a4 USING (teamid, yearid)
	WHERE a3.masterid IN (SELECT masterid FROM first_degree)
)

SELECT DISTINCT
	m.namefirst,
	m.namelast
FROM master AS m
WHERE 
	m.masterid IN (SELECT masterid FROM second_degree) 
    -- answer includes those in first DoS as well, uncomment to exclude first DoS
	-- AND m.masterid NOT IN (SELECT masterid FROM first_degree)
	AND m.masterid != (SELECT masterid FROM yogi_berra_id)
ORDER BY m.namelast, m.namefirst
```

8. Traveling with Rickey - List all of the teams for which Rickey Henderson did not play. Note that because
teams come and go, limit your answer to only the teams that were in existence while Rickey Henderson was a player.
List each such team once.

```sql
WITH rickey_h_years AS (
	SELECT
		EXTRACT(YEAR FROM debut) AS first_year,
		EXTRACT(YEAR FROM finalgame) AS last_year
	FROM master
	WHERE namefirst = 'Rickey' AND namelast = 'Henderson'
),

teams_during_rickey AS (
	SELECT teams.name
	FROM teams 
	WHERE yearid BETWEEN (
		SELECT first_year
		FROM rickey_h_years
	) AND (
		SELECT last_year
		FROM rickey_h_years
	)
),

rickey_h_teams AS (
	SELECT teams.name
	FROM appearances
		JOIN master USING (masterid)
		JOIN teams USING (teamid, yearid)
	WHERE namefirst = 'Rickey' AND namelast = 'Henderson'
)

SELECT DISTINCT tdr.name
FROM teams_during_rickey AS tdr
WHERE
	tdr.name NOT IN (
		SELECT rht.name
		FROM rickey_h_teams AS rht
	)
ORDER BY tdr.name
```

9. Median team wins - For the 1970s, list the team name for teams in the National League ("NL") that had the
median number of total wins in the decade (1970-1979 inclusive) (if there are even number of teams, round up 
to find the median).

```sql
WITH seventies_wins AS (
  SELECT
    teams.name,
    SUM(w) AS total_wins
  FROM teams
  WHERE
    yearid BETWEEN 1970 AND 1979 AND lgid = 'NL'
  GROUP BY teams.name
),

ranked_wins AS (
  SELECT
    seventies_wins.name,
    total_wins,
    DENSE_RANK() OVER (ORDER BY total_wins) AS rank_num,
    COUNT(*) OVER () AS team_count
  FROM seventies_wins
)

SELECT ranked_wins.name, rank_num
FROM ranked_wins
WHERE rank_num = CEIL(team_count / 2.0)
```