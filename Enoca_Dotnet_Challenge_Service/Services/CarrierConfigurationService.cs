using Enoca_Dotnet_Challenge_Core.Models;
using Enoca_Dotnet_Challenge_Core.Services;
using Enoca_Dotnet_Challenge_Repository;
using Enoca_Dotnet_Challenge_Repository.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Service.Services
{
    public class CarrierConfigurationService : GenericRepository<CarrierConfiguration>, ICarrierConfigurationService
    {
        public CarrierConfigurationService(AppDbContext context) : base(context)
        {
        }
    }
}
