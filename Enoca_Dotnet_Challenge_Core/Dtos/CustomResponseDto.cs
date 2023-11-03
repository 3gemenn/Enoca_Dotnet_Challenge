using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Core.Dtos
{
    public class CustomResponseDto<T>
    {
        public T Data { get; set; }
        public string Message { get; set; }

        [JsonIgnore]
        public int StatusCode { get; set; }

        public List<String> Errors { get; set; }


        public static CustomResponseDto<T> Success(int statusCode,string message, T data)
        {
            return new CustomResponseDto<T> { Data = data, StatusCode = statusCode , Message= message  };
        }
        public static CustomResponseDto<T> Success(int statusCode, string message)
        {
            return new CustomResponseDto<T> { StatusCode = statusCode, Message = message };
        }
        public static CustomResponseDto<T> Fail(int statusCode, string message, List<string> errors)
        {
            return new CustomResponseDto<T> { StatusCode = statusCode, Message = message, Errors= errors };
        }
        public static CustomResponseDto<T> Fail(int statusCode, string message)
        {
            return new CustomResponseDto<T> { StatusCode = statusCode, Message = message };
        }
    }

    
}
