using Newtonsoft.Json;

namespace Football_Two.Models
{
    public class BettingLine
    {
        public string id { get; set; }
        public string sport_key { get; set; }
        public string sport_title { get; set; }
        public string commence_time { get; set; }
        public string home_team { get; set; }
        public string away_team { get; set; }

        [JsonProperty("bookmakers")]
        public Bookmaker[] bookmaker { get; set; }
    }
}
