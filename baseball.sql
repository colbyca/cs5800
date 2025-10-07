--
-- Table structure for table allstarfull
--

CREATE TABLE allstarfull (
  masterID varchar(9) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  gameNum int NOT NULL DEFAULT '0',
  gameID varchar(12) DEFAULT NULL,
  teamID varchar(3) DEFAULT NULL,
  lgID varchar(2) DEFAULT NULL,
  GP int DEFAULT NULL,
  startingPos int DEFAULT NULL,
  PRIMARY KEY (masterID,yearID,gameNum)
);

--
-- Dumping data for table allstarfull
--

--
-- Table structure for table appearances
--

CREATE TABLE appearances (
  yearID int NOT NULL DEFAULT '0',
  teamID varchar(3) NOT NULL DEFAULT '',
  lgID varchar(2) DEFAULT NULL,
  masterID varchar(9) NOT NULL DEFAULT '',
  G_all int DEFAULT NULL,
  GS int DEFAULT NULL,
  G_batting int DEFAULT NULL,
  G_defense int DEFAULT NULL,
  G_p int DEFAULT NULL,
  G_c int DEFAULT NULL,
  G_1b int DEFAULT NULL,
  G_2b int DEFAULT NULL,
  G_3b int DEFAULT NULL,
  G_ss int DEFAULT NULL,
  G_lf int DEFAULT NULL,
  G_cf int DEFAULT NULL,
  G_rf int DEFAULT NULL,
  G_of int DEFAULT NULL,
  G_dh int DEFAULT NULL,
  G_ph int DEFAULT NULL,
  G_pr int DEFAULT NULL,
  PRIMARY KEY (yearID,teamID,masterID)
);

--
-- Dumping data for table appearances
--


--
-- Table structure for table awardsmanagers
--

CREATE TABLE awardsmanagers (
  masterID varchar(10) NOT NULL DEFAULT '',
  awardID varchar(75) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  lgID varchar(2) NOT NULL DEFAULT '',
  tie varchar(1) DEFAULT NULL,
  notes varchar(100) DEFAULT NULL,
  PRIMARY KEY (yearID,awardID,lgID,masterID)
);

--
-- Dumping data for table awardsmanagers
--


--
-- Table structure for table awardsplayers
--

CREATE TABLE awardsplayers (
  masterID varchar(9) NOT NULL DEFAULT '',
  awardID varchar(255) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  lgID varchar(2) NOT NULL DEFAULT '',
  tie varchar(1) DEFAULT NULL,
  notes varchar(100) DEFAULT NULL,
  PRIMARY KEY (yearID,awardID,lgID,masterID)
);

--
-- Dumping data for table awardsplayers
--


--
-- Table structure for table awardssharemanagers
--

CREATE TABLE awardssharemanagers (
  awardID varchar(25) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  lgID varchar(2) NOT NULL DEFAULT '',
  masterID varchar(10) NOT NULL DEFAULT '',
  pointsWon int DEFAULT NULL,
  pointsMax int DEFAULT NULL,
  votesFirst int DEFAULT NULL,
  PRIMARY KEY (awardID,yearID,lgID,masterID)
);

--
-- Dumping data for table awardssharemanagers
--


--
-- Table structure for table awardsshareplayers
--

CREATE TABLE awardsshareplayers (
  awardID varchar(25) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  lgID varchar(2) NOT NULL DEFAULT '',
  masterID varchar(9) NOT NULL DEFAULT '',
  pointsWon float DEFAULT NULL,
  pointsMax int DEFAULT NULL,
  votesFirst float DEFAULT NULL,
  PRIMARY KEY (awardID,yearID,lgID,masterID)
);

--
-- Dumping data for table awardsshareplayers
--


--
-- Table structure for table batting
--

CREATE TABLE batting (
  masterID varchar(9) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  stint int NOT NULL DEFAULT '0',
  teamID varchar(3) DEFAULT NULL,
  lgID varchar(2) DEFAULT NULL,
  G int DEFAULT NULL,
  G_batting int DEFAULT NULL,
  AB int DEFAULT NULL,
  R int DEFAULT NULL,
  H int DEFAULT NULL,
  twoB int DEFAULT NULL,
  threB int DEFAULT NULL,
  HR int DEFAULT NULL,
  RBI int DEFAULT NULL,
  SB int DEFAULT NULL,
  CS int DEFAULT NULL,
  BB int DEFAULT NULL,
  SO int DEFAULT NULL,
  IBB int DEFAULT NULL,
  HBP int DEFAULT NULL,
  SH int DEFAULT NULL,
  SF int DEFAULT NULL,
  GIDP int DEFAULT NULL,
  G_old int DEFAULT NULL,
  PRIMARY KEY (masterID,yearID,stint)
);

--
-- Dumping data for table batting
--

--
-- Table structure for table battingpost
--

CREATE TABLE battingpost (
  yearID int NOT NULL DEFAULT '0',
  round varchar(10) NOT NULL DEFAULT '',
  masterID varchar(9) NOT NULL DEFAULT '',
  teamID varchar(3) DEFAULT NULL,
  lgID varchar(2) DEFAULT NULL,
  G int DEFAULT NULL,
  AB int DEFAULT NULL,
  R int DEFAULT NULL,
  H int DEFAULT NULL,
  twoB int DEFAULT NULL,
  threeB int DEFAULT NULL,
  HR int DEFAULT NULL,
  RBI int DEFAULT NULL,
  SB int DEFAULT NULL,
  CS int DEFAULT NULL,
  BB int DEFAULT NULL,
  SO int DEFAULT NULL,
  IBB int DEFAULT NULL,
  HBP int DEFAULT NULL,
  SH int DEFAULT NULL,
  SF int DEFAULT NULL,
  GIDP int DEFAULT NULL,
  PRIMARY KEY (yearID,round,masterID)
);

--
-- Dumping data for table battingpost
--


--
-- Table structure for table fielding
--

CREATE TABLE fielding (
  masterID varchar(9) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  stint int NOT NULL DEFAULT '0',
  teamID varchar(3) DEFAULT NULL,
  lgID varchar(2) DEFAULT NULL,
  POS varchar(2) NOT NULL DEFAULT '',
  G int DEFAULT NULL,
  GS int DEFAULT NULL,
  InnOuts int DEFAULT NULL,
  PO int DEFAULT NULL,
  A int DEFAULT NULL,
  E int DEFAULT NULL,
  DP int DEFAULT NULL,
  PB int DEFAULT NULL,
  WP int DEFAULT NULL,
  SB int DEFAULT NULL,
  CS int DEFAULT NULL,
  ZR float DEFAULT NULL,
  PRIMARY KEY (masterID,yearID,stint,POS)
);

--
-- Dumping data for table fielding
--

--
-- Table structure for table fieldingof
--

CREATE TABLE fieldingof (
  masterID varchar(9) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  stint int NOT NULL DEFAULT '0',
  Glf int DEFAULT NULL,
  Gcf int DEFAULT NULL,
  Grf int DEFAULT NULL,
  PRIMARY KEY (masterID,yearID,stint)
);

--
-- Dumping data for table fieldingof
--

--
-- Table structure for table fieldingpost
--

CREATE TABLE fieldingpost (
  masterID varchar(9) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  teamID varchar(3) DEFAULT NULL,
  lgID varchar(2) DEFAULT NULL,
  round varchar(10) NOT NULL DEFAULT '',
  POS varchar(2) NOT NULL DEFAULT '',
  G int DEFAULT NULL,
  GS int DEFAULT NULL,
  InnOuts int DEFAULT NULL,
  PO int DEFAULT NULL,
  A int DEFAULT NULL,
  E int DEFAULT NULL,
  DP int DEFAULT NULL,
  TP int DEFAULT NULL,
  PB int DEFAULT NULL,
  SB int DEFAULT NULL,
  CS int DEFAULT NULL,
  PRIMARY KEY (masterID,yearID,round,POS)
);

--
-- Dumping data for table fieldingpost
--


--
-- Table structure for table halloffame
--

CREATE TABLE halloffame (
  masterID varchar(10) NOT NULL DEFAULT '',
  yearid int NOT NULL DEFAULT '0',
  votedBy varchar(64) NOT NULL DEFAULT '',
  ballots int DEFAULT NULL,
  needed int DEFAULT NULL,
  votes int DEFAULT NULL,
  inducted varchar(1) DEFAULT NULL,
  category varchar(20) DEFAULT NULL,
  needed_note varchar(25) DEFAULT NULL,
  PRIMARY KEY (masterID,yearid,votedBy)
);
--
-- Table structure for table managers
--

CREATE TABLE managers (
  masterID varchar(10) DEFAULT NULL,
  yearID int NOT NULL DEFAULT '0',
  teamID varchar(3) NOT NULL DEFAULT '',
  lgID varchar(2) DEFAULT NULL,
  inseason int NOT NULL DEFAULT '0',
  G int DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL,
  rank int DEFAULT NULL,
  plyrMgr varchar(1) DEFAULT NULL,
  PRIMARY KEY (yearID,teamID,inseason)
);
--
-- Table structure for table managershalf
--
CREATE TABLE managershalf (
  masterID varchar(10) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  teamID varchar(3) NOT NULL DEFAULT '',
  lgID varchar(2) DEFAULT NULL,
  inseason int DEFAULT NULL,
  half int NOT NULL DEFAULT '0',
  G int DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL,
  rank int DEFAULT NULL,
  PRIMARY KEY (yearID,teamID,masterID,half)
);
--
-- Dumping data for table managershalf
--

--
-- Table structure for table master
--

CREATE TABLE master (
  masterID varchar(10) NOT NULL,
  birthYear int DEFAULT NULL,
  birthMonth int DEFAULT NULL,
  birthDay int DEFAULT NULL,
  birthCountry varchar(50) DEFAULT NULL,
  birthState varchar(2) DEFAULT NULL,
  birthCity varchar(50) DEFAULT NULL,
  deathYear int DEFAULT NULL,
  deathMonth int DEFAULT NULL,
  deathDay int DEFAULT NULL,
  deathCountry varchar(50) DEFAULT NULL,
  deathState varchar(2) DEFAULT NULL,
  deathCity varchar(50) DEFAULT NULL,
  nameFirst varchar(50) DEFAULT NULL,
  nameLast varchar(50) DEFAULT NULL,
  nameGiven varchar(255) DEFAULT NULL,
  weight int DEFAULT NULL,
  height float DEFAULT NULL,
  bats varchar(1) DEFAULT NULL,
  throws varchar(1) DEFAULT NULL,
  debut timestamp DEFAULT NULL,
  finalGame timestamp DEFAULT NULL,
  retroID varchar(9) DEFAULT NULL,
  bbrefID varchar(9) DEFAULT NULL,
  PRIMARY KEY (masterID)
);

--
-- Dumping data for table master
--


--
-- Table structure for table pitching
--

CREATE TABLE pitching (
  masterID varchar(9) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  stint int NOT NULL DEFAULT '0',
  teamID varchar(3) DEFAULT NULL,
  lgID varchar(2) DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL,
  G int DEFAULT NULL,
  GS int DEFAULT NULL,
  CG int DEFAULT NULL,
  SHO int DEFAULT NULL,
  SV int DEFAULT NULL,
  IPouts int DEFAULT NULL,
  H int DEFAULT NULL,
  ER int DEFAULT NULL,
  HR int DEFAULT NULL,
  BB int DEFAULT NULL,
  SO int DEFAULT NULL,
  BAOpp float DEFAULT NULL,
  ERA float DEFAULT NULL,
  IBB int DEFAULT NULL,
  WP int DEFAULT NULL,
  HBP int DEFAULT NULL,
  BK int DEFAULT NULL,
  BFP int DEFAULT NULL,
  GF int DEFAULT NULL,
  R int DEFAULT NULL,
  SH int DEFAULT NULL,
  SF int DEFAULT NULL,
  GIDP int DEFAULT NULL,
  PRIMARY KEY (masterID,yearID,stint)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table pitching
--

/*!40000 ALTER TABLE pitching DISABLE KEYS */;

--
-- Table structure for table pitchingpost
--

CREATE TABLE pitchingpost (
  masterID varchar(9) NOT NULL DEFAULT '',
  yearID int NOT NULL DEFAULT '0',
  round varchar(10) NOT NULL DEFAULT '',
  teamID varchar(3) DEFAULT NULL,
  lgID varchar(2) DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL,
  G int DEFAULT NULL,
  GS int DEFAULT NULL,
  CG int DEFAULT NULL,
  SHO int DEFAULT NULL,
  SV int DEFAULT NULL,
  IPouts int DEFAULT NULL,
  H int DEFAULT NULL,
  ER int DEFAULT NULL,
  HR int DEFAULT NULL,
  BB int DEFAULT NULL,
  SO int DEFAULT NULL,
  BAOpp float DEFAULT NULL,
  ERA float DEFAULT NULL,
  IBB int DEFAULT NULL,
  WP int DEFAULT NULL,
  HBP int DEFAULT NULL,
  BK int DEFAULT NULL,
  BFP int DEFAULT NULL,
  GF int DEFAULT NULL,
  R int DEFAULT NULL,
  SH int DEFAULT NULL,
  SF int DEFAULT NULL,
  GIDP int DEFAULT NULL,
  PRIMARY KEY (masterID,yearID,round)
);

--
-- Dumping data for table pitchingpost
--

/*!40000 ALTER TABLE pitchingpost DISABLE KEYS */;
--
-- Table structure for table salaries
--
CREATE TABLE salaries (
  yearID int NOT NULL DEFAULT '0',
  teamID varchar(3) NOT NULL DEFAULT '',
  lgID varchar(2) NOT NULL DEFAULT '',
  masterID varchar(9) NOT NULL DEFAULT '',
  salary float DEFAULT NULL,
  PRIMARY KEY (yearID,teamID,lgID,masterID)
);
--
-- Dumping data for table salaries
--
--
-- Table structure for table schools
--
CREATE TABLE schools (
  schoolID varchar(15) NOT NULL,
  schoolName varchar(255) DEFAULT NULL,
  schoolCity varchar(55) DEFAULT NULL,
  schoolState varchar(55) DEFAULT NULL,
  schoolNick varchar(55) DEFAULT NULL,
  PRIMARY KEY (schoolID)
);
--
-- Dumping data for table schools
--
--
-- Table structure for table schoolsplayers
--
CREATE TABLE schoolsplayers (
  masterID varchar(9) NOT NULL DEFAULT '',
  schoolID varchar(15) NOT NULL DEFAULT '',
  yearMin int DEFAULT NULL,
  yearMax int DEFAULT NULL,
  PRIMARY KEY (masterID,schoolID)
);
--
-- Dumping data for table schoolsplayers
--
--
-- Table structure for table seriespost
--
CREATE TABLE seriespost (
  yearID int NOT NULL DEFAULT '0',
  round varchar(5) NOT NULL DEFAULT '',
  teamIDwinner varchar(3) DEFAULT NULL,
  lgIDwinner varchar(2) DEFAULT NULL,
  teamIDloser varchar(3) DEFAULT NULL,
  lgIDloser varchar(2) DEFAULT NULL,
  wins int DEFAULT NULL,
  losses int DEFAULT NULL,
  ties int DEFAULT NULL,
  PRIMARY KEY (yearID,round)
);
--
-- Dumping data for table seriespost
--
--
-- Table structure for table teams
--
CREATE TABLE teams (
  yearID int NOT NULL DEFAULT '0',
  lgID varchar(2) NOT NULL DEFAULT '',
  teamID varchar(3) NOT NULL DEFAULT '',
  franchID varchar(3) DEFAULT NULL,
  divID varchar(1) DEFAULT NULL,
  Rank int DEFAULT NULL,
  G int DEFAULT NULL,
  Ghome int DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL,
  DivWin varchar(1) DEFAULT NULL,
  WCWin varchar(1) DEFAULT NULL,
  LgWin varchar(1) DEFAULT NULL,
  WSWin varchar(1) DEFAULT NULL,
  R int DEFAULT NULL,
  AB int DEFAULT NULL,
  H int DEFAULT NULL,
  twoB int DEFAULT NULL,
  threeB int DEFAULT NULL,
  HR int DEFAULT NULL,
  BB int DEFAULT NULL,
  SO int DEFAULT NULL,
  SB int DEFAULT NULL,
  CS int DEFAULT NULL,
  HBP int DEFAULT NULL,
  SF int DEFAULT NULL,
  RA int DEFAULT NULL,
  ER int DEFAULT NULL,
  ERA float DEFAULT NULL,
  CG int DEFAULT NULL,
  SHO int DEFAULT NULL,
  SV int DEFAULT NULL,
  IPouts int DEFAULT NULL,
  HA int DEFAULT NULL,
  HRA int DEFAULT NULL,
  BBA int DEFAULT NULL,
  SOA int DEFAULT NULL,
  E int DEFAULT NULL,
  DP int DEFAULT NULL,
  FP float DEFAULT NULL,
  name varchar(50) DEFAULT NULL,
  park varchar(255) DEFAULT NULL,
  attendance int DEFAULT NULL,
  BPF int DEFAULT NULL,
  PPF int DEFAULT NULL,
  teamIDBR varchar(3) DEFAULT NULL,
  teamIDlahman45 varchar(3) DEFAULT NULL,
  teamIDretro varchar(3) DEFAULT NULL,
  PRIMARY KEY (yearID,lgID,teamID)
);
--
-- Dumping data for table teams
--

--
-- Table structure for table teamsfranchises
--
CREATE TABLE teamsfranchises (
  franchID varchar(3) NOT NULL,
  franchName varchar(50) DEFAULT NULL,
  active varchar(2) DEFAULT NULL,
  NAassoc varchar(3) DEFAULT NULL,
  PRIMARY KEY (franchID)
);
--
-- Dumping data for table teamsfranchises
--

--
-- Table structure for table teamshalf
--

CREATE TABLE teamshalf (
  yearID int NOT NULL DEFAULT '0',
  lgID varchar(2) NOT NULL DEFAULT '',
  teamID varchar(3) NOT NULL DEFAULT '',
  Half varchar(1) NOT NULL DEFAULT '',
  divID varchar(1) DEFAULT NULL,
  DivWin varchar(1) DEFAULT NULL,
  Rank int DEFAULT NULL,
  G int DEFAULT NULL,
  W int DEFAULT NULL,
  L int DEFAULT NULL,
  PRIMARY KEY (yearID,teamID,lgID,Half)
);

--
-- Dumping data for table teamshalf
--

