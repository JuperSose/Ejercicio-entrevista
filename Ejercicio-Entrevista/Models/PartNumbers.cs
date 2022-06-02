using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Ejercicio_Entrevista.Models
{
    public class PartNumbers
    {
        public int PKPartNumber { get; set; }
        public string PartNumber { get; set; }
        public int FKCustomer { get; set; }
        public bool Available { get; set; }

    }
}
