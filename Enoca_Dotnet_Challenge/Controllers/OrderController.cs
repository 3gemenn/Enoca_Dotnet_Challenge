using AutoMapper;
using Enoca_Dotnet_Challenge_Core.Dtos;
using Enoca_Dotnet_Challenge_Core.Models;
using Enoca_Dotnet_Challenge_Core.Services;
using Enoca_Dotnet_Challenge_Core.UnitOfWorks;
using Enoca_Dotnet_Challenge_Repository.UnitOfWorks;
using Enoca_Dotnet_Challenge_Service.Services;
using Enoca_Dotnet_Challenge_Service.Validations;
using Microsoft.AspNetCore.Mvc;

namespace Enoca_Dotnet_Challenge_Api.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class OrderController : CustomBaseController
    {
        private readonly IOrderService _orderService;
        private readonly IMapper _mapper;
        private readonly IUnitOfWork _unitOfWork;
        public OrderController(IOrderService orderService, IMapper mapper, IUnitOfWork unitOfWork)
        {
            _orderService = orderService;
            _mapper = mapper;
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var result = _orderService.GetAll();
            var mapper = _mapper.Map<List<OrderDto>>(result);

            return CreateActionResult(CustomResponseDto<List<OrderDto>>.Success(200, "Veriler Başarıyla Getirildi", mapper.ToList()));
        }
        [HttpPost]
        public async Task<IActionResult> Create(OrderDto orderdto)
        {
            var validator = new OrderValidator();
            var validationResult = await validator.ValidateAsync(orderdto);
            List<string> errorLists = new List<string>();
            if (!validationResult.IsValid)
            {
                var error = validationResult.Errors;
                foreach (var item in error)
                {
                    errorLists.Add(item.ErrorMessage);
                }
                return BadRequest(CustomResponseDto<OrderDto>.Fail(404,"Error", errorLists.Distinct().ToList()));
            }

            try
            {
                var result = await _orderService.Create(orderdto);
                if (result.StatusCode == 404)
                {
                    return BadRequest(result);
                }

                return CreateActionResult(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(OrderDto orderdto)
        {
            var mapper =  _mapper.Map<Order>(orderdto);
            _orderService.Remove(mapper);
            _unitOfWork.Commit();
            return CreateActionResult(CustomResponseDto<OrderDto>.Success(200, "Veri Başarıyla Silindi"));

        }

    }
}
