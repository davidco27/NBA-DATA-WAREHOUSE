import requests 
import time
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
headers = custom_headers#headers to call the nba stats API
standingsInformation = open('standings.csv', 'w')
standingsInformation.write("Season,LeagueID,SeasonID,TeamID,TeamCity,TeamName,Conference,ConferenceRecord,PlayoffRank,ClinchIndicator,Division,DivisionRecord,DivisionRank,WINS,LOSSES,WinPCT,LeagueRank,Record,HOME,ROAD\n")
url="https://stats.nba.com/stats/leaguestandings?LeagueID=00&SeasonType=Regular+Season&SeasonYear=&Season="
for i in range(2000,2022):
    try:
        nextYear=str(i+1)
        year=str(i)
        season = year+"-"+nextYear[-2:]    
        final_url = url + season
        response = requests.get(final_url,headers=headers,timeout=5)#we call the API and if the API does not answer in 5 seconds it times out
        if response.status_code != 200:#error code
            print('Error code : %i' % response.status_code)
        else:
            a = str(response.json())#obtain the json from the answer
            a = a.split("rowSet': [[", 1)[1]#we remove the information we dont need and remove the commas to get information like a csv
            a = a.split("]]", 1)[0]
            a = a.replace("'", '')
            a=a.split("], [")
            for team in a:
                teams=team.split(",")
                line=",".join(teams[0:19]).replace(" ","")
                standingsInformation.write(season+","+line+"\n")
            time.sleep(0.5) 
    except Exception as e:
        print(e)
        standingsInformation.close()#we close the file