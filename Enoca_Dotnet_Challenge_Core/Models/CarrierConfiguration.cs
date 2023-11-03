using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Core.Models
{
    public class CarrierConfiguration : BaseEntity
    {
        public int CarrierId { get; set; }
        public Carrier Carrier { get; set; }
        public int MaxDesi { get; set; }
        public int MinDesi { get; set; }
        public decimal CarrierCost { get; set; }
    }
}
