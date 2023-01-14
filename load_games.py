import requests 
from sqlalchemy import create_engine,Table, select
from datetime import date,timedelta
from sqlalchemy.ext.automap import automap_base
from nba_api.stats.endpoints import commonplayerinfo
import pandas as pd
def add_player(player):
    respons= commonplayerinfo.CommonPlayerInfo(player_id=player,timeout=7).common_player_info#we call the API and if the
    a = str(respons.get_json())#obtain the json from the answer
    a = a.split('data": [[', 1)[1]#we remove the information we dont need and remove the commas to get information like a csv
    a = a.split("]]", 1)[0]
    a = a.replace('"', '').replace(" ","")
    a=a.split(",")
    players_add.append(a[0]+","+a[1]+",,"+a[2]+",,"+a[1]+" "+a[2]+",,"+a[8]+","+a[9]+","+a[10]+","+a[12]+","+a[13]+","+a[16]+","+a[30]+","+a[31]+","+a[32])
custom_headers = {
    'Host': 'stats.nba.com',
    'Referer': 'https://stats.nba.com',
    'Origin': 'https://stats.nba.com',
    'x-nba-stats-token': 'true',
    'x-nba-stats-origin': 'stats',
    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36',
    'Accept': 'application/json, text/plain, */*',
    'Accept-Language': 'en-GB,en;q=0.5',
    'Accept-Encoding': 'gzip, deflate, br',
    'X-NewRelic-ID': 'VQECWF5UChAHUlNTBwgBVw==',
    'Cache-Control': 'max-age=0'
}

playersids=[]
players_add=['player_id,player_first_name,player_first_name_prev,player_last_name,player_last_name_prev,player_full_name,'
'player_full_name_prev,date_of_birth,school,country,height,weight,position,draft_year,draft_round,draft_number']
engine = create_engine('postgresql://postgres:iswclouset@localhost:5432/postgres')
conn= engine.connect()
Base = automap_base()
Base.prepare(engine, reflect=True)

players = Table('players_dimension', Base.metadata,
                    autoload=True, autoload_with=engine)
s=select(players.c.player_id)
result = conn.execute(s)
for row in result:
    playersid=str(row)
    playersids.append(playersid[1:len(playersid)-2])
f=open('player_boxscore.csv','w')
g=open('games.csv','w')
h=open('scoreboards.csv','w')
t=open('players.csv','w')
headers = custom_headers#headers to call the nba stats API
player_boxscores=['PLAYER_ID,TEAM_ID,GAME_ID,MIN,PTS,REB,AST,BLK,STL,FGM,FGA,FTM,FTA,FG3M,FG3A']
games=['GAME_ID,DATE_PLAYED,VENUE,GAME_STATUS']
gamesids=[]
scoreboards=['GAME_ID,TEAM_ID,PTS,REB,AST,FGPCT,FTPCT,FG3PCT,HOME_TEAM_FLAG,WIN_FLAG']
yesterday=date.today()-timedelta(days = 1)

url="https://stats.nba.com/stats/scoreboardV2?DayOffset=0&LeagueID=00&gameDate="+yesterday.strftime("%Y/%m/%d")
url2="https://stats.nba.com/stats/boxscoretraditionalv2?EndPeriod=1&EndRange=0&RangeType=0&StartPeriod=1&StartRange=0&GameID="
response = requests.get(url,headers=headers,timeout=5)#we call the API and if the API does not answer 
if response.status_code != 200:#error code
    print('Error code : %i' % response.status_code)
else:
    a=str(response.json()).replace("'","").split("rowSet: [[", 1)[1]
    first_data = a.split("]]")[0]
    first_data =first_data.split("], [")
for team in first_data:
    features=team.replace(" ","").split(",")
    gamesids.append(features[2])
    games.append(features[2]+","+features[0]+","+features[15]+","+features[4])   
second_data = a.split("rowSet: [[", 1)[1]
second_data = second_data.split("]]")[0]
second_data =second_data.split("], [")
for i in range(0,len(second_data)):
    if(i%2!=0):
        features_away=second_data[i-1].replace(" ","").split(",")
        features_home=second_data[i].replace(" ","").split(",")
        if int(features_away[22])>int(features_home[22]):
           away_team_win=1
           home_team_win=0
        else:
           away_team_win=0 
           home_team_win=1  
        scoreboards.append(features_away[2]+","+features_away[3]+","+features_away[22]+","+features_away[26]+","+features_away[27]+","+features_away[23]+","+features_away[24]+","+features_away[25]+",0,"+str(away_team_win))
        scoreboards.append(features_home[2]+","+features_home[3]+","+features_home[22]+","+features_home[26]+","+features_home[27]+","+features_home[23]+","+features_home[24]+","+features_home[25]+",1,"+str(home_team_win))
for gameid in gamesids:
    final_url = url2+gameid
    resp = requests.get(final_url,headers=headers,timeout=6)#we call the API and if the API does not answer in 5 seconds it times out
    if resp.status_code != 200:#error code
        print('Error code : %i' % response.status_code)
    else:
        a=str(resp.json()).replace("'","").split("rowSet: [[", 1)[1]
        players = a.split("]]")[0]
        players=players.split("], [")
        for player in players:
            stats=player.replace(" ","").split(",")
            if stats[9]!="None":
                if (not ("'"+stats[4]+"'") in str(playersids)):
                   add_player(stats[4])   
                player_boxscores.append(stats[4]+","+stats[1]+","+stats[0]+","+stats[9].split(":")[0]+","+stats[27]+","+stats[21]+","+stats[22]+","
            +stats[23]+","+stats[24]+","+stats[10]+","+stats[11]+","+stats[16]+","+stats[17]+","+stats[13]+","+stats[14]) 
boxscores='\n'.join(player_boxscores)
scores='\n'.join(scoreboards)
gameday='\n'.join(games)
if(len(players_add)>1):
    players_to_files='\n'.join(players_add)
    print(players_to_files)
    t.write(players_to_files)
    t.close()
    df = pd.read_csv('players.csv')
    df.columns = [c.lower() for c in df.columns]
    df.to_sql("players_dimension", engine,if_exists='append',index=None)
f.write(boxscores)
h.write(scores)
g.write(gameday)
f.close()
h.close()
g.close()
df = pd.read_csv('games.csv')
df.columns = [c.lower() for c in df.columns]
df.to_sql("games_dimension", engine,if_exists='append',index=None)
df = pd.read_csv('player_boxscore.csv')
df.columns = [c.lower() for c in df.columns]
df.to_sql("player_game_boxscore", engine,if_exists='append',index=None)
df = pd.read_csv('scoreboards.csv')
df.columns = [c.lower() for c in df.columns]
df.to_sql("team_game_boxscore_fact_table", engine,if_exists='append',index=None)