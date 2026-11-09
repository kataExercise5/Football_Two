using Football_Two.Models;
using Football_Two.Pages;
using System.Data;
using System.Data.SqlClient;

namespace Football_Two.Services
{
    public class AnalyzeDataService
    {
        private string localHostConnStr = "Server=localhost;Database=Football;Trusted_Connection=True;";

        public Task<DateOnly[]> DatePublishedQuery(ScheduleYearWeek scheduleYearWeek)
        {
            List<DateOnly> datesPublished = new List<DateOnly>();

            try
            {
                using (SqlConnection conn = new SqlConnection(localHostConnStr))
                {
                    SqlCommand cmd = new SqlCommand("DATE_PUBLISHED_QUERY", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@scheduleYear", scheduleYearWeek.year);
                    cmd.Parameters.AddWithValue("@scheduleWeek", scheduleYearWeek.week);

                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            DateOnly datePub = DateOnly.FromDateTime(Convert.ToDateTime(rdr.GetDateTime("datePub")));
                            datesPublished.Add(datePub);
                        }
                    }

                    rdr.Close();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            return Task.FromResult(datesPublished.ToArray());
        }

        public Task<Bookmaker[]> BookMakersQuery()
        {
            List<Bookmaker> bookMakers = new List<Bookmaker>();

            try
            {
                using (SqlConnection conn = new SqlConnection(localHostConnStr))
                {
                    SqlCommand cmd = new SqlCommand("BOOKMAKERS_QUERY", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            Bookmaker bookie = new Bookmaker();
                            bookie.bookMakerId = rdr.GetInt32("bookMakerId");
                            bookie.key = rdr.GetString("bookieKey");
                            bookie.title = rdr.GetString("bookieTitle");
                            bookMakers.Add(bookie);
                        }
                    }

                    rdr.Close();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            return Task.FromResult(bookMakers.ToArray());
        }

        public Task<Result[]> Head2HeadResults(ScheduleYearWeek scheduleYearWeek, int price)
        {
            List<Result> results = new List<Result>();

            try
            {
                using (SqlConnection conn = new SqlConnection(localHostConnStr))
                {
                    SqlCommand cmd = new SqlCommand("HEAD_2_HEAD_RESULTS_BY_BOOKIE", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@scheduledYear", scheduleYearWeek.year);
                    cmd.Parameters.AddWithValue("@scheduledWeek", scheduleYearWeek.week);
                    cmd.Parameters.AddWithValue("@datePublished", scheduleYearWeek.datePublished);
                    cmd.Parameters.AddWithValue("@price", price);

                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            Result result = new Result();
                            result.titleIdx = rdr.GetInt32("titleIdx");
                            result.title = rdr.GetString("title");
                            result.bookieName = rdr.GetString("bookieName");
                            result.winnings = rdr.GetDecimal("result");
                            results.Add(result);
                        }
                    }

                    rdr.Close();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            return Task.FromResult(results.ToArray());
        }

        public Task<Result[]> SpreadResults(ScheduleYearWeek scheduleYearWeek, decimal spread)
        {
            List<Result> results = new List<Result>();

            try
            {
                using (SqlConnection conn = new SqlConnection(localHostConnStr))
                {
                    SqlCommand cmd = new SqlCommand("SPREAD_RESULTS_BY_BOOKIE", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@scheduledYear", scheduleYearWeek.year);
                    cmd.Parameters.AddWithValue("@scheduledWeek", scheduleYearWeek.week);
                    cmd.Parameters.AddWithValue("@datePublished", scheduleYearWeek.datePublished);
                    cmd.Parameters.AddWithValue("@spread", spread);

                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            Result result = new Result();
                            result.titleIdx = rdr.GetInt32("titleIdx");
                            result.title = rdr.GetString("title");
                            result.bookieName = rdr.GetString("bookMaker");
                            result.winnings = rdr.GetDecimal("result");
                            results.Add(result);
                        }
                    }

                    rdr.Close();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            return Task.FromResult(results.ToArray());
        }
    }
}
