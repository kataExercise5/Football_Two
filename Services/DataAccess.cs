using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace Football_Two.Services
{
    public class DataAccess
    {
        private string localHostConnStr = "Server=localhost;Database=Football;Trusted_Connection=True;";

        public int GameQuery(string homeTeam, string visitingTeam, string datePlayed)
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

                    DateTime dt = DateTime.ParseExact(datePlayed, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    SqlParameter dtParm = new SqlParameter("@datePlayed", SqlDbType.DateTime);
                    dtParm.Value = dt;
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

        public int GameInsert(string homeTeam, string visitorTeam, string datePlayed)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(localHostConnStr))
                {
                    SqlCommand cmd = new SqlCommand("GAMES_INSERT", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@homeTeamName", homeTeam);
                    cmd.Parameters.AddWithValue("@visitorTeamName", visitorTeam);

                    DateTime dt = DateTime.ParseExact(datePlayed, "yyyy-MM-dd", CultureInfo.InvariantCulture);
                    SqlParameter dtParm = new SqlParameter("@datePlayed", SqlDbType.DateTime);
                    dtParm.Value = dt;
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
    }
}
