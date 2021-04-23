# AutoGetIt
The idea with this small Delphi program is to automate the [GetIt package manager](http://docwiki.embarcadero.com/RADStudio/Sydney/en/Installing_a_Package_Using_GetIt_Package_Manager) for RAD Studio (Delphi) by calling the GetIt command-line tool that comes with Delphi.  Every time there's an update or a need to reinstall, it's a pain to tediously and manually go through all the GetIt packages and reinstall them. Wouldn't it be nice if there was a saved checklist?

### _Under Construction_ ###

This new branch of the Delphi program is being reworked to use Embarcadero's GetIt API and is currently under heavy development. When it's done, it will allow you to list and sort all the packages available, mark off ones you want, then click the Install button, and sit back and watch them all get installed (some require authorization so it's not completely unattended). You will also be able to right+click on this list to select all or none, or uninstall the checked packages instead, or install/uninstall just one package at a time.

_Originally written in Delphi 10.4.1, tested on the update to Delphi 10.4.2: installed over 75 packages in less than 30 mintues_!

## Dependency

In addition to _requiring_ Delphi 10.4.2 (because it uses the new [TControlList](http://docwiki.embarcadero.com/RADStudio/Sydney/en/Using_VCL_TControlList_Control)), it is also makes heavy use of LiveBindings, including some custom methods found in the open source project [LiveBindings & Beyond](https://github.com/corneliusdavid/LiveBindingsBeyond). You will need to download them and install them in your Delphi environment before you can compile this project.

## Batch files

If you don't want to run the GUI, I also wrote a bunch of batch files that do the same thing but with pre-selected groups of packages.  I basically dumped all the packages into a text file then prepended the GetIt command line to install them and separated them into variously grouped batch files, some duplicated among a couple of groups. If you haven't already done this for your install, this will help get you started.

To run the batch files, start a DOS Prompt as Administrator, run the `rsvars.bat` batch file from your Delphi folder, then run any of the batch files in the `batch`  folder. You will want to modify the batch files and comment out the packages you don't want.

## Links

- [Enabling GetIt Install Logs](https://blog.marcocantu.com/blog/2018-july-getit-install-logs.html)
- [Delphi 10.4.2 Release Notes](http://docwiki.embarcadero.com/RADStudio/Sydney/en/Release_Notes)

## Screenshot

![Screenshot](./AutoGetIt.png)
