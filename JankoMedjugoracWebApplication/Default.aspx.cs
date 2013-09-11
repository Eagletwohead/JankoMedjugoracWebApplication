using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPSnippets.TwitterAPI;
using System.Configuration;

namespace JankoMedjugoracWebApplication
{
    public partial class _Default : Page
    {

#region Constants
        private const string TWITTER_POST = "https://api.twitter.com/1.1/statuses/update.json";

        //static string API_Key = 
#endregion

        #region "Page_Load"
        protected void Page_Load(object sender, EventArgs e)
        {
            TwitterConnect.API_Key = System.Configuration.ConfigurationManager.AppSettings["API_Key"];
            TwitterConnect.API_Secret = System.Configuration.ConfigurationManager.AppSettings["API_Secret"];
            if (!IsPostBack)
            {
                //if (TwitterConnect.IsAuthorized)
                //{
                //    btnAuthorize.Enabled = false;
                //    pnlTweet.Enabled = true;
                //}
                if (TwitterConnect.IsDenied)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "key", "alert('User has denied access.')", true);
                }
            }
        }
        #endregion

        #region "btnCalculate_Click"
        /// <summary>
        /// Handles clicking event on Calculate button. This will initiate result calculation.
        /// </summary>
        /// <param name="sender">btnCalculate button.</param>
        /// <param name="e">Event args. Not used here.</param>
        /// <remarks>This method assumes that correct data is entered in text inputs because of 
        /// ASP.NET valudation that is done by validator controls.</remarks>
        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            // Get valid integers values from inputs and get result list:
            int start = int.Parse(this.txtStartNumber.Text);
            int end = int.Parse(this.txtEndNumber.Text);
            List<string> result = GetResults(start, end);

            // Prepare data source for result list view. 
            // We create objects of anonymus type with one 'Text' property that will be used to bind our result data to result list view:
            var dataSource = (from r in result
                              select new { Text = r}).ToList();

            this.lvwResults.DataSource = dataSource;
            this.lvwResults.DataBind();

            if (result.Count > 0)
            {
                TwittResults(string.Join(",", result));
            }
            
        }
        #endregion

#region GetResults
        /// <summary>
        /// Gets list of all the items that needs to be displayed on page as result list.
        /// </summary>
        /// <param name="start">Starting point of interval.</param>
        /// <param name="end">Ending point of interval.</param>
        /// <returns>List of result text items.</returns>
        private List<string> GetResults(int start, int end)
        {
            List<string> result = new List<string>();

            // For all numbers in given interval, check if they are multiples of 3 or/and 5 and 
            // prepare appropriate output text:
            for (int i = start; i < end + 1; i++)
            {
                string output = string.Empty;
                if (i % 3 == 0)
                {
                    output = "Fizz";
                }
                if (i % 5 == 0)
                {
                    output += "Buzz";
                }
                else if (i % 3 != 0)
                {
                    output =  i.ToString(CultureInfo.CurrentUICulture);
                }

                result.Add(output);
            }

            return result;
        } 
#endregion

#region TwittResults
        /// <summary>
        /// Twitts passed message to Twitter.
        /// </summary>
        /// <param name="message">Text message that needs to be twitted.</param>
        private void TwittResults(string message)
        {
            TwitterConnect twitter = new TwitterConnect();
            if (!TwitterConnect.IsAuthorized)
            {
                twitter.OAuthToken = "352481636-LLfi8s5UgTG3wgNaTAAM4PWhebHMZYZJv1pk5XIB";
                twitter.OAuthTokenSecret = "cXK4IQn1YrJ2JUG4WXq9AaO74f888Nm2OIWfjORo";
                twitter.Authorize(Request.Url.AbsoluteUri.Split('?')[0]);
            }
            // Post results to Twitter. Only 140 characters can be posted to Twitter:
            string twitt = message.Substring(0,140);
            twitter.Tweet(twitt);
        }
#endregion

    }
}