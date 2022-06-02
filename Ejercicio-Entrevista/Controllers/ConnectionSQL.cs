using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using Dapper;
using System.Data;
using System.Linq;

namespace Ejercicio_Entrevista.Models
{
    public class ConnectionSQL
    {
        //DB Server
        private string connectionString = "Server=DESKTOP-74EK518;Database=Materials;Trusted_Connection=True";

        //Get the data from the Buildings table and returns it as a List
        public List<Buildings> GetBuildings()
        {
            using (IDbConnection connection = new Microsoft.Data.SqlClient.SqlConnection(connectionString))
            {
                return connection.Query<Buildings>("Exec GetBuildings").ToList();
            }
        }

        //Get the data from the Customers table and returns it as a List
        public List<Customers> GetCustomers()
        {
            using (IDbConnection connection = new Microsoft.Data.SqlClient.SqlConnection(connectionString))
            {
                return connection.Query<Customers>("Exec GetCustomers").ToList();
            }
        }

        //Get the data from the PartNumbers table and returns it as a List
        public List<PartNumbers> GetPartNumbers()
        {
            using (IDbConnection connection = new Microsoft.Data.SqlClient.SqlConnection(connectionString))
            {
                return connection.Query<PartNumbers>("Exec GetPartNumbers").ToList();
            }
        }

        //Get the data to fiil the gridview in Querys as a List
        public List<GridViewData> GetGridViewData()
        {
            using (IDbConnection connection = new Microsoft.Data.SqlClient.SqlConnection(connectionString))
            {
                return connection.Query<GridViewData>("Exec GetGridViewData").ToList();
            }
        }

        //Insert the Buildings object into the Database
        public String addBuildings(Buildings buildings)
        {
            using (IDbConnection connection = new Microsoft.Data.SqlClient.SqlConnection(connectionString))
            {
                connection.Query("Exec AddBuilding " + buildings.Building);
            }
            return "Save Successfully"; 
        }

        //Insert the Customer object into the Database
        public string addCustomers(Customers customers)
        {
            using (IDbConnection connection = new Microsoft.Data.SqlClient.SqlConnection(connectionString))
            {
                connection.Query("Exec AddCustomer " + customers.Customer + "," + customers.Prefix + "," + customers.FKBuilding);
            }
            return "Save Successfully";
        }

        //Insert the Part Number object into the Database
        public string addPartNumbers(PartNumbers partNumbers)
        {
            using (IDbConnection connection = new Microsoft.Data.SqlClient.SqlConnection(connectionString))
            {
                connection.Query("Exec AddPartNumber " + partNumbers.PartNumber + "," + partNumbers.FKCustomer + "," + partNumbers.Available);
            }
            return "Save Successfully";
        }
    }
}