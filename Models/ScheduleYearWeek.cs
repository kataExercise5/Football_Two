namespace Football_Two.Models
{
    public class ScheduleYearWeek
    {
        public int year {  get; set; }
        public int week { get; set; }
        public DateTime startDate { get; set; }
        public DateTime endDate { get; set; }

        public DateTime datePublished { get; set; }
        public string datePubStr { get; set; }

        public int bookMakerId { get; set; }
    }
}
