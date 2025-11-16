-- Constraint 1:
-- The default salary is "100".
ALTER TABLE salaries
ALTER COLUMN salary SET DEFAULT 100;
-- Insertion/update/or delete to test the constraint
INSERT INTO salaries (yearid, teamid, lgid, masterid)
VALUES (2025, 'BOS', 'AL', 'defsal01');

-- Constraint 2:
-- A player cannot have a salary lower than the year in which they were paid. 
ALTER TABLE salaries
ADD CONSTRAINT salary_not_less_than_year
CHECK (salary >= yearid);
-- Insertion/update/or delete to test the constraint
INSERT INTO salaries (yearid, teamid, lgid, masterid, salary)
VALUES (2025, 'BOS', 'AL', 'lowsal01', 500);

-- Constraint 3:
-- The masterid of a person with a salary must exist in the master table.
ALTER TABLE salaries
ADD CONSTRAINT fk_salary_master
FOREIGN KEY (masterid)
REFERENCES master(masterid);
-- Insertion/update/or delete to test the constraint
INSERT INTO salaries (yearid, teamid, lgid, masterid, salary)
VALUES (2025, 'BOS', 'AL', 'fakeid01', 3000000);

-- Constraint 4:
--  When a team loses more than 161 games in a season, the fans want to forget about the team forever, so all batting records for the team for that year should be deleted.
CREATE OR REPLACE FUNCTION delete_team_on_161_losses()
RETURNS trigger AS $$
BEGIN
  IF NEW.l > 161 THEN
    DELETE FROM batting
    WHERE yearid = NEW.yearid
      AND teamid = NEW.teamid;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_delete_team_on_161_losses
AFTER UPDATE OF l ON teams
FOR EACH ROW
WHEN (NEW.l > 161)
EXECUTE FUNCTION delete_team_on_161_losses();
-- Insertion/update/or delete to test the constraint
UPDATE teams
SET l = 200
WHERE yearid = 2004 AND teamid = 'SFN';

SELECT * FROM batting WHERE yearid = 2004 AND teamid = 'SFN'

-- Constraint 5:
-- If a batter hits 100 HRs in a year, they are automatically inducted into the Hall of Fame (a new row in the hallOfFame table).
CREATE OR REPLACE FUNCTION hof_for_100_hr()
RETURNS trigger AS $$
BEGIN
  IF NEW.hr >= 100 THEN
    INSERT INTO halloffame (masterid, yearid, votedby, inducted)
    VALUES (NEW.masterid, NEW.yearid, 'Auto', 'Y')
    ON CONFLICT (masterid, yearid, votedby) DO NOTHING;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_hof_for_100_hr
AFTER INSERT OR UPDATE OF hr ON batting
FOR EACH ROW
WHEN (NEW.hr >= 100)
EXECUTE FUNCTION hof_for_100_hr();
-- Insertion/update/or delete to test the constraint
UPDATE batting 
SET hr = 101
WHERE yearid = 2013 AND masterid = 'aardsda01'

SELECT * FROM halloffame WHERE yearid=2013
ORDER BY masterid

-- Contstraint 6:
-- All players must have some salary, i.e., it cannot be null.
ALTER TABLE salaries
ALTER COLUMN salary SET NOT NULL;
-- Insertion/update/or delete to test the constraint
INSERT INTO salaries (yearid, teamid, lgid, masterid, salary)
VALUES (2025, 'BOS', 'AL', 'badnull01', NULL);


-- Constraint 7:
-- Every salaried person has a unique salary, teamid, and year combination.
ALTER TABLE salaries
ADD CONSTRAINT unique_salary_team_year
UNIQUE (masterid, salary, teamid, yearid);
-- Insertion/update/or delete to test the constraint
INSERT INTO salaries (yearid, teamid, masterid, salary)
VALUES (2024, 'NYA', 'unique01', 5000), (2024, 'NYA', 'unique01', 5000);
