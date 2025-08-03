GUITAR_currentTheme = System.currentDirectory().."THM/"..loadedTheme.."/theme.lua"
GUITAR_Payload = "dofile(System.currentDirectory()..\"LUA/GUITAR.lua\")"
GUITAR_checkTheme = false
GUITAR_patchTheme = false
GUITAR_Connected = false
GUITAR_Draw = false
GUITAR_Timer = 0

function GUITAR_Reset(Val_A, Val_B, Val_C)
	if System.doesFileExist(System.currentDirectory()..Val_A) then
		System.loadELF(System.currentDirectory()..Val_A, 1)
	elseif System.doesFileExist(System.currentDirectory()..Val_B) then
		System.loadELF(System.currentDirectory()..Val_B, 1)
	elseif System.doesFileExist(System.currentDirectory()..Val_C) then
		System.loadELF(System.currentDirectory()..Val_C, 1)	
	end
end

--Check if theme is patched
GUITAR_tempFile = io.open(GUITAR_currentTheme, "r")
for line in GUITAR_tempFile:lines() do
	line = string.gsub(line, "\x0D", "")
	
	if GUITAR_checkTheme == true then
		if line ~= GUITAR_Payload then
			GUITAR_patchTheme = true
		end
		break
	end
	
	if string.match(line, "function thmDrawBKG()") then
        GUITAR_checkTheme = true
	end
end
GUITAR_tempFile:close()

--Patch theme
if GUITAR_patchTheme == true then
	System.copyFile(GUITAR_currentTheme, GUITAR_currentTheme..".bak")
	GUITAR_tempFile = io.open(GUITAR_currentTheme, "r")
	
	temp = io.open("tmp.lua", "a")
	io.output(temp)
	for line in GUITAR_tempFile:lines() do
		line = string.gsub(line, "\x0D", "")
		io.write(line.."\n")
		
		if string.match(line, "function thmDrawBKG()") then
			io.write(GUITAR_Payload.."\n")
		end
	end
	
	io.close(temp)	
	GUITAR_tempFile:close()
	System.removeFile(GUITAR_currentTheme)
	System.copyFile("tmp.lua", GUITAR_currentTheme)
	System.removeFile(System.currentDirectory().."tmp.lua")
	
	GUITAR_Reset("XEBPLUS.ELF", "XEBPLUS_XMAS.ELF", "BOOT.ELF")
end
