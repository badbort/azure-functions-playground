using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using RACWA.RAC2GH.GitHubMigrationReports.Configuration;

namespace TestFunctionApp;

internal class Program
{
    public static async Task Main(string[] args)
    {
        var host = new HostBuilder()
            .ConfigureFunctionsWorkerDefaults()
            .ConfigureServices((context, services) =>
            {
                // Satisfy command line app service dependencies
                services.AddHttpClient();
                services.Configure<CommonSettings>(context.Configuration);
            })
            .Build();

        await host.RunAsync();
    }
}

