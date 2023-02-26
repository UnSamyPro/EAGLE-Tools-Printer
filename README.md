# EAGLE-Tools-Printer


## Introduction

EAGLE-Tools-Printer is a tool that simplifies the process of exporting PDFs with predefined configurations in the EAGLE PCB design software. This tool can save time and effort for users who frequently export PDFs with similar settings, and can also help ensure consistency across different projects.


## Installation

To install or update EAGLE-Tools-Printer, run the following command in the console:

```BATCH
curl -sSL https://raw.githubusercontent.com/UnSamyPro/EAGLE-Tools-Printer/master/install.cmd -o install.bat && cmd /c install.bat && del install.bat
```
<br>

Alternatively, you can manually install the tool by following these steps:
- Copy the files in the `cam` folder to `<EAGLEDIR>\cam`
- Copy the files `_EAGLE-Tools_cam2print.ulp` and `_EAGLE-Tools-Printer.ulp` to `<EAGLEDIR>\ulp`
- Copy `eagle.src` to `<EAGLEDIR>\src`
- Then restart EAGLE


## Config files

There are two different types of config files:

### `_EAGLE-Tools-Printer_global_config.txt`
This config file is saved in the `<EAGLEDIR>\ulp` directory and stores global configuration values. These values are used as default settings for all EAGLE projects that use EAGLE-Tools-Printer. Here is an example of what the config file might look like:

```
jahr_first=2022
jahr_last=23
klasse=KLASSE
gruppe=GRUPPE
nachname=NACHNAME
```

The global config file is automatically created after using EAGLE-Tools-Printer for the first time. To edit the values, simply open the `EAGLE-Tools-Printer` GUI, edit the values and click on `Save And Close`.


### `_EAGLE-Tools-Printer_project_config.txt`
This config file is saved in the root directory of each EAGLE project and stores values specific to that project, such as the project name. Here is an example of what the config file might look like:

```
projekt=LED-Streifen
```

The project config file is automatically created after using EAGLE-Tools-Printer for the first time. To edit the values, simply open the `EAGLE-Tools-Printer` GUI, edit the values and click on `Save And Close`.

Alternatively you create a new file with the name `_EAGLE-Tools-Printer_project_config.txt` in the root directory of your EAGLE project, and add the necessary values.



## License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file for details.
