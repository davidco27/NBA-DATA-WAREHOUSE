from requests.models import parse_url
from nba_api.stats.static import players
from nba_api.stats.endpoints import commonplayerinfo
import requests 
import time
import sys
custom_headers = {
    'Host': 'stats.nba.com',
    'Connection': 'keep-alive',
    'Cache-Control': 'max-age=0',
    'Upgrade-Insecure-Requests': '1',
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'en-US,en;q=0.9',
}
headers = custom_headers#headers to call the nba stats API
results=""
f = open('playersAdded.txt', 'r+')#file containing the IDs of players already added
playersFile=f.read()
playerInformation = open('players.csv', 'a')
url = "https://stats.nba.com/stats/commonplayerinfo?LeagueID=&PlayerID="
player_dict=players.get_players()#obtaining a dictionary containing all players in NBA history
for player in player_dict:
    if str(player['id']) not in playersFile:#we check is the player has not already been added
        try:   
            response = commonplayerinfo.CommonPlayerInfo(player_id=player['id'],timeout=7).common_player_info#we call the API and if the API does not answer in 5 seconds it times out
            a = str(response.get_json())#obtain the json from the answer
            a = a.split('data": [[', 1)[1]#we remove the information we dont need and remove the commas to get information like a csv
            a = a.split("]]", 1)[0]
            a = a.replace('"', '')
            print(a)
            f.write(str(player['id']) + ",")#add the playerID so that it is not added again                
            playerInformation.write(a + "\n")#add the new row to the file
            time.sleep(0.5)#wait a second so the server dont block us
        except Exception as e:
            print(e)
            playerInformation.close()#we close the files
            f.close()
            sys.exit()