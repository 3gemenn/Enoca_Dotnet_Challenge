using Enoca_Dotnet_Challenge_Core.Dtos;
using Enoca_Dotnet_Challenge_Core.Models;
using Enoca_Dotnet_Challenge_Core.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Core.Services
{ 
    public interface IOrderService : IGenericRepository<Order>
    {
        Task<CustomResponseDto<OrderDto>> Create(OrderDto orderDto);
    }

}
