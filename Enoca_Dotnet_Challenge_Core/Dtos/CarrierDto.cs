using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Core.Dtos
{
    public class CarrierDto: BaseClassDto
    {
        public string Name { get; set; }
        public bool IsActive { get; set; }
        public int PlusDesiCost { get; set; }
        public int ConfigurationId { get; set; }
    }
}
