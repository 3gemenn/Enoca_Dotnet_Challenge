using Enoca_Dotnet_Challenge_Core.Dtos;
using FluentValidation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Service.Validations
{
    public class OrderValidator : AbstractValidator<OrderDto>
    {
        public OrderValidator()
        {
            RuleFor(order => order.Desi).NotEmpty().WithMessage("Order Desi cannot be empty.");
           
        }
    }
}
