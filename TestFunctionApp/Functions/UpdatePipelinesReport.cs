using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using RACWA.RAC2GH.GitHubMigrationReports.Configuration;

namespace TestFunctionApp.Functions;

public class UpdatePipelinesReport : BaseReportsFunction
{
    public UpdatePipelinesReport(IServiceProvider serviceProvider, ILoggerFactory loggerFactory, IConfiguration config, IOptionsMonitor<CommonSettings> settingsMonitor) : base(serviceProvider, loggerFactory, config, settingsMonitor)
    {
    }

    [Function("UpdatePipelinesReport")]
    public async Task Run([TimerTrigger("0 */30 * * * *", RunOnStartup = true)] TimerInfo timerInfo, FunctionContext executionContext)
    {
        await Task.Delay(1000);
        Logger.LogInformation("Hello");
        await Task.Delay(1000);
        Logger.LogInformation("World!");
        Logger.LogInformation($"Fred={Settings.Fred}");
    }
}
public class TimerInfo
{
    public ScheduleStatus ScheduleStatus { get; set; }

    public bool IsPastDue { get; set; }
}

public class ScheduleStatus
{
    public DateTime Last { get; set; }

    public DateTime Next { get; set; }

    public DateTime LastUpdated { get; set; }
}