
namespace Taller_7;
using Microsoft.EntityFrameworkCore;
using Taller_7.Data;

public class Program
{
    public static void Main(string[] args)
    {

        var builder = WebApplication.CreateBuilder(args);

        // Agregar EF Core con base de datos en memoria
        builder.Services.AddDbContext<AppDbContext>(options =>
            options.UseInMemoryDatabase("CatalogoDB"));

        builder.Services.AddControllers();
        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddSwaggerGen();

        var app = builder.Build();

        // Configure the HTTP request pipeline.
        if (app.Environment.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
        }

        app.UseHttpsRedirection();
        app.UseAuthorization();
        app.UseStaticFiles();
        app.MapControllers();

        // Add default route for root path
        app.MapGet("/", () => Results.Redirect("/index.html"));

        app.Run();

    }
}
