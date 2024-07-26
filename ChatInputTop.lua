--I just wanted a simple mod that would display the InputBox on the top of the ChatFrame rather then the bottom

local ADDON_NAME, addon = ...
if not _G[ADDON_NAME] then
	_G[ADDON_NAME] = CreateFrame("Frame", ADDON_NAME, UIParent, BackdropTemplateMixin and "BackdropTemplate")
end
addon = _G[ADDON_NAME]

addon:RegisterEvent("ADDON_LOADED")
addon:SetScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" or event == "PLAYER_LOGIN" then
		if event == "ADDON_LOADED" then
			local arg1 = ...
			if arg1 and arg1 == ADDON_NAME then
				self:UnregisterEvent("ADDON_LOADED")
				self:RegisterEvent("PLAYER_LOGIN")
			end
			return
		end
		if IsLoggedIn() then
			self:EnableAddon(event, ...)
			self:UnregisterEvent("PLAYER_LOGIN")
		end
		return
	end
	if self[event] then
		return self[event](self, event, ...)
	end
end)

function addon:EnableAddon()

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
	
	local ver = C_AddOns.GetAddOnMetadata(ADDON_NAME,"Version") or '1.0'
	DEFAULT_CHAT_FRAME:AddMessage(string.format("|cFF99CC33%s|r [v|cFF20ff20%s|r] loaded.", ADDON_NAME, ver or "1.0"))
end
