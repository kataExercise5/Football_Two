using Football_Two.Models;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Numerics;
using System.Web.Http;

namespace Football_Two.Services
{
    public class GetOdds : ApiController
    {
        public GetOdds() { }

        string queryString = "?apiKey=b4771ec8a0f4cc136b356b91482fb4d7&regions=us&markets=h2h,spreads&oddsFormat=american";

        string jsonResponse;
        List<BettingLine> bettingLines = new List<BettingLine>();

        DataAccess dataAccess = new DataAccess();

        private static HttpClient sharedClient = new()
        {
            BaseAddress = new Uri("https://api.the-odds-api.com/v4/sports/americanfootball_nfl/odds/")
        };

        public async Task<int> GetLatestOdds(int scheduleWeek = 1)
        {
            int rc = 0;

            await CallOddsApi();

            ParseApiResponse();

            PopulateRepository();

            return rc;
        }

        public async Task<int> CallOddsApi()
        {
            int rc = 0;
            try
            {
                using HttpResponseMessage response = await sharedClient.GetAsync(queryString);

                response.EnsureSuccessStatusCode();
                jsonResponse = await response.Content.ReadAsStringAsync();

                return rc;
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private void ParseApiResponse()
        {
            try
            {
                bettingLines = JsonConvert.DeserializeObject<List<BettingLine>>(jsonResponse);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        private void PopulateRepository()
        {
            foreach (BettingLine line in bettingLines) 
            {
                int gameId = GetGameId(line);
            }
        }

        private int GetGameId(BettingLine line)
        {
            int gameId = dataAccess.GameIdQuery(line.home_team, line.away_team, line.commence_time.Substring(0, 10));
            if (gameId == -1)
            {
                gameId = dataAccess.GameInsert(line.home_team, line.away_team, line.commence_time.Substring(0, 10));
            }
            return gameId;
        }
    }
}
