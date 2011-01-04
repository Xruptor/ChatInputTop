--I just wanted a simple mod that would display the InputBox on the top of the ChatFrame rather then the bottom

local eventFrame = CreateFrame("Frame", "ChatInputTop_EventFrame", UIParent)
eventFrame:RegisterEvent("ADDON_LOADED")

eventFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" and select(1, ...) == "ChatInputTop" then
		if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage("ChatInputTop Loaded.");
		end
        
		for i = 1, NUM_CHAT_WINDOWS do
			local eb = _G[("ChatFrame%dEditBox"):format(i)]

			eb:ClearAllPoints()
			eb:SetPoint("BOTTOMLEFT",  ("ChatFrame%d"):format(i), "TOPLEFT",  -5, 0)
			eb:SetPoint("BOTTOMRIGHT", ("ChatFrame%d"):format(i), "TOPRIGHT", 5, 0)
		end

		eventFrame:UnregisterEvent("ADDON_LOADED")
	end
end)
