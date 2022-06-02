using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Ejercicio_Entrevista.Models
{
    public class Buildings
    {
        [Key]
        public int PKBuilding { get; set; }
        public string Building { get; set; }
    }
}
