# AutoGetIt
The idea with this small Delphi program is to automate the [GetIt package manager](http://docwiki.embarcadero.com/RADStudio/Sydney/en/Installing_a_Package_Using_GetIt_Package_Manager) for RAD Studio (Delphi) by calling the GetIt command-line tool that comes with Delphi.  Every time there's an update or a need to reinstall, it's a pain to tediously and manually go through all the GetIt packages you may want and reinstall them all. This can be done on the command-line but the documentation for GetIt is weak.

This Delphi program uses the DosCommand component (available on GetIt) to shell out to the GetItCmd.exe, show all the packages in a CheckListBox, and allows the user to simply check off all the ones they want and then sit back and watch them all get installed.

## Not quite there...
It's not finished yet but the earlier problems of not getting all the packages has been resolved (it was due to not parsing the lines from DosCommand properly).

_Written in Delphi 10.4_

## Batch files in the meantime

Since the GUI isn't where I want it to be quite yet, I wrote a bunch of batch files.  I basically dumped all the packages into a text file then prepended the GetIt command line to install them.  Then I separated them into groups.

To run the batch files, start a DOS Prompt as Administrator, run the `rsvars.bat` batch file from your Delphi folder, then run any of the batch files in the `batch`  folder. You will want to modify the batch files and comment out the packages you don't want.
