CREATE TABLE GAMES_DATA_LAKE(
 GAME_DATE_EST DATE,
	GAME_ID INTEGER,
	GAME_STATUS_TEXT VARCHAR(20),
	HOME_TEAM_ID INTEGER,
	VISITOR_TEAM_ID INTEGER,
	SEASON INTEGER,
	TEAM_ID_home INTEGER,
	PTS_home NUMERIC(4,1),
	FG_PCT_home NUMERIC(4,3),
	FT_PCT_home NUMERIC(4,3),
	FG3_PCT_home NUMERIC(4,3),
	AST_home NUMERIC(4,1),
	REB_home NUMERIC(4,1),
	TEAM_ID_away INTEGER,
	PTS_away NUMERIC(4,1),
	FG_PCT_away NUMERIC(4,3),
	FT_PCT_away NUMERIC(4,3),
	FG3_PCT_away NUMERIC(4,3),
	AST_away NUMERIC(4,1),
	REB_away NUMERIC(4,1),
	HOME_TEAM_WINS INTEGER
)
COPY GAMES_DATA_LAKE(GAME_DATE_EST,GAME_ID,GAME_STATUS_TEXT,HOME_TEAM_ID,VISITOR_TEAM_ID,SEASON,TEAM_ID_home,PTS_home,FG_PCT_home,FT_PCT_home,FG3_PCT_home,AST_home,REB_home,TEAM_ID_away,PTS_away,FG_PCT_away,FT_PCT_away,FG3_PCT_away,AST_away,REB_away,HOME_TEAM_WINS)
FROM 'C:\Users\david\Downloads\TermProject\archive\games.csv'
DELIMITER ','
CSV HEADER;

GAMES DETAILS
CREATE TABLE GAMES_DETAILS_DATA_LAKE(
GAME_ID INTEGER,
TEAM_ID INTEGER,
TEAM_ABBREVIATION VARCHAR(5),
TEAM_CITY VARCHAR(25),
PLAYER_ID INTEGER),
PLAYER_NAME VARCHAR(50),
START_POSITION VARCHAR(2),
COMMENT VARCHAR(40),
MIN VARCHAR(5),
FGM NUMERIC(4,1),
FGA NUMERIC(4,1),
FG_PCT NUMERIC(4,3),
FG3M NUMERIC(4,1),
FG3A NUMERIC(4,1),
FG3_PCT NUMERIC(4,3),
FTM NUMERIC(4,1),
FTA NUMERIC(4,1),
FT_PCT NUMERIC(4,3),
OREB NUMERIC(4,1),
DREB NUMERIC(4,1),
REB NUMERIC(4,1),
AST NUMERIC(4,1),
STL NUMERIC(4,1),
BLK NUMERIC(4,1),
TURNOVERS NUMERIC(4,1),
PF NUMERIC(4,1),
PTS NUMERIC(4,1),
PLUS_MINUS NUMERIC(4,1))
COPY GAMES_DETAILS_DATA_LAKE(GAME_ID,TEAM_ID,TEAM_ABBREVIATION,TEAM_CITY,PLAYER_ID,PLAYER_NAME,START_POSITION,COMMENT,MIN,FGM,FGA,FG_PCT,FG3M,FG3A,FG3_PCT,FTM,FTA,FT_PCT,OREB,DREB,REB,AST,STL,BLK,TURNOVERS,PF,PTS,PLUS_MINUS)
FROM 'C:\Users\david\Downloads\TermProject\archive\games_details.csv'
DELIMITER ','
CSV HEADER;

PLAYERS
CREATE TABLE players_data_lake
(player_id bigint,
    first_name varchar(30),
    last_name varchar(30),
    display_first_last varchar(50),
    display_last_comma_first varchar(50),
  display_last_comma_first2 varchar(50),
    display_fi_last varchar(30),
    player_slug varchar(50),
    birthdate date,
    school varchar(50),
    country varchar(30),
    last_affiliation varchar(50),
    height varchar(10),
    weight varchar(10),
    season_exp int,
    jersey varchar(8),
    position varchar(15),
    rosterstatus varchar(10),
    games_played_current_season_flag varchar(1),
    team_id bigint,
    team_name varchar(15),
    team_abbreviation varchar(4),
    team_code varchar(15),
    team_city varchar(30),
    playercode varchar(50),
    from_year varchar(10),
    to_year varchar(10),
    dleague_flag varchar(1),
    nba_flag varchar(1),
    games_played_flag varchar(1),
    draft_year varchar(10),
    draft_round varchar(10),
    draft_number varchar(10),
    greatest_75_flag varchar(2)
);
COPY players_data_lake(PLAYER_ID,FIRST_NAME,LAST_NAME,DISPLAY_FIRST_LAST,DISPLAY_LAST_COMMA_FIRST,DISPLAY_LAST_COMMA_FIRST2,DISPLAY_FI_LAST,PLAYER_SLUG,BIRTHDATE,SCHOOL,COUNTRY,LAST_AFFILIATION,HEIGHT,WEIGHT,SEASON_EXP,JERSEY,POSITION,ROSTERSTATUS,GAMES_PLAYED_CURRENT_SEASON_FLAG,TEAM_ID,TEAM_NAME,TEAM_ABBREVIATION,TEAM_CODE,TEAM_CITY,PLAYERCODE,FROM_YEAR,TO_YEAR,DLEAGUE_FLAG,NBA_FLAG,GAMES_PLAYED_FLAG,DRAFT_YEAR,DRAFT_ROUND,DRAFT_NUMBER,GREATEST_75_FLAG)
FROM 'C:\Users\david\Downloads\TermProject\data\players.csv'
DELIMITER ','
CSV HEADER;

STANDINGS
CREATE TABLE standings_data_lake
(season varchar(10),
    leagueid int,
    seasonid bigint,
    teamid bigint,
    teamcity varchar(30),
    teamname varchar(20),
    conference varchar(4),
    conferencerecord varchar(6),
    playoffrank int,
    clinchindicator varchar(4),
    division varchar(12),
    divisionrecord varchar(6),
    divisionrank varchar(4),
    wins int,
    losses int,
    winpct double precision,
    leaguerank varchar(4),
    record varchar(6),
    home varchar(6),
    road varchar(6))
COPY standings_data_lake(Season,LeagueID,SeasonID,TeamID,TeamCity,TeamName,Conference,ConferenceRecord,PlayoffRank,ClinchIndicator,Division,DivisionRecord,DivisionRank,WINS,LOSSES,WinPCT,LeagueRank,Record,HOME,ROAD)
FROM 'C:\Users\david\Downloads\TermProject\data\standings.csv'
DELIMITER ','


TEAMS
CREATE TABLE teams_data_lake(
LEAGUE_ID bigint,
TEAM_ID bigint,
MIN_YEAR int,
MAX_YEAR int,
ABBREVIATION varchar(4),
NICKNAME varchar(20),
YEARFOUNDED int,
CITY varchar(30),
ARENA varchar(40),
ARENACAPACITY int,
OWNER varchar(40),
GENERALMANAGER varchar(40),
HEADCOACH varchar(40),
DLEAGUEAFFILIATION varchar(40),
CONFERENCE varchar(5)
);
COPY teams_data_lake(LEAGUE_ID,TEAM_ID,MIN_YEAR,MAX_YEAR,ABBREVIATION,NICKNAME,YEARFOUNDED,CITY,ARENA,ARENACAPACITY,OWNER,GENERALMANAGER,HEADCOACH,DLEAGUEAFFILIATION,CONFERENCE)
FROM 'C:\Users\david\Downloads\TermProject\data\teams.csv'
DELIMITER ','
CSV HEADER;





CREATING AND POPULATING DIMENSION TABLES
TEAMS
CREATE TABLE teams_dimension(
TEAM_ID bigint PRIMARY KEY,
NICKNAME varchar(20),
CITY varchar(30),
CONFERENCE varchar(5),
OWNER varchar(40),
GENERALMANAGER varchar(40),
HEADCOACH varchar(40),
ARENA varchar(30)
);
INSERT INTO teams_dimension
SELECT TEAM_ID,NICKNAME,CITY,CONFERENCE,OWNER,GENERALMANAGER,HEADCOACH,ARENA
FROM teams_data_lake


PLAYERS
Transformation:
In columns draft_round, draft_number,draft_year these are all integers but I had to import it as text because if the player was undrafted, the value is either “null” or “Undrafted”. We want to have this columns as integers because we may want do a query using average pick position for example. So we should set as null the values for these undrafted players so that we can use integers for these columns.
UPDATE PLAYERS_DATA_LAKE SET DRAFT_ROUND=NULL,DRAFT_NUMBER=NULL WHERE DRAFT_NUMBER='null' or DRAFT_NUMBER='Undrafted';
UPDATE PLAYERS_DATA_LAKE SET DRAFT_YEAR=NULL  WHERE DRAFT_YEAR='Undrafted';
Also there is a column where the name appears as FirstNameLastName but we want to include a space between the First and Last Name so that is more legible.
UPDATE PLAYERS_DATA_LAKE SET DISPLAY_FIRST_LAST=CONCAT_WS(' ',FIRST_NAME,LAST_NAME)

CREATE TABLE players_dimension
(player_id bigint NOT NULL PRIMARY KEY,
  player_first_name varchar(30)NOT NULL,
 player_first_name_prev varchar(30),
  player_last_name varchar(30) NOT NULL,
 player_last_name_prev varchar(30),
    player_full_name varchar(50)NOT NULL,
 player_full_name_prev varchar(50),
 date_of_birth date NOT NULL,
 school varchar(50),
 country varchar(30) NOT NULL,
 height varchar(10),
 weight varchar(10),
 position varchar(15),
 draft_year int,
 draft_round int,
 draft_number int)
 
 INSERT INTO players_dimension(player_id,player_first_name,player_last_name,player_full_name,date_of_birth,school,country,
 height,weight,position,draft_year,draft_round,draft_number)
 SELECT player_id,first_name,last_name,display_first_last,birthdate,school,country,
 height,weight,position,CAST (draft_year AS INTEGER),CAST (draft_round AS INTEGER),CAST (draft_number AS INTEGER) 
 from players_data_lake

GAMES
CREATE TABLE GAMES_DIMENSION(
game_id bigint not null PRIMARY KEY,
date_played date not null,
venue varchar(40) not null,
game_status varchar(20) not null);
INSERT INTO GAMES_DIMENSION
SELECT DISTINCT ON (game_id) game_id,game_date_est,arena,game_status_text
FROM GAMES_DATA_LAKE
JOIN TEAMS_DIMENSION ON TEAMS_DIMENSION.TEAM_ID = GAMES_DATA_LAKE.TEAM_ID_HOME

SEASONS
We load the seasons from the standings data lake:
CREATE TABLE SEASONS_DIMENSION(
season_id bigint not null PRIMARY KEY,
from_year int not null,
to_year	int not null);
INSERT INTO SEASONS_DIMENSION
SELECT DISTINCT ON (SEASONID) SEASONID,CAST(SUBSTRING(SEASON,1,4) AS INTEGER),CAST(SUBSTRING(SEASON,1,4) AS INTEGER)+1
FROM STANDINGS_DATA_LAKE

CREATING AND POPULATING FACT TABLES
STANDINGS
CREATE TABLE STANDINGS_FACT_TABLE
(team_id bigint,
 season_id bigint,
 wins integer not null,
 losses integer not null,
 winPctg double precision,
 homeRecord varchar(5),
 roadRecord varchar(5),
 conferenceRank int,
 PRIMARY KEY(team_id,season_id),
 FOREIGN KEY(team_id) REFERENCES TEAMS_DIMENSION(team_id),
 FOREIGN KEY(season_id) REFERENCES SEASONS_DIMENSION(season_id)
);
 
 INSERT INTO STANDINGS_FACT_TABLE(TEAM_ID,SEASON_ID,WINS,LOSSES,WINPCTG,HOMERECORD,ROADRECORD,CONFERENCERANK)
 SELECT TEAMID,SEASONID,WINS,LOSSES,WINPCT,HOME,ROAD,PLAYOFFRANK
 FROM STANDINGS_DATA_LAKE;


PLAYER_GAME_BOXSCORE
CREATE TABLE PLAYER_GAME_BOXSCORE(
GAME_ID BIGINT,
TEAM_ID BIGINT,
PLAYER_ID BIGINT,
MIN INTEGER,
PTS INTEGER,
REB INTEGER,
AST INTEGER,
STL INTEGER,
BLK INTEGER,
FGM INTEGER,
FGA INTEGER,
FG3M INTEGER,
FG3A INTEGER,
FTM INTEGER,
FTA INTEGER,
PRIMARY KEY(GAME_ID,TEAM_ID,PLAYER_ID),
FOREIGN KEY(GAME_ID) REFERENCES GAMES_DIMENSION(GAME_ID),
FOREIGN KEY(TEAM_ID) REFERENCES TEAMS_DIMENSION(TEAM_ID),
FOREIGN KEY(PLAYER_ID) REFERENCES PLAYERS_DIMENSION(PLAYER_ID));
INSERT INTO PLAYER_GAME_BOXSCORE
SELECT DISTINCT ON (game_id,team_id,player_id) game_id,team_id,player_id,CAST (SUBSTRING (MIN,1,POSITION(':' IN MIN)-1) AS INTEGER), CAST(PTS AS INTEGER),CAST(REB AS INTEGER)
,CAST(AST AS INTEGER),CAST(STL AS INTEGER),CAST(BLK AS INTEGER),CAST(FGM AS INTEGER),CAST(FGA AS INTEGER),CAST(FG3M AS INTEGER),
CAST(FG3A AS INTEGER),CAST(FTM AS INTEGER),CAST(FTA AS INTEGER)
FROM GAMES_DETAILS_DATA_LAKE WHERE POSITION(':' IN MIN)>1

TEAM GAME BOXSCORE
CREATE TABLE TEAM_GAME_BOXSCORE_FACT_TABLE(
GAME_ID BIGINT,
TEAM_ID BIGINT,
PTS INTEGER,
REB INTEGER,
AST INTEGER,
FGPCT NUMERIC(4,3),
FG3PCT NUMERIC(4,3),
FTPCT NUMERIC(4,3),
HOME_TEAM_FLAG INTEGER,
WIN_FLAG INTEGER,
PRIMARY KEY(GAME_ID,TEAM_ID),
FOREIGN KEY(GAME_ID) REFERENCES GAMES_DIMENSION(GAME_ID),
FOREIGN KEY(TEAM_ID) REFERENCES TEAMS_DIMENSION(TEAM_ID));
INSERT INTO TEAM_GAME_BOXSCORE_FACT_TABLE
SELECT DISTINCT ON (game_id,home_team_id) game_id,home_team_id,CAST(pts_home AS INTEGER),CAST(reb_home AS INTEGER)
,CAST(ast_home AS INTEGER),FG_PCT_HOME,FG3_PCT_HOME,FT_PCT_HOME,1,HOME_TEAM_WINS
FROM GAMES_DATA_LAKE 
INSERT INTO TEAM_GAME_BOXSCORE_FACT_TABLE
SELECT DISTINCT ON (game_id,home_team_id) game_id,visitor_team_id,CAST(pts_away AS INTEGER),CAST(reb_away AS INTEGER)
,CAST(ast_away AS INTEGER),FG_PCT_AWAY,FG3_PCT_AWAY,FT_PCT_AWAY,0,0
FROM GAMES_DATA_LAKE WHERE HOME_TEAM_WINS=1
INSERT INTO TEAM_GAME_BOXSCORE_FACT_TABLE
SELECT DISTINCT ON (game_id,home_team_id) game_id,visitor_team_id,CAST(pts_away AS INTEGER),CAST(reb_away AS INTEGER)
,CAST(ast_away AS INTEGER),FG_PCT_AWAY,FG3_PCT_AWAY,FT_PCT_AWAY,0,1
FROM GAMES_DATA_LAKE WHERE HOME_TEAM_WINS=0

TEAM SEASON BOXSCORE
CREATE TABLE TEAM_SEASON_BOXSCORE_FACT_TABLE(
SEASON_ID BIGINT,
TEAM_ID BIGINT,
PPG INTEGER,
RPG INTEGER,
APG INTEGER,
PRIMARY KEY(SEASON_ID,TEAM_ID),
FOREIGN KEY(SEASON_ID) REFERENCES SEASONS_DIMENSION(SEASON_ID),
FOREIGN KEY(TEAM_ID) REFERENCES TEAMS_DIMENSION(TEAM_ID));
INSERT INTO TEAM_SEASON_BOXSCORE_FACT_TABLE
SELECT (SELECT SEASON_ID FROM SEASONS_DIMENSION WHERE FROM_YEAR=GAMES_DATA_LAKE.SEASON),TEAM_ID,AVG(PTS),AVG(REB),AVG(AST)
FROM TEAM_GAME_BOXSCORE_FACT_TABLE 
JOIN GAMES_DATA_LAKE ON TEAM_GAME_BOXSCORE_FACT_TABLE.GAME_ID=GAMES_DATA_LAKE.GAME_ID
GROUP BY SEASON_ID,TEAM_ID

PLAYER SEASON BOXSCORE
Here we had to use COALESCE and NULLIF functions to avoid dividing by 0 in those cases where the player has not attempted a FG,FT or three.



CREATE TABLE PLAYER_SEASON_BOXSCORE(
SEASON_ID BIGINT,
PLAYER_ID BIGINT,
TEAM_ID BIGINT,
MINPG NUMERIC(3,1),
PPG NUMERIC(3,1),
RPG NUMERIC(3,1),
APG NUMERIC(3,1),
SGP NUMERIC(3,1),
BPG NUMERIC(3,1),
FGPCT NUMERIC(4,3),
FTPCT NUMERIC(4,3),
F3PCT NUMERIC(4,3),
F3PM INTEGER,
PRIMARY KEY(SEASON_ID,TEAM_ID,PLAYER_ID),
FOREIGN KEY(SEASON_ID) REFERENCES SEASONS_DIMENSION(SEASON_ID),
FOREIGN KEY(TEAM_ID) REFERENCES TEAMS_DIMENSION(TEAM_ID),
FOREIGN KEY(PLAYER_ID) REFERENCES PLAYERS_DIMENSION(PLAYER_ID));
INSERT INTO PLAYER_SEASON_BOXSCORE
SELECT (SELECT SEASON_ID FROM SEASONS_DIMENSION WHERE FROM_YEAR=GAMES_DATA_LAKE.SEASON),player_id,team_id,AVG(MIN),AVG(PTS),AVG(AST),AVG(REB),AVG(STL),AVG(BLK),
COALESCE(CAST(SUM(FGM) AS FLOAT)/(NULLIF(SUM(FGA),0)),0),COALESCE(CAST(SUM(FTM) AS FLOAT)/(NULLIF(SUM(FTA),0)),0),COALESCE(
CAST(SUM(FG3M) AS FLOAT)/(NULLIF(SUM(FG3A),0)),0),SUM(FG3M)
FROM PLAYER_GAME_BOXSCORE JOIN GAMES_DATA_LAKE ON PLAYER_GAME_BOXSCORE.GAME_ID=GAMES_DATA_LAKE.GAME_ID
GROUP BY season_id,team_id,player_id


CREATE OR REPLACE FUNCTION update_individual_stats()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE
BEGIN
	 UPDATE PLAYER_SEASON_BOXSCORE 
	 SET MINPG= A.MIN,PPG=A.PTS,APG=A.AST,RPG=A.REB,
	 SGP=A.STL,BPG=A.BLK,FGPCT=A.FGPCT,FTPCT=A.FTPCT,F3PCT=A.F3PCT,F3PM=A.F3M
	 FROM PLAYER_SEASON_BOXSCORE P
	 INNER JOIN
	 (
		 SELECT  SEASON,NEW.PLAYER_ID,
		 AVG(MIN) AS MIN,AVG(PTS) AS PTS,AVG(AST) AS AST,AVG(REB) AS REB,AVG(STL) AS STL,AVG(BLK) AS BLK,
	 COALESCE(CAST(SUM(FGM) AS FLOAT)/(NULLIF(SUM(FGA),0)),0) AS FGPCT,
		 COALESCE(CAST(SUM(FTM) AS FLOAT)/(NULLIF(SUM(FTA),0)),0) AS FTPCT,
	 COALESCE(CAST(SUM(FG3M) AS FLOAT)/(NULLIF(SUM(FG3A),0)),0) AS F3PCT,SUM(FG3M) AS F3M
 FROM PLAYER_GAME_BOXSCORE JOIN GAMES_DIMENSION ON PLAYER_GAME_BOXSCORE.GAME_ID=GAMES_DIMENSION.GAME_ID
WHERE PLAYER_GAME_BOXSCORE.PLAYER_ID=NEW.PLAYER_ID AND PLAYER_GAME_BOXSCORE.TEAM_ID=NEW.TEAM_ID AND 
extract(year from games_dimension.date_played)=2021  AND extract(month from games_dimension.date_played)>9
		 GROUP BY NEW.PLAYER_ID,NEW.TEAM_ID,SEASON
   ) A ON P.PLAYER_ID=A.PLAYER_ID
   WHERE P.PLAYER_ID=NEW.PLAYER_ID AND P.TEAM_ID=NEW.TEAM_ID
   AND P.SEASON_ID=A.SEASON;
	RETURN NEW;
END;
CREATE TRIGGER update_individual_stats
  AFTER INSERT OR UPDATE OR DELETE
  ON player_game_boxscore
  FOR EACH ROW
  EXECUTE PROCEDURE update_individual_stats();

TEAMS_SEASON_BOXSCORE
CREATE OR REPLACE FUNCTION update_team_stats()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE
BEGIN
	 UPDATE TEAM_SEASON_BOXSCORE_FACT_TABLE
	 SET PPG=A.PTS,APG=A.AST,RPG=A.REB
	 FROM TEAM_SEASON_BOXSCORE_FACT_TABLE P
	 INNER JOIN
	 (
		 SELECT  SEASON,NEW.TEAM_ID,
		 AVG(PTS) AS PTS,AVG(AST) AS AST,AVG(REB) AS REB
 FROM TEAM_GAME_BOXSCORE_FACT_TABLE JOIN GAMES_DIMENSION ON TEAM_GAME_BOXSCORE_FACT_TABLE.GAME_ID=GAMES_DIMENSION.GAME_ID
WHERE TEAM_GAME_BOXSCORE_FACT_TABLE.TEAM_ID=NEW.TEAM_ID AND extract(year from games_dimension.date_played)=2021  
		 AND extract(month from games_dimension.date_played)>9
		 GROUP BY NEW.TEAM_ID,SEASON
   ) A ON P.TEAM_ID=A.TEAM_ID
   WHERE P.TEAM_ID=NEW.TEAM_ID AND P.SEASON_ID=A.SEASON;
	RETURN NEW;
END;
$$;
CREATE TRIGGER update_team_stats
  AFTER INSERT OR UPDATE OR DELETE
  ON team_game_boxscore_fact_table
  FOR EACH ROW
  EXECUTE PROCEDURE update_team_stats();

