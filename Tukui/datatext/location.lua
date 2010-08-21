--------------------------------------------------------------------
 -- LOCATION by Foof, edited for v11 by Toresh
--------------------------------------------------------------------
if TukuiCF["datatext"].location and TukuiCF["datatext"].location > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	
	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].location, Text)
 
	local function OnEvent(self, event)
		local location = GetRealZoneText()
		local pvpType, isFFA, zonePVPStatus = GetZonePVPInfo()
		
		if (pvpType == "sanctuary") then
			location = "|cff69C9EF"..location.."|r" -- light blue
		elseif (pvpType == "friendly") then
			location = "|cff00ff00"..location.."|r" -- green
		elseif (pvpType == "contested") then
			location = "|cffffff00"..location.."|r" -- yellow
		elseif (pvpType == "hostile" or pvpType == "combat" or pvpType == "arena" or not pvpType) then
			location = "|cffff0000"..location.."|r" -- red
		else
			location = location -- white
		end
		
		Text:SetText(location)
		--UIFrameFadeIn(TukuiLocationPanel, 0.5, 0, 1)
	end
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	Stat:SetScript("OnMouseDown", function() ToggleFrame(WorldMapFrame) end)
	Stat:SetScript("OnEvent", OnEvent)

end