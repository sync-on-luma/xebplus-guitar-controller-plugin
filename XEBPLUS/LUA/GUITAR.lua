if Pads.check(oldpad, PAD_LEFT) and Pads.check(pad, PAD_LEFT) then
    if GUITAR_Timer < 120 then
        GUITAR_Timer = GUITAR_Timer + 1
    elseif GUITAR_Timer == 120 then
        GUITAR_Connected = true
    end
end

if GUITAR_Connected == true then
    
    if GUITAR_Draw == false then 
        pad = pad - 128 
        
        if Pads.check(pad, PAD_L2) then
            pad = pad - 256
        end
        if Pads.check(pad, PAD_TRIANGLE) then
            pad = pad - 4096
            pad = pad + 128
        end
        if Pads.check(pad, PAD_CROSS) then
            pad = pad - 16384
            pad = pad + 32
        end
        if Pads.check(pad, PAD_R2) then
            pad = pad - 256
            pad = pad + 16384
        end
        if Pads.check(pad, PAD_START) then
            pad = pad - 8
            pad = pad + 2048
        end
        
        
        if pad == -128 or pad == -4576 then
            GUITAR_Timer = GUITAR_Timer - 2
            pad = 0
        elseif pad == 0 then
            GUITAR_clearKey = false
        elseif pad < 0 or GUITAR_clearKey == true then
            pad = 0
        elseif pad >= 128 then
            GUITAR_clearKey = true
        end
        
        if GUITAR_Timer == 0 then
            GUITAR_Connected = false
        end
        GUITAR_Draw = true
    
    elseif GUITAR_Draw == true then
        Graphics.drawImage(themeInUse[56], 40, 405)
        GUITAR_Draw = false
    end
end





