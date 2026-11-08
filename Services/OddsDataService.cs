using Football_Two.Models;
using System.Data;
using System.Data.SqlClient;

namespace Football_Two.Services
{
    public class OddsDataService
    {
        private string localHostConnStr = "Server=localhost;Database=Football;Trusted_Connection=True;";

        private List<OddLine> lines = new List<OddLine>(); 

        public Task<int> UpdateResults(OddLine[] oddsLines)
        {
            lines = oddsLines.ToList<OddLine>();

            foreach (OddLine line in lines)
            {
                CalculateResult(line);
            }

            //UpdateResultsData();
            UpdateResultsDataByLine();

            return Task.FromResult(0);
        }

        private void CalculateResult(OddLine line)
        {
            //
            //logic assumes only 2 bet types:  spreads and h2h
            //
            
            decimal spreadScore;
            int opponentScore;

            if (line.teamId == line.homeTeamId)
            {
                if (line.betType == "spreads")
                {
                    spreadScore = line.homeTeamScore + line.spread;
                    opponentScore = line.visitingTeamScore;
                }
                else
                {
                    spreadScore = line.homeTeamScore;
                    opponentScore = line.visitingTeamScore;
                }
            }
            else
            {
                if (line.betType == "spreads")
                {
                    spreadScore = line.visitingTeamScore + line.spread;
                    opponentScore = line.homeTeamScore;
                }
                else
                {
                    spreadScore = line.visitingTeamScore;
                    opponentScore = line.homeTeamScore;
                }
            }

            if (spreadScore > opponentScore)
            {
                Win(line);
            }
            else
            {
                if (spreadScore < opponentScore)
                {
                    Lose(line);
                }
                else
                {
                    line.result = 0;
                }
            }
        }

        private void Win(OddLine line)
        {
            if (line.price > 0)
            {
                line.result = line.price;
            }
            else
            {
                line.result = 10000/(Math.Abs(line.price));
            }
        }

        private void Lose(OddLine line)
        {
            if (line.price < 0)
            {
                line.result = 10000 / line.price;
            }
            else
            {
                line.result = -100;
            }
        }

        private void UpdateResultsDataByLine()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(localHostConnStr))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("RESULTS_UPDATE_BY_LINE", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    foreach (OddLine line in lines)
                    {
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@linesByTeamId", line.linesByTeamId);
                        cmd.Parameters.AddWithValue("@result", line.result);
                        int rc = cmd.ExecuteNonQuery();
                    }

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
