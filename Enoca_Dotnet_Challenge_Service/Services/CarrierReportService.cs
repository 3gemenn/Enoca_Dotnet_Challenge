using Enoca_Dotnet_Challenge_Core.Dtos;
using Enoca_Dotnet_Challenge_Core.Models;
using Enoca_Dotnet_Challenge_Core.Services;
using Enoca_Dotnet_Challenge_Core.UnitOfWorks;
using Enoca_Dotnet_Challenge_Repository;
using Enoca_Dotnet_Challenge_Repository.Repositories;
using Hangfire;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Service.Services
{
    public class CarrierReportService : GenericRepository<CarrierReport>, ICarrierReportService
    {
        private readonly AppDbContext _carrierReportService;
        private readonly IOrderService _orderService;
        private readonly IUnitOfWork _unitOfWork;
        public CarrierReportService(AppDbContext context, IOrderService orderService, IUnitOfWork unitOfWork) : base(context)
        {
            _carrierReportService = context;
            _orderService = orderService;
            _unitOfWork = unitOfWork;
        }
        public async Task<CustomResponseDto<NoContentDto>> HangfireStart()
        {
            Hangfire.RecurringJob.AddOrUpdate("reportJob", () => Report(), Cron.Hourly);
            return CustomResponseDto<NoContentDto>.Success(200,"Başarıyla gerçekleştirildi");
        }

        public async Task<CustomResponseDto<NoContentDto>> Report()
        {
            var orderCarriers = _orderService.GetAll().Select(x => x.CarrierId).Distinct().ToList();

            foreach (var item in orderCarriers)
            {
                decimal totalCost = 0;
                var orders = _orderService.Where(x=>x.CarrierId == item).ToList();
                foreach (var item2 in orders)
                {

                    totalCost += item2.CarrierCost;
                }
                var carrierReport = new CarrierReport
                {
                    Id = 0,
                    CarrierId = item,
                    CarrierCost = totalCost,
                    Date = DateTime.Now,
                };
                await _carrierReportService.AddAsync(carrierReport);
                await _unitOfWork.CommitAsync();
               
            }
            return CustomResponseDto<NoContentDto>.Success(200, "Başarıyla gerçekleştirildi");
        }

    }
}
