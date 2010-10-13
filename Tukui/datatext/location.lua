if TukuiCF["datatext"].location and TukuiCF["datatext"].location > 0 then
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("HIGH")
	Stat:EnableMouse(true)
	
	local Text  = TukuiInfoLeft:CreateFontString(nil, "LOW")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].location, Text)

	local int = 1
	local function Update(self, t)
		int = int - t
		if int < 0 then
			local zoneName = GetRealZoneText()
			local pvpType, isSubZonePvP, factionName = GetZonePVPInfo()

			if pvpType == "sanctuary" then
				Text:SetTextColor(.41, .8, .94)
			elseif pvpType == "arena" then
				Text:SetTextColor(1, .1, .1)
			elseif pvpType == "friendly" then
				Text:SetTextColor(.1, 1, .1)
			elseif pvpType == "hostile" then
				Text:SetTextColor(1, .1, .1)
			elseif pvpType == "contested" then
				Text:SetTextColor(1, .7, 0)
			elseif pvpType == "combat" then
				Text:SetTextColor(1, .1, .1)
			elseif pvpType == nil then
				Text:SetTextColor(1, 1, 1)
			end
			Text:SetText(zoneName)
			int = 1
		end
		
		self:SetAllPoints(Text)
		self:SetScript("OnEnter", function()
			--[[local x, y = GetPlayerMapPosition("player");
			local coords = format("%.1f - %.1f", x*100, y*100)
			GameTooltip:SetOwner(this, "ANCHOR_TOP");
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.mult)
			GameTooltip:ClearLines()
			--GameTooltip:AddDoubleLine(cStart .. "Sub Zone: " .. cEnd, GetMinimapZoneText(), _, _, _, 1, 1, 1)
			--GameTooltip:AddDoubleLine(cStart .. "Coordinates: " .. cEnd, coords, _, _, _, 1, 1, 1)
			GameTooltip:Show()--]]
		end)
		self:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end
	
	Stat:SetScript("OnUpdate", Update)
	Stat:SetScript("OnMouseDown", function() ToggleFrame(WorldMapFrame) end)
	Update(Stat, 10)
end
