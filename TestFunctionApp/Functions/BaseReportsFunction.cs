using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using RACWA.RAC2GH.GitHubMigrationReports.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestFunctionApp.Functions;

public abstract class BaseReportsFunction
{
    public IOptionsMonitor<CommonSettings> SettingsOptions { get; }

    public IConfiguration Config { get; }

    public ILogger Logger { get; }

    public IServiceProvider ServiceProvider { get; }

    public CommonSettings Settings => SettingsOptions.CurrentValue;

    protected BaseReportsFunction(IServiceProvider serviceProvider, ILoggerFactory loggerFactory, IConfiguration config, IOptionsMonitor<CommonSettings> settingsMonitor)
    {
        ServiceProvider = serviceProvider;
        Logger = loggerFactory.CreateLogger(this.GetType());
        Config = config;
        SettingsOptions = settingsMonitor;
    }
}
