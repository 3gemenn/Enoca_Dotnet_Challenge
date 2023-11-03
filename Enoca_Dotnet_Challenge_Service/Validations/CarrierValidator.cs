using Enoca_Dotnet_Challenge_Core.Dtos;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Service.Validations
{
    public class CarrierValidator : AbstractValidator<CarrierDto>
    {
        public CarrierValidator()
        {
            RuleFor(carrier => carrier.Name).NotEmpty().WithMessage("Carrier Name cannot be empty.");
            RuleFor(carrier => carrier.IsActive).NotEmpty().WithMessage("Carrier IsActive cannot be empty.");
            RuleFor(carrier => carrier.PlusDesiCost).NotEmpty().WithMessage("Carrier PlusDesiCost cannot be empty.");
            RuleFor(carrier => carrier.ConfigurationId).NotEmpty().WithMessage("Carrier ConfigurationId cannot be empty.");
        }

    }
}
