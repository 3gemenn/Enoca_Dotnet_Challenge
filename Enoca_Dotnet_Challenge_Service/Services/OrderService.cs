using AutoMapper;
using Enoca_Dotnet_Challenge_Core.Dtos;
using Enoca_Dotnet_Challenge_Core.Models;
using Enoca_Dotnet_Challenge_Core.Services;
using Enoca_Dotnet_Challenge_Core.UnitOfWorks;
using Enoca_Dotnet_Challenge_Repository;
using Enoca_Dotnet_Challenge_Repository.Repositories;
using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Service.Services
{
    public class OrderService : GenericRepository<Order>, IOrderService
    {

        private readonly ICarrierConfigurationService _carrierConfigurationService;
        private readonly ICarrierService _carrierService;
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly AppDbContext _appDbContext;
        public OrderService(AppDbContext context, ICarrierConfigurationService carrierConfigurationService, ICarrierService carrierService, IUnitOfWork unitOfWork, IMapper mapper) : base(context)
        {
            _carrierConfigurationService = carrierConfigurationService;
            _carrierService = carrierService;
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _appDbContext = context;
        }

        public async Task<CustomResponseDto<OrderDto>> Create(OrderDto orderDto)
        {
            var conf = _carrierConfigurationService.Where(x => x.MinDesi <= orderDto.Desi && x.MaxDesi >= orderDto.Desi).ToList();
            Carrier carrier = null;
            CarrierConfiguration carrierConfiguration = null;
            if (conf.Count() > 0)
            {
                decimal cost = conf.FirstOrDefault().CarrierCost;
                foreach (var item in conf)
                {
                    if (item.CarrierCost < cost)
                    {
                        var carrierGetById = await _carrierService.GetByIdAsync(item.CarrierId);
                        carrier = carrierGetById;
                        cost = item.CarrierCost;
                    }


                }
                var data = new Order
                {
                    Id = 0,
                    CarrierCost = cost,
                    CarrierId = carrier.Id,
                    Date = DateTime.Now,
                    Desi = orderDto.Desi
                };
                var mapper = _mapper.Map<OrderDto>(data);
                await _appDbContext.AddAsync(data);
                await _unitOfWork.CommitAsync();
                return CustomResponseDto<OrderDto>.Success(200, "Sipariş başarılı bir şekilde oluşturuldu", mapper);
            }
            else
            {
                var confw = _carrierConfigurationService.GetAll().ToList();
                var result = await HesaplananKargoFiyati(orderDto.Desi,confw);
                if (result!=null)
                {
                    //
                    //var mapper = _mapper.Map<OrderDto>(result);
                    await _appDbContext.AddAsync(result);
                    await _unitOfWork.CommitAsync();
                    var mapper = _mapper.Map<OrderDto>(result);
                    return CustomResponseDto<OrderDto>.Success(200, "Sipariş başarılı bir şekilde oluşturuldu", mapper);
                }
                else
                {
                    return CustomResponseDto<OrderDto>.Fail(404, "Sipariş oluşturulamadı.");
                }

                
            }
            
        }
        public async Task<Order> HesaplananKargoFiyati(int siparisDesi, List<CarrierConfiguration> carrierConfigurations)
        {
            CarrierConfiguration enYakinFirma = null;
            decimal enYakinFiyat = decimal.MaxValue;

            foreach (var config in carrierConfigurations)
            {
                if (siparisDesi >= config.MinDesi && siparisDesi <= config.MaxDesi)
                {
                    // Sipariş desi, kargo firmasının Min-Max aralığına uyuyor
                    return null;
                }
                else if(siparisDesi>config.MaxDesi)
                {
                    decimal fark = Math.Abs(siparisDesi - config.MaxDesi);
                    if (fark < enYakinFiyat)
                    {
                        enYakinFirma = config;
                        enYakinFiyat = fark;
                    }
                }
                else if(siparisDesi<config.MinDesi)
                {
                    decimal fark = Math.Abs(siparisDesi - config.MinDesi);
                    if (fark < enYakinFiyat)
                    {
                        enYakinFirma = config;
                        enYakinFiyat = fark;
                    }
                }
            }

            if (enYakinFirma != null)
            {
                decimal fiyat = enYakinFirma.CarrierCost;
                //decimal fark = Math.Abs(siparisDesi - enYakinFirma.MaxDesi);
                var carrier =  await _carrierService.GetByIdAsync(enYakinFirma.CarrierId);
                decimal ekFiyat = enYakinFiyat * carrier.PlusDesiCost; // +1 desi fiyatı
                

                var data = new Order
                {
                    Id = 0,
                    CarrierCost = fiyat + ekFiyat,
                    CarrierId = carrier.Id,
                    Date = DateTime.Now,
                    Desi = siparisDesi
                };
                return data;
            }
            else
            {
                // Hiçbir firma ile eşleşmedi, bir hata durumu veya varsayılan bir değer dönebilirsiniz.
                return null;
            }
        }
    }
}
