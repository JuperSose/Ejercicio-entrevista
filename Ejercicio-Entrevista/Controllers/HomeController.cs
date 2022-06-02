using Ejercicio_Entrevista.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Ejercicio_Entrevista.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        //Database connection Object
        private ConnectionSQL conn;
        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        List<GridViewData> data;
        public IActionResult Querys()
        {
            conn = new ConnectionSQL();
            //Get the data to fill the gridview
            data = conn.GetGridViewData();

            return View(data);
        }

        public IActionResult ExportToCSV()
        {
            conn = new ConnectionSQL();
            data = conn.GetGridViewData();
            StringBuilder builder = new StringBuilder();
            builder.AppendLine("PartNumber,Customer,Building,Available");
            foreach(var d in data)
            {
                builder.AppendLine($"{d.PartNumber},{d.Customer},{d.Building},{d.Available}");
            }
            return File(Encoding.UTF8.GetBytes(builder.ToString()), "text/csv", "Query.csv");
        }


        //Insert to database section
        [HttpGet]
        public IActionResult InsertBuilding()
        {
            return View();
        }
        [HttpPost]
        public IActionResult InsertBuilding([Bind] Buildings buildings) //Receives the object to insert into the database
        {
            
            conn = new ConnectionSQL();
            //Result Message
            try
            {
                if (ModelState.IsValid)
                {
                    //Insert data into the Table
                    string awnser = conn.addBuildings(buildings);
                    TempData["msg"] = awnser;
                }
            }
            catch (Exception ex)
            {
                TempData["msg"] = ex.Message;
            }
            return View();
        }

        [HttpGet]
        public IActionResult InsertCustomer()
        {
            return View();
        }
        [HttpPost]
        public IActionResult InsertCustomer([Bind] Customers customers) //Receives the object to insert into the database
        {

            conn = new ConnectionSQL();
            //Result Message
            try
            {
                if (ModelState.IsValid)
                {
                    //Insert data into the Table
                    string awnser = conn.addCustomers(customers);
                    TempData["msg"] = awnser;
                }
            }
            catch (Exception ex)
            {
                TempData["msg"] = ex.Message;
            }
            return View();
        }

        [HttpGet]
        public IActionResult InsertPartNumber()
        {
            return View();
        }
        [HttpPost]
        public IActionResult InsertPartNumber([Bind] PartNumbers partNumbers) //Receives the object to insert into the database
        {

            conn = new ConnectionSQL();
            //Result Message
            try
            {
                if (ModelState.IsValid)
                {
                    //Insert data into the Table
                    string awnser = conn.addPartNumbers(partNumbers);
                    TempData["msg"] = awnser;
                }
            }
            catch (Exception ex)
            {
                TempData["msg"] = ex.Message;
            }
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
