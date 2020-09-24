# AutoGetIt
The idea with this small Delphi program is to automate the [GetIt package manager](http://docwiki.embarcadero.com/RADStudio/Sydney/en/Installing_a_Package_Using_GetIt_Package_Manager) for RAD Studio (Delphi) by calling the GetIt command-line tool that comes with Delphi.  Every time there's an update or a need to reinstall, it's a pain to tediously and manually go through all the GetIt packages you may want and reinstall them all. This can be done on the command-line but the documentation for GetIt is weak.

This Delphi program uses the DosCommand component (available on GetIt) to shell out to the GetItCmd.exe, show all the packages in a CheckListBox, and allows the user to simply check off all the ones they want and then sit back and watch them all get installed.

## Not quite there...
But it doesn't quite work.  For some strange reason, the list is not complete. When running the same command, it pauses and asks the user to hit Enter to continue.  I can redirect the output to a file without it stopping but I can't get the whole list to fill up the list box...

I haven't finished it where it'll parse out the name and install it.  That won't be hard.  For now, I'm just going to generate a text file and setup a batch file to process it.  I hope to have time and come back and finish this project.

_Written in Delphi 10.4_
