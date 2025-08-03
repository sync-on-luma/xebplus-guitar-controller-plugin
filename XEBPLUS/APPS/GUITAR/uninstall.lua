XEBKeepInContextMenu=true
GUITAR_Countdown = 0
GUITAR_Fade = 0

function GUITAR_drawText()
    Font.ftPrint(fontBig, 52, plusYValue+77, 1, 720, 512, "WARNING:", Color.new(255,255,255,GUITAR_Fade))
    Font.ftPrint(fontSmall, 52, plusYValue+102, 1, 720, 512, "You are about to uninstall the guitar controller navigation plugin.", Color.new(255,255,255,GUITAR_Fade))
    Font.ftPrint(fontSmall, 52, plusYValue+121, 1, 720, 512, "Proceeding will PERMANATLY DELETE the plugin and all it's associated files from your USB drive.", Color.new(255,255,255,GUITAR_Fade))
    Font.ftPrint(fontSmall, 52, plusYValue+140, 1, 720, 512, "Are you sure you want to continue?", Color.new(255,255,255,GUITAR_Fade))
end

function GUITAR_drawUninstall(prog)
    Screen.clear()
    GUITAR_drawText()
    Font.ftPrint(fontBig, 250, plusYValue+360, 1, 720, 512, "Uninstalling...", Color.new(255,255,255,GUITAR_Fade))
    Graphics.drawRect(360, plusYValue+390, 600, 5, Color.new(255,255,255,GUITAR_Fade))
    Graphics.drawRect(360, plusYValue+390, prog, 5, Color.new(255,0,0,GUITAR_Fade))
    Screen.waitVblankStart()
    Screen.flip()
end


function GUITAR_Uninstall()
    GUITAR_drawUninstall(0)
    GUITAR_Themes = System.listDirectory(System.currentDirectory().."THM") 
    
    for i=1, #GUITAR_Themes do
        if System.doesFileExist(System.currentDirectory().."THM/"..GUITAR_Themes[i].name.."/theme.lua.bak") then
            System.removeFile(System.currentDirectory().."THM/"..GUITAR_Themes[i].name.."/theme.lua")
            GUITAR_drawUninstall((460/#GUITAR_Themes) * (i-1+0.33))
            System.copyFile(System.currentDirectory().."THM/"..GUITAR_Themes[i].name.."/theme.lua.bak", System.currentDirectory().."THM/"..GUITAR_Themes[i].name.."/theme.lua")
            GUITAR_drawUninstall((460/#GUITAR_Themes) * (i-1+0.66))
            System.removeFile(System.currentDirectory().."THM/"..GUITAR_Themes[i].name.."/theme.lua.bak")
            GUITAR_drawUninstall((460/#GUITAR_Themes)*i)
        else
            GUITAR_drawUninstall((460/#GUITAR_Themes)*i)
        end
    end
    
    System.removeFile(System.currentDirectory().."PLG/PLG_GUITAR.lua")
    GUITAR_drawUninstall(488)
    System.removeFile(System.currentDirectory().."PLG/PLG_GUITAR-UNINST.lua")
    GUITAR_drawUninstall(516)
    System.removeFile(System.currentDirectory().."LUA/GUITAR.lua")
    GUITAR_drawUninstall(544)
    System.removeFile(System.currentDirectory().."APPS/GUITAR/uninstall.lua")
    GUITAR_drawUninstall(572)
    System.removeDirectory(System.currentDirectory().."APPS/GUITAR")
    GUITAR_drawUninstall(600)    
    for i = 1, 25 do
        GUITAR_Fade = 255-(i*10)
        GUITAR_drawUninstall(600)
    end
    GUITAR_Reset("XEBPLUS.ELF", "XEBPLUS_XMAS.ELF", "BOOT.ELF")
end


fadeToBlackItem()
for i = 1, 25 do
    GUITAR_Fade = i*10
    Screen.clear()
    GUITAR_drawText()
    Screen.waitVblankStart()
    Screen.flip()
end

while XEBKeepInContextMenu do
    pad = Pads.get()
    Screen.clear()
    dofile(System.currentDirectory().."LUA/GUITAR.lua")
    dofile(System.currentDirectory().."LUA/GUITAR.lua")
    
    GUITAR_drawText()
    
    if GUITAR_Connected == true then
        Font.ftPrint(fontBig, 140, plusYValue+335, 1, 720, 512, "Disconnect guitar controller to continue.", Color.new(255,255,255,255))
    else
        Font.ftPrint(fontBig, 220, plusYValue+335, 1, 720, 512, "Continue:  hold L2 + "..XEBBTNACCEPT, Color.new(255,255,255,255))
        Font.ftPrint(fontBig, 220, plusYValue+360, 1, 720, 512, "Cancel:  "..XEBBTNCANCEL, Color.new(255,255,255,255))
        Graphics.drawRect(360, plusYValue+390, GUITAR_Countdown*15, 5, Color.new(255,255,255,255))
        
        if Pads.check(pad, PAD_ACCEPT) and Pads.check(oldpad, PAD_ACCEPT) and Pads.check(pad, PAD_L2) and Pads.check(oldpad, PAD_L2) then
            
            if GUITAR_Countdown < 40 then
                GUITAR_Countdown = GUITAR_Countdown + 1
            elseif GUITAR_Countdown == 40 then
                GUITAR_Uninstall() 
            end
            
        else
            GUITAR_Countdown = 0
        end
    end
    
    if Pads.check(pad, PAD_CANCEL) and not Pads.check(oldpad, PAD_CANCEL) then
        XEBKeepInContextMenu=false
    end
    
    Screen.waitVblankStart()
    oldpad = pad;
    Screen.flip()
end

if XEBKeepInContextMenu == false then
    for i = 1, 25 do
        GUITAR_Fade = 255-(i*10)
        Screen.clear()
        GUITAR_drawText()
        Screen.waitVblankStart()
        Screen.flip()
    end
    fadeFromBlack()
end
