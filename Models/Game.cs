namespace Football_Two.Models
{
    public class Game
    {
        public int gameId { get; set; }
        public int visitingTeamId { get; set; }
        public string visitingTeamName { get; set; }
        public int homeTeamId { get; set; }
        public string homeTeamName { get; set; }
        public bool stadium {  get; set; }
        public DateOnly datePlayed { get; set; }
        public int dayOfWeek { get; set; }
        public int? visitingTeamScore { get; set; }
        public int? homeTeamScore { get; set; }
        public int scheduleWeek { get; set; }

        public Game()
        {
            visitingTeamScore = null;
            homeTeamScore = null;
        }
    }
}
