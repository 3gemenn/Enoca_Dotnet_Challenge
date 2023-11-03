using AutoMapper;
using Enoca_Dotnet_Challenge_Core.Dtos;
using Enoca_Dotnet_Challenge_Core.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Service.Mapping
{
    public class MapProfile: Profile
    {
        public MapProfile()
        {
            CreateMap<Carrier, CarrierDto>();
            CreateMap<CarrierDto, Carrier>();
            CreateMap<CarrierConfiguration,CarrierConfigurationDto>();
            CreateMap<CarrierConfigurationDto, CarrierConfiguration>();
            CreateMap<Order, OrderDto>();
            CreateMap<OrderDto,Order>();
        }
    }
}
