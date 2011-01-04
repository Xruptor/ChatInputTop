--I just wanted a simple mod that would display the InputBox on the top of the ChatFrame rather then the bottom

local eventFrame = CreateFrame("Frame", "ChatInputTop_EventFrame", UIParent)
eventFrame:RegisterEvent("ADDON_LOADED")

eventFrame:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" and select(1, ...) == "ChatInputTop" then
		if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage("ChatInputTop Loaded.");
		end
        
		for i = 1, NUM_CHAT_WINDOWS do
			local n = ("ChatFrame%d"):format(i)
			local eb = _G[("ChatFrame%dEditBox"):format(i)]

			eb:ClearAllPoints()
			eb:SetPoint("BOTTOMLEFT",  ("ChatFrame%d"):format(i), "TOPLEFT",  -5, 0)
			eb:SetPoint("BOTTOMRIGHT", ("ChatFrame%d"):format(i), "TOPRIGHT", 5, 0)
			
			--when the editbox is on the top, complications occur because sometimes you are not allowed to click on the tabs.
			--to fix this we'll just make the tab close the editbox
			--also force the editbox to hide itself when it loses focus
			_G[n.."Tab"]:HookScript("OnClick", function() eb:Hide() end)
			eb:HookScript("OnEditFocusLost", function(self) self:Hide() end)
			
		end

		eventFrame:UnregisterEvent("ADDON_LOADED")
	end
end)
