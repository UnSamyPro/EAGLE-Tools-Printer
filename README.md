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


## License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file for details.