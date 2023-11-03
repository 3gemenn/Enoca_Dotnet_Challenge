using Enoca_Dotnet_Challenge_Core.Repositories;
using Enoca_Dotnet_Challenge_Core.Services;
using Enoca_Dotnet_Challenge_Core.UnitOfWorks;
using Enoca_Dotnet_Challenge_Repository;
using Enoca_Dotnet_Challenge_Repository.Repositories;
using Enoca_Dotnet_Challenge_Repository.UnitOfWorks;
using Enoca_Dotnet_Challenge_Service.Mapping;
using Enoca_Dotnet_Challenge_Service.Services;
using Hangfire;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<AppDbContext>(opts =>
{
    opts.UseSqlServer(builder.Configuration["ConnectionStrings:DefaultConnectionString"]);
});
builder.Services.AddHangfire(config => config.UseSqlServerStorage(builder.Configuration.GetConnectionString("HangfireConnectionString")));
builder.Services.AddHangfireServer();
// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddScoped(typeof(IGenericRepository<>), typeof(GenericRepository<>));
builder.Services.AddScoped<ICarrierService,CarrierService>();
builder.Services.AddScoped<ICarrierConfigurationService,CarrierConfigurationService>();
builder.Services.AddScoped<IOrderService,OrderService>();
builder.Services.AddScoped<IUnitOfWork,UnitOfWork>();
builder.Services.AddScoped<ICarrierReportService,CarrierReportService>();
builder.Services.AddAutoMapper(typeof(MapProfile));

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();

}

app.UseHttpsRedirection();
app.UseHangfireDashboard("/hangfire");
app.UseAuthorization();

app.MapControllers();

app.Run();
