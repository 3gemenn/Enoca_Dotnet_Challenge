using Enoca_Dotnet_Challenge_Core.Services;
using Hangfire;
using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Service.Services
{
    public class MyHostedService : IHostedService
    {
        private readonly ICarrierReportService _carrierReportService;

        public MyHostedService(ICarrierReportService carrierReportService)
        {
            _carrierReportService = carrierReportService;
        }

        public Task StartAsync(CancellationToken cancellationToken)
        {
            Hangfire.RecurringJob.AddOrUpdate("reportJob", () => _carrierReportService.Report(), Cron.Minutely);
            return Task.CompletedTask;
        }

        public Task StopAsync(CancellationToken cancellationToken)
        {
            return Task.CompletedTask;
        }
    }
}
