using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace CampusBooks_AnelisaNkwali_202249214_.WebForm
{
    public partial class SalesReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load Categories
                LoadCategories();
            }
        }

        // Load Categories for the dropdown
        private void LoadCategories()
        {
            string constr = @"Data Source=LISA\SQLEXPRESS;Initial Catalog=CampusBooksDB;Integrated Security=True";
            using (SqlConnection con = new SqlConnection(constr))
            {
                SqlCommand cmd = new SqlCommand("SELECT DISTINCT Category FROM Books", con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                ddlCategory.Items.Clear();
                ddlCategory.Items.Add(new ListItem("All Categories", "All"));
                while (reader.Read())
                {
                    ddlCategory.Items.Add(new ListItem(reader["Category"].ToString(), reader["Category"].ToString()));
                }
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string startDate = txtStartDate.Text;
            string endDate = txtEndDate.Text;
            string category = ddlCategory.SelectedValue;

            // Update the SqlDataSource SelectCommand with the filtered parameters
            string query = "SELECT s.SaleID, b.Title, s.QuantitySold, s.SaleDate, (s.QuantitySold * b.Price) AS Total " +
                           "FROM Sales s INNER JOIN Books b ON s.BookID = b.BookID WHERE 1=1 ";

            if (!string.IsNullOrEmpty(startDate))
                query += " AND s.SaleDate >= @StartDate";
            if (!string.IsNullOrEmpty(endDate))
                query += " AND s.SaleDate <= @EndDate";
            if (category != "All")
                query += " AND b.Category = @Category";

            // Assign the updated query to the SqlDataSource
            SqlDataSourceSales.SelectCommand = query;
            SqlDataSourceSales.SelectParameters.Clear();

            if (!string.IsNullOrEmpty(startDate))
                SqlDataSourceSales.SelectParameters.Add("StartDate", startDate);
            if (!string.IsNullOrEmpty(endDate))
                SqlDataSourceSales.SelectParameters.Add("EndDate", endDate);
            if (category != "All")
                SqlDataSourceSales.SelectParameters.Add("Category", category);

            // Rebind the GridView to refresh the data
            GridViewSales.DataBind();
        }
    }
}

