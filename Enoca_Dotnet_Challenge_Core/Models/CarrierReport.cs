using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Core.Models
{
    public class CarrierReport : BaseEntity
    {
        public int CarrierId { get; set; }
        public Carrier Carrier { get; set; }
        public decimal CarrierCost { get; set; }
        public DateTime Date { get; set; }
    }
}
