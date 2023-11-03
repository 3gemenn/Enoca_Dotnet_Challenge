using Enoca_Dotnet_Challenge_Core.Dtos;
using Enoca_Dotnet_Challenge_Core.Services;
using Microsoft.AspNetCore.Mvc;

namespace Enoca_Dotnet_Challenge_Api.Controllers
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class CarrierReportController : CustomBaseController
    {
        private readonly ICarrierReportService _carrierReportService;

        public CarrierReportController(ICarrierReportService carrierReportService)
        {
            _carrierReportService = carrierReportService;
        }
        [HttpGet]
        public async Task<IActionResult> HangFireStart()
        {
           var car =  await _carrierReportService.HangfireStart();
            return CreateActionResult(car);
        }
    }
}
