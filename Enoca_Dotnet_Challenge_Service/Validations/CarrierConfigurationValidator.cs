using Enoca_Dotnet_Challenge_Core.Dtos;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Service.Validations
{
    public class CarrierConfigurationValidator : AbstractValidator<CarrierConfigurationDto>
    {
        public CarrierConfigurationValidator()
        {
            RuleFor(carrierConfiguration => carrierConfiguration.CarrierId).NotEmpty().WithMessage("CarrierConfiguration CarrierId cannot be empty.");
            RuleFor(carrierConfiguration => carrierConfiguration.MaxDesi).NotEmpty().WithMessage("CarrierConfiguration MaxDesi cannot be empty.");
            RuleFor(carrierConfiguration => carrierConfiguration.MinDesi).NotEmpty().WithMessage("CarrierConfiguration MinDesi cannot be empty.");
            RuleFor(carrierConfiguration => carrierConfiguration.CarrierCost).NotEmpty().WithMessage("CarrierConfiguration CarrierCost cannot be empty.");
        }
    }
}
