﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Core.Models
{
    public class Carrier : BaseEntity
    {
        public string Name { get; set; }
        public bool IsActive { get; set; }
        public int PlusDesiCost { get; set; }
        public int ConfigurationId { get; set; }
        public ICollection<Order> Orders { get; set; }
        public ICollection<CarrierConfiguration> CarrierConfigurations { get; set; }
        public ICollection<CarrierReport> CarrierReports { get; set; }
    }
}
