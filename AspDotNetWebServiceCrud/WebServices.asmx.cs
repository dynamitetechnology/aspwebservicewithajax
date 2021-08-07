using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace AspDotNetWebServiceCrud
{
    /// <summary>
    /// Summary description for WebServices
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class WebServices : System.Web.Services.WebService
    {

        [WebMethod]
        public string AddUser(string fName,string lName,string email)
        {
            //Get connection string from web.config file  
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            //create new sqlconnection and connection to database by using connection string from web.config file  
            SqlConnection con = new SqlConnection(strcon);
            int status = 0;
            try
            {
                string sql = " insert into users (fname, lname, email) values ('"+ fName + "','"+ lName + "','"+ email + "') ";
                con.Open();
                SqlCommand cmd = new SqlCommand(sql,con);
                status = cmd.ExecuteNonQuery();
                if(status> 0)
                {
                    return "Success";
                }
                else
                {
                    return "Fail";
                }

            } catch(Exception ex){
                Console.WriteLine(ex.Message);
                return ex.Message;
            }

            //return null;
        }

        [WebMethod]
        public string SearchUsers(string searchKey)
        {
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strcon);
            string sql = " select id, fname, lname, email from users where fname like '%"+ searchKey + "%' or lname like '%" + searchKey + "%' or  email like '%" + searchKey + "%'";
            List<User> userList = new List<User>();
            string JsonResult = "";
            using (SqlCommand command = new SqlCommand(sql, con))
            {
                con.Open();
              
                var reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        User user = new User();
                        user.id = Convert.ToInt32(reader["id"]);
                        user.fname = reader["fname"].ToString();
                        user.lname = reader["lname"].ToString();
                        user.email = reader["email"].ToString();
                        userList.Add(user);
                    }

                }
               JsonResult = JsonConvert.SerializeObject(userList);
                con.Close();
            }
           
            return JsonResult;
        }



        [WebMethod]
        public string getEingleUser(string editid)
        {
            string strcon = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            SqlConnection con = new SqlConnection(strcon);
            string sql = " select id, fname, lname, email from users where id = '"+ editid + "'";
            List<User> userList = new List<User>();
            string JsonResult = "";
            using (SqlCommand command = new SqlCommand(sql, con))
            {
                con.Open();

                var reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        User user = new User();
                        user.id = Convert.ToInt32(reader["id"]);
                        user.fname = reader["fname"].ToString();
                        user.lname = reader["lname"].ToString();
                        user.email = reader["email"].ToString();
                        userList.Add(user);
                    }

                }
                JsonResult = JsonConvert.SerializeObject(userList);
                con.Close();
            }

            return JsonResult;
        }
    }
}
