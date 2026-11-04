namespace Football_Two.Models
{
    public class OddLine
    {
        public int gameId {  get; set; }
        public int linesByTeamId { get; set; }
        public int teamId { get; set; }
        public string teamName { get; set; }
        public int bookMakerId { get; set; }
        public string bookMakerTitle { get; set; }
        public DateTime datePublished { get; set; }
        public int price { get; set; }
        public decimal spread { get; set; }
        public string betType { get; set; }

        public string result { get; set; }

    }
}
