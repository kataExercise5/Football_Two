namespace Football_Two.Models
{
    public class Outcome
    {
        public string name { get; set; }
        public int price { get; set; }
        public decimal point { get; set; }

        public Outcome()
        {
            name = string.Empty;
            price = 0;
            point = 0;
        }
    }
}
