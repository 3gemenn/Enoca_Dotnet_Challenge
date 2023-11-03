using Enoca_Dotnet_Challenge_Core.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Enoca_Dotnet_Challenge_Repository
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions options):base(options)
        {
            
        }
        public DbSet<Carrier> Carriers { get; set; }
        public DbSet<CarrierConfiguration> CarrierConfigurations { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<CarrierReport> CarrierReports { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)        {            builder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());            base.OnModelCreating(builder);
        }
    }
}
