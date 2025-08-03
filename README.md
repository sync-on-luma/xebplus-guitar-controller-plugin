#Guitar Controller Integration for XEB+ 

This is a plugin for the Xtreme Elite Boot Plus dashboard for the PlayStation 2. It allows the user interface to be navigated entirely with a guitar controller, such as those used by Guitar Hero and Rock Band. This plugin is not compatible with 3-button Guitar Freaks controllers.

##Requirements 
 * A PlayStation 2 console configured to run unsigned code via a custom boot loader.  
[PS2BBL](https://israpps.github.io/PlayStation2-Basic-BootLoader/) is the recommended option.
* A FAT32 formatted USB drive containing an installation of [XEB+](http://web.archive.org/web/20221225042045/http://www.hwc.nat.cu/ps2-vault/hwc-projects/xebplus/)
* A compatible PlayStation 2 guitar controller.

##Installation
1. Download the latest version of the plugin package from the releases section.  
2. Extract the `XEBPLUS` folder to root of the USB drive containing your XEB+ installation, and merge all folders if prompted.   
3. Connect your USB drive to the PS2 and boot into XEB+. XEB+ will automatically restart partway through the loading sequence the first time it's run with the guitar plugin installed. It will start normally on all subsequent boots unless the theme is changed, in which case this one-time reset will repeat.
4. After the one-time reset, the plugin is ready to go.

##Usage
Connecting a compatible PlayStation 2 guitar controller to Controller Port 1 with this plugin installed, will cause XEB+ to enter guitar mode after a few seconds. While in guitar mode, a guitar icon will be displayed in the lower left-hand corner of the screen and you will be able to navigate the dashboard with the guitar controller inputs.  
Note that XEB+ will briefly register a left directional button input just before entering guitar mode. This is an unavoidable side effect of how guitar controllers work on the PS2. This behavior does not occur if XEB+ boots with a guitar controller already connected.

###Controls
The button mappings for navigating XEB+ with a guitar controller are as follows:

Strum Up -      **scroll up**  
Strum Down -    **scroll down**  
Green Fret -    **confirm**  
Red Fret -      **cancel**  
Yellow Fret -   **scroll left**  
Blue Fret -     **scroll right**  
Orage Fret -    **open context menu**\*  
START -         **show next list**\*  

*neutrino Launcher only

##Uninstallation
The guitar controller plugin comes bundled with a dedicated uninstaller application.  
**DO NOT** attempt to remove or disable the guitar controller plugin via any method other than this uninstaller. Doing so is likely to leave your XEB+ installation in an unusable state.

To safely remove the guitar controller plugin, perform the following steps:  
1. Disable childproof mode if it is enabled.  
2. If you are currently using a guitar controller, disconnect it and replace it with a standard PS2 controller.  
3. Navigate to the Guitar Plugin Uninstaller in column six and launch it.  
4. Press and hold the L2 and CROSS buttons for several seconds to begin the uninstallation procedure.  
5. XEB+ will automatically restart once the uninstallation has finished. The guitar controller plugin will no longer be installed.

##Troubleshooting
###XEB+ freezes at startup
This can occur if the guitar controller plugin was not properly uninstalled. Ensure that `XEBPLUS/LUA/GUITAR.lua` and `XEBPLUS/PLG/PLG_GUITAR.lua` have not been moved, renamed or deleted.  
If you wish to remove the guitar controller plugin, refer to the steps in the Uninstallation section.

###Giutar icon flickers when using certain plugins with the guitar controller
This behavior occurs if either `thmDrawBKG()` or `thmDrawBKGOL()` are not called on every frame.
If you are a developer and encounter this issue with your plugin, ensure that both these functions are being called once per frame.

###Some plugins close instantly when using the guitar controller
This should never happen. However, this behavior can theoretically occur if a third-party plugin checks for controller input during V-blank.  
If you are a developer and encounter this issue with your plugin, ensure that all input handling occurs after calling `thmDrawBKG()` and before `Screen.waitVblankStart()`.