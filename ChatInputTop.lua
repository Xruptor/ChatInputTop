--I just wanted a simple mod that would display the InputBox on the top of the ChatFrame rather then the bottom

local f = CreateFrame("frame","ChatInputTop",UIParent)
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

f:RegisterEvent("ADDON_LOADED")

function f:ADDON_LOADED(self, event, ...)
	if arg1 == "ChatInputTop" then
		if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage("ChatInputTop Loaded.");
		end
        
		for i = 1, NUM_CHAT_WINDOWS do
			local eb = _G[("ChatFrame%dEditBox"):format(i)]

			eb:ClearAllPoints()
			eb:SetPoint("BOTTOMLEFT",  ("ChatFrame%d"):format(i), "TOPLEFT",  -5, 0)
			eb:SetPoint("BOTTOMRIGHT", ("ChatFrame%d"):format(i), "TOPRIGHT", 5, 0)
		end

		f:UnregisterEvent("ADDON_LOADED");
	end
end
