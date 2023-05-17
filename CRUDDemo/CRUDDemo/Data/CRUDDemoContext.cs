using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using CRUDDemo.Models;

namespace CRUDDemo.Data
{
    public class CRUDDemoContext : DbContext
    {

        public CRUDDemoContext (DbContextOptions<CRUDDemoContext> options)
            : base(options)
        {
            var con = (Microsoft.Data.SqlClient.SqlConnection)Database.GetDbConnection();
            if (con.ConnectionString.Contains("(localdb)", StringComparison.OrdinalIgnoreCase))
            {
                return;
            }
            con.Open();
        }

        public DbSet<CRUDDemo.Models.Student> Student { get; set; } = default!;
    }
}
