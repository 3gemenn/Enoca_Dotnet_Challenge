using AutoMapper;
using Enoca_Dotnet_Challenge_Core.Dtos;
using Enoca_Dotnet_Challenge_Core.Models;
using Enoca_Dotnet_Challenge_Core.Services;
using Enoca_Dotnet_Challenge_Core.UnitOfWorks;
using Enoca_Dotnet_Challenge_Repository;
using Enoca_Dotnet_Challenge_Service.Validations;
using FluentValidation;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Enoca_Dotnet_Challenge_Api.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CarrierConfigurationController : CustomBaseController
    {
        private readonly ICarrierConfigurationService _carrierConfigurationService;
        private readonly IMapper _mapper;
        private readonly IUnitOfWork _unitOfWork;
        public CarrierConfigurationController(ICarrierConfigurationService carrierConfigurationService, IMapper mapper, IUnitOfWork unitOfWork)
        {
            _carrierConfigurationService = carrierConfigurationService;
            _mapper = mapper;
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var result = _carrierConfigurationService.GetAll();
            var mapper = _mapper.Map<List<CarrierConfigurationDto>>(result);

            return CreateActionResult(CustomResponseDto<List<CarrierConfigurationDto>>.Success(200, "Veriler Başarıyla Getirildi", mapper.ToList()));
        }

        [HttpPost]
        public async Task<IActionResult> Create(CarrierConfigurationDto carrierconfigurationdto)
        {
            var validator = new CarrierConfigurationValidator();
            var validationResult = await validator.ValidateAsync(carrierconfigurationdto);
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
                var mapper = _mapper.Map<CarrierConfiguration>(carrierconfigurationdto);
                await _carrierConfigurationService.AddAsync(mapper);
                await _unitOfWork.CommitAsync();
                return CreateActionResult(CustomResponseDto<CarrierConfigurationDto>.Success(200, "Veri Başarıyla Oluşturuldu"));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpPut]
        public async Task<IActionResult> Update(CarrierConfigurationDto carrierconfigurationdto)
        {
            var validator = new CarrierConfigurationValidator();
            var validationResult = await validator.ValidateAsync(carrierconfigurationdto);

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
                var mapper = _mapper.Map<CarrierConfiguration>(carrierconfigurationdto);
                _carrierConfigurationService.Update(mapper);
                _unitOfWork.Commit();

                return CreateActionResult(CustomResponseDto<CarrierConfigurationDto>.Success(200, "Veri Başarıyla Güncellendi"));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [HttpDelete]
        public async Task<IActionResult> Delete(CarrierConfigurationDto carrierconfigurationdto)
        {
            var mapper = _mapper.Map<CarrierConfiguration>(carrierconfigurationdto);
            _carrierConfigurationService.Remove(mapper);
            _unitOfWork.Commit();
            return CreateActionResult(CustomResponseDto<CarrierConfigurationDto>.Success(200, "Veri Başarıyla Silindi"));

        }

    }
}
