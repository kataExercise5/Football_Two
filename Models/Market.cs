using Newtonsoft.Json;

namespace Football_Two.Models
{
    public class Market
    {
        [JsonProperty("key")]
        public string key { get; set; }
        public string last_update { get; set; }

        [JsonProperty("outcomes")]
        public Outcome[] outcomes { get; set; }
    }
}
