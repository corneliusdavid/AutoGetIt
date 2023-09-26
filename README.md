# AutoGetIt
The idea with this small Delphi program is to automate the [GetIt package manager](http://docwiki.embarcadero.com/RADStudio/Sydney/en/Installing_a_Package_Using_GetIt_Package_Manager) for RAD Studio (Delphi) by calling the GetIt command-line tool that comes with Delphi.  Every time there's an update or a need to reinstall, it's a pain to tediously and manually go through all the GetIt packages and reinstall them. Wouldn't it be nice if there was a saved checklist?

Now there is!

This Delphi program uses the DosCommand component (available on GetIt) to shell out to the GetItCmd.exe and show all the packages in a CheckListBox. You then simply check off all the packages you want to install, click the Install button, and sit back and watch them all get installed (some require authorization so it's not completely unattended). You can also right+click on this list to select all or none, or uninstall the checked packages instead, or install/uninstall just one package at a time.

_Originally Written in Delphi 10.4.1, tested on the update to Delphi 10.4.2: installed over 75 packages in less than 30 mintues!_

### Delphi 12 Disclaimer

This commit, released 2023-Sep-25, supports Delphi 12! Please note that as of this date, RAD Studio 12 is _still in Beta_! That means it is based on a pre-release version of the RAD Studio software and it has been written with specific permission by Embarcadero. No feature is committed until the product GA release. That means you agree to use it at your own risk (as with all open-source software) and that things may change in Delphi, the GetIt interface, and this code before Delphi 12 is made generally available.

## Batch files

If you don't want to run the GUI, I also wrote a bunch of batch files that do the same thing but with pre-selected groups of packages.  I basically dumped all the packages into a text file then prepended the GetIt command line to install them and separated them into variously grouped batch files, some duplicated among a couple of groups. If you haven't already done this for your install, this will help get you started.

To run the batch files, start a DOS Prompt as Administrator, run the `rsvars.bat` batch file from your Delphi folder, then run any of the batch files in the `batch`  folder. You will want to modify the batch files and comment out the packages you don't want.

## Links

- [Enabling GetIt Install Logs](https://blog.marcocantu.com/blog/2018-july-getit-install-logs.html)
- [Delphi 10.4.2 Release Notes](http://docwiki.embarcadero.com/RADStudio/Sydney/en/Release_Notes)
- [Delphi 11 Release Notes](https://docwiki.embarcadero.com/RADStudio/Alexandria/en/Release_Notes)

## Screenshot

![Screenshot](./AutoGetIt.png)
