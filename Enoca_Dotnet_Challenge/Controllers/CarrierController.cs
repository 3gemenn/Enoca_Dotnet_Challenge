using AutoMapper;
using Enoca_Dotnet_Challenge_Core.Dtos;
using Enoca_Dotnet_Challenge_Core.Models;
using Enoca_Dotnet_Challenge_Core.Services;
using Enoca_Dotnet_Challenge_Core.UnitOfWorks;
using Enoca_Dotnet_Challenge_Repository;
using Enoca_Dotnet_Challenge_Service.Validations;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Enoca_Dotnet_Challenge_Api.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CarrierController : CustomBaseController
    {
        private readonly ICarrierService _carrierService;
        private readonly IMapper _mapper;
        private readonly IUnitOfWork _unitOfWork;
        public CarrierController(ICarrierService carrierService, IMapper mapper, IUnitOfWork unitOfWork)
        {
            _carrierService = carrierService;
            _mapper = mapper;
            _unitOfWork = unitOfWork;
           
        }
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var result = _carrierService.GetAll();
            var mapper = _mapper.Map<List<CarrierDto>>(result);
            return CreateActionResult(CustomResponseDto<List<CarrierDto>>.Success(200, "Veriler Başarıyla Getirildi", mapper.ToList()));
        }

        [HttpPost]
        public async Task<IActionResult> Create (CarrierDto carrierdto)
        {
            var validator = new CarrierValidator();
            var validationResult = await validator.ValidateAsync(carrierdto);

            List<string> errorLists = new List<string>();
            if (!validationResult.IsValid)
            {
                var error = validationResult.Errors;
                foreach (var item in error)
                {
                    errorLists.Add(item.ErrorMessage);
                }
                return BadRequest(CustomResponseDto<OrderDto>.Fail(404, "Error", errorLists.Distinct().ToList()));
            }

            try
            {
                var mapper = _mapper.Map<Carrier>(carrierdto);
                await _carrierService.AddAsync(mapper);
                await _unitOfWork.CommitAsync();
                return CreateActionResult(CustomResponseDto<CarrierDto>.Success(200, "Veri Başarıyla Oluşturuldu"));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpPut]
        public async Task<IActionResult> Update (CarrierDto carrierdto)
        {
            var validator = new CarrierValidator();
            var validationResult = await validator.ValidateAsync(carrierdto);

            List<string> errorLists = new List<string>();
            if (!validationResult.IsValid)
            {
                var error = validationResult.Errors;
                foreach (var item in error)
                {
                    errorLists.Add(item.ErrorMessage);
                }
                return BadRequest(CustomResponseDto<OrderDto>.Fail(404, "Error", errorLists.Distinct().ToList()));
            }

            try
            {
                var mapper = _mapper.Map<Carrier>(carrierdto);
            _carrierService.Update(mapper);
            _unitOfWork.Commit();
            
            return CreateActionResult(CustomResponseDto<CarrierDto>.Success(200, "Veri Başarıyla Güncellendi"));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [HttpDelete]
        public async Task<IActionResult> Delete (CarrierDto carrierdto)
        {
            var mapper = _mapper.Map<Carrier>(carrierdto);
            _carrierService.Remove(mapper);
            _unitOfWork.Commit();
            return CreateActionResult(CustomResponseDto<CarrierDto>.Success(200, "Veri Başarıyla Silindi"));

        }

    }
}
