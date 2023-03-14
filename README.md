![logo](./media/sh-banners.png)
=========
[![GitHub release](https://img.shields.io/github/release/SecureHats/Sentinel-playground.svg?style=flat-square)](https://github.com/SecureHats/Sentinel-playground/releases)
[![Maintenance](https://img.shields.io/maintenance/yes/2023.svg?style=flat-square)]()
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

# Deployment package for ASIM Schema Project Functions

For more information about Log Analytics functions refer to:

- [KQL user defined functions](https://docs.microsoft.com/azure/data-explorer/kusto/query/functions/user-defined-functions)
- [Managing user functions in Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/logs/functions)

<br/>

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FSecureHats%2FASIM_ProjectSchema%2Fmain%2Fdeployment.json) [![Deploy to Azure Gov](https://aka.ms/deploytoazuregovbutton)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FSecureHats%2FASIM_ProjectSchema%2Fmain%2Fdeployment.json)

## About

These functions help to simplify the projection of the Manadatory and Recommended columns based of the selected ASIM Schema.<br><br>
Because you don't have to think about the fields you need to either `project` or `project-away` when parsing data from the _CommonEventLog_ or _Syslog_ table, you can now fully focus on optimizing the parser itself.

> Using this function also increases the processing speed which has been tested in multiple large enterprise environments

## How to use

The Project Schema function is extremely easy to use!<br>
Just enter the following line to the end of your parser, and you are good to go.<br>

```js

| invoke ASIM_ProjectSchema

```

## How it works

- The `ASIM_ProjectSchema` function will evaluate the value _*Mandatory*_ `EventSchema` column<br>
- Based on the value in the `EventSchema` column the appropriate _project function_ will be called
- The dedicated Schema function will project the `Mandatory`, `Recommended` and `AdditionalFields` columns related to the specific schema. <br>

> Optional fields from the ASIM schema will not be projected unless the are added to the `AdditionalFields` column.