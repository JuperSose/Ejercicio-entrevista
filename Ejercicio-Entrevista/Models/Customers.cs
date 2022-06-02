using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Ejercicio_Entrevista.Models
{
    public class Customers
    {
        public int PKCustomers { get; set; }
        public string Customer { get; set; }
        public string Prefix { get; set; }
        public int FKBuilding { get; set; }
    }
}
