using Newtonsoft.Json;

namespace Football_Two.Models
{
    public class Bookmaker
    {
        public string key { get; set; }
        public string title { get; set; }
        public string last_update { get; set; }

        [JsonProperty("markets")]
        public Market[] market { get; set; }
    }
}
