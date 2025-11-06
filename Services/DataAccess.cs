using Football_Two.Models;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace Football_Two.Services
{
    public class DataAccess
    {
        private string localHostConnStr = "Server=localhost;Database=Football;Trusted_Connection=True;";

        public Task<Game[]> GameQuery(int scheduleWeek=99)
        {
            List<Game> games = new List<Game>();
            try
            {
                using (SqlConnection conn = new SqlConnection(localHostConnStr))
                {
                    SqlCommand cmd = new SqlCommand("GAME_QUERY", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@scheduleWeek", scheduleWeek);

                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            Game game = new Game();
                            game.gameId = rdr.GetInt32("gameId");
                            game.visitingTeamId = rdr.GetInt32("visitingTeamId");
                            game.visitingTeamName = rdr.GetString("visitingTeamName");
                            game.homeTeamId = rdr.GetInt32("homeTeamId");
                            game.homeTeamName = rdr.GetString("homeTeamName");
                            game.stadium = rdr.GetBoolean("stadium");
                            game.datePlayed = DateOnly.FromDateTime(Convert.ToDateTime(rdr.GetDateTime("datePlayed")));
                            game.dayOfWeek = rdr.GetInt16("dayOfWeek");

                            if (!(rdr.IsDBNull("visitingTeamScore")))
                            {
                                game.visitingTeamScore = rdr.GetInt16("visitingTeamScore");
                            }
                            if (!(rdr.IsDBNull("homeTeamScore")))
                            {
                                game.homeTeamScore = rdr.GetInt16("homeTeamScore");
                            }

                            game.scheduleWeek = rdr.GetInt16("scheduleWeek");

                            games.Add(game);
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
            return Task.FromResult(games.ToArray());
        }

        public int GameIdQuery(string homeTeam, string visitingTeam, DateTime datePlayed)
        {
            int gameId = -1;
            try
            {
                using (SqlConnection conn = new SqlConnection(localHostConnStr))
                {
                    SqlCommand cmd = new SqlCommand("GAME_QUERY_BY_TEAMS_AND_DATE", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@visitingTeam", visitingTeam);
                    cmd.Parameters.AddWithValue("@homeTeam", homeTeam);

                    //DateTime dt = DateTime.ParseExact(datePlayed, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    SqlParameter dtParm = new SqlParameter("@datePlayed", SqlDbType.DateTime);
                    dtParm.Value = datePlayed;
                    cmd.Parameters.Add(dtParm);

                    conn.Open();

                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        gameId = rdr.GetInt32("gameId");
                    }

                    rdr.Close();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                throw;
            }
            return gameId;
        }

        public int GameInsert(string homeTeam, string visitorTeam, DateTime datePlayed)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(localHostConnStr))
                {
                    SqlCommand cmd = new SqlCommand("GAMES_INSERT", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@homeTeamName", homeTeam);
                    cmd.Parameters.AddWithValue("@visitorTeamName", visitorTeam);
                    cmd.Parameters.AddWithValue("@dayOfWeek", (int)(datePlayed.DayOfWeek));


                    //DateTime dt = DateTime.ParseExact(datePlayed, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    SqlParameter dtParm = new SqlParameter("@datePlayed", SqlDbType.DateTime);
                    dtParm.Value = datePlayed;
                    cmd.Parameters.Add(dtParm);

                    cmd.Parameters.Add("@gameId", SqlDbType.Int).Direction = ParameterDirection.Output;

                    conn.Open();

                    int rc = cmd.ExecuteNonQuery();
                    int gameId = Convert.ToInt32(cmd.Parameters["@gameId"].Value);

                    conn.Close();

                    return gameId;
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public int BookMakerIdQuery(string key, string title)
        {
            int bookMakerId = -1;

            try
            {
                using (SqlConnection conn = new SqlConnection(localHostConnStr))
                {
                    SqlCommand cmd = new SqlCommand("BOOKMAKERS_QUERY_OR_INSERT", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@bookMakerKey", key);
                    cmd.Parameters.AddWithValue("@bookMakerTitle", title);
                    cmd.Parameters.Add("@bookMakerId", SqlDbType.Int).Direction = ParameterDirection.Output;

                    conn.Open();

                    int rc = cmd.ExecuteNonQuery();
                    bookMakerId = Convert.ToInt32(cmd.Parameters["@bookMakerId"].Value);

                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                throw;
            }

            return bookMakerId;
        }

        public void LineByTeamInsert(int gameId, int bookMakerId, string betType, DateTime lastUpdate, Outcome outcome)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(localHostConnStr))
                {
                    SqlCommand cmd = new SqlCommand("LINES_BY_TEAM_INSERT", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@gameId", gameId);
                    cmd.Parameters.AddWithValue("@bookMakerId", bookMakerId);
                    cmd.Parameters.AddWithValue("@teamName", outcome.name);
                    cmd.Parameters.AddWithValue("@price", outcome.price);
                    cmd.Parameters.AddWithValue("@spread", outcome.point);
                    cmd.Parameters.AddWithValue("@betType", betType);

                    //DateTime dt = DateTime.ParseExact(lastUpdate, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    SqlParameter dtParm = new SqlParameter("@datePublished", SqlDbType.DateTime);
                    dtParm.Value = lastUpdate;
                    cmd.Parameters.Add(dtParm);

                    conn.Open();

                    int rc = cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}
