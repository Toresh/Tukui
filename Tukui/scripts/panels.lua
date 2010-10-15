-- ACTION BAR PANEL
TukuiDB.buttonsize = TukuiDB.Scale(25)
TukuiDB.buttonspacing = TukuiDB.Scale(4)
TukuiDB.petbuttonsize = TukuiDB.Scale(25)
TukuiDB.petbuttonspacing = TukuiDB.Scale(4)

-- set left and right info panel width
TukuiCF["panels"] = {["tinfowidth"] = 352}


--  Info Centre
local icentre = CreateFrame("Frame", "TukuiInfoCentre", UIParent)
TukuiDB.CreatePanel(icentre, 1, 23, "BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(14))
if TukuiCF["actionbar"].splitbar == true and TukuiCF["actionbar"].bottomrows == 2 then
	icentre:SetWidth(((TukuiDB.buttonsize * 18) + (TukuiDB.buttonspacing * 21))+ (TukuiDB.Scale(4) * 2))
else
	icentre:SetWidth((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13))
end

--action bar background
local barbg = CreateFrame("Frame", "TukuiActionBarBackground", UIParent)
TukuiDB.CreatePanel(barbg, 1, 1, "BOTTOM", icentre, "TOP", 0, TukuiDB.Scale(4))
if TukuiDB.lowversion == true then
	barbg:SetWidth((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13))
	if TukuiCF["actionbar"].bottomrows == 2 then
		barbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	else
		barbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	end
else
	barbg:SetWidth((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13))
	if TukuiCF["actionbar"].bottomrows == 2 then
		barbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	else
		barbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	end
end
barbg:SetFrameStrata("BACKGROUND")
barbg:SetFrameLevel(1)

-- INVISIBLE FRAME COVERING TukuiActionBarBackground
local invbarbg = CreateFrame("Frame", "InvTukuiActionBarBackground", UIParent)
invbarbg:SetSize(barbg:GetWidth(), barbg:GetHeight())
invbarbg:SetPoint("BOTTOM", 0, TukuiDB.Scale(14))

if TukuiCF["actionbar"].splitbar == true and TukuiCF["actionbar"].bottomrows == 2 then
	-- Left Split Bar
	local leftbg = CreateFrame("Frame", "TukuiLeftSplitABBackground", UIParent)
	TukuiDB.CreatePanel(leftbg, 1, 1, "RIGHT", barbg, "LEFT", TukuiDB.Scale(-4), 0)
	leftbg:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
	leftbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
 
	-- Right Split Bar
	local rightbg = CreateFrame("Frame", "TukuiRightSplitABBackground", UIParent)
	TukuiDB.CreatePanel(rightbg, 1, 1, "LEFT", barbg, "RIGHT", TukuiDB.Scale(4), 0)
	rightbg:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
	rightbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
end

--[[ CUBE AT LEFT, ACT AS A BUTTON (CHAT MENU)
local cubeleft = CreateFrame("Frame", "TukuiCubeLeft", barbg)
TukuiDB.CreatePanel(cubeleft, 10, 10, "BOTTOM", ileftlv, "TOP", 0, 0)
cubeleft:EnableMouse(true)
cubeleft:SetScript("OnMouseDown", function(self, btn)
	if TukuiInfoLeftBattleGround then
		if btn == "RightButton" then
			if TukuiInfoLeftBattleGround:IsShown() then
				TukuiInfoLeftBattleGround:Hide()
			else
				TukuiInfoLeftBattleGround:Show()
			end
		end
	end
	
	if btn == "LeftButton" then	
		ToggleFrame(ChatMenu)
	end
end)--]]

--[[ CUBE AT RIGHT, ACT AS A BUTTON (CONFIGUI or BG'S)
local cuberight = CreateFrame("Frame", "TukuiCubeRight", barbg)
TukuiDB.CreatePanel(cuberight, 10, 10, "BOTTOM", irightlv, "TOP", 0, 0)
if TukuiCF["bags"].enable then
	cuberight:EnableMouse(true)
	cuberight:SetScript("OnMouseDown", function(self)
		ToggleKeyRing()
	end)
end--]]


-- INFO LEFT (FOR STATS)
local ileft = CreateFrame("Frame", "TukuiInfoLeft", barbg)
TukuiDB.CreatePanel(ileft, TukuiCF["panels"].tinfowidth, 23, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", TukuiDB.Scale(14), TukuiDB.Scale(14))
ileft:SetFrameLevel(2)
ileft:SetFrameStrata("BACKGROUND")

-- INFO RIGHT (FOR STATS)
local iright = CreateFrame("Frame", "TukuiInfoRight", barbg)
TukuiDB.CreatePanel(iright, TukuiCF["panels"].tinfowidth, 23, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", TukuiDB.Scale(-14), TukuiDB.Scale(14))
iright:SetFrameLevel(2)
iright:SetFrameStrata("BACKGROUND")

if TukuiMinimap then

	if TukuiCF["map"].location == true then
		--location panel
		local locationpanel = CreateFrame("Frame", "TukuiLocationPanel", TukuiMinimap)
		TukuiDB.CreatePanel(locationpanel, TukuiMinimap:GetWidth() + 4, 19, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, TukuiDB.Scale(-4))
		--left stats
		local minimapstatsleft = CreateFrame("Frame", "TukuiMinimapStatsLeft", locationpanel)
		TukuiDB.CreatePanel(minimapstatsleft, (TukuiMinimap:GetWidth() / 2), 19, "TOPLEFT", locationpanel, "BOTTOMLEFT", 0, TukuiDB.Scale(-4))
		--right stats
		local minimapstatsright = CreateFrame("Frame", "TukuiMinimapStatsRight", locationpanel)
		TukuiDB.CreatePanel(minimapstatsright, (TukuiMinimap:GetWidth() / 2), 19, "TOPRIGHT", locationpanel, "BOTTOMRIGHT", 0, TukuiDB.Scale(-4))
	else
		--left stats
		local minimapstatsleft = CreateFrame("Frame", "TukuiMinimapStatsLeft", TukuiMinimap)
		TukuiDB.CreatePanel(minimapstatsleft, ((TukuiMinimap:GetWidth() + 4) / 2) - 1, 19, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, TukuiDB.Scale(-2))
		--right stats
		local minimapstatsright = CreateFrame("Frame", "TukuiMinimapStatsRight", TukuiMinimap)
		TukuiDB.CreatePanel(minimapstatsright, ((TukuiMinimap:GetWidth() + 4) / 2) -1, 19, "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, TukuiDB.Scale(-2))
	end
	
	 --minimap stats top
	if TukuiCF["map"].topinfo == true then
		local minimapstatstop = CreateFrame("Frame", "TukuiMinimapStatsTop", TukuiMinimap)
		TukuiDB.CreatePanel(minimapstatstop, (TukuiMinimap:GetWidth() + 4), 19, "TOPLEFT", TukuiMinimap, "TOPLEFT", 0, TukuiDB.Scale(22))
	end
end

--Cooldown bar
if TukuiCF["actionbar"].cooldownbar then
	local cooldown = CreateFrame("Frame", "cooldown", barbg)
	TukuiDB.CreatePanel(cooldown, 1, 30, "Bottom", TukuiActionBarBackground, "TOP", 0, TukuiDB.Scale(4))
	
	if TukuiCF["actionbar"].splitbar == true and TukuiCF["actionbar"].bottomrows == 2 then
		cooldown:SetWidth(((TukuiDB.buttonsize * 18) + (TukuiDB.buttonspacing * 21))+ (TukuiDB.Scale(4) * 2))
	else
		cooldown:SetWidth((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13))
	end
end

--Chat background
if TukuiCF["actionbar"].chatbackground == true then
-- CHAT LEFT
local chatleft = CreateFrame("Frame", "ChatLeft", TukuiInfoLeft)
	TukuiDB.CreatePanel(chatleft, TukuiCF["panels"].tinfowidth, TukuiDB.Scale(125), "BOTTOM", TukuiInfoLeft, "TOP", 0, TukuiDB.Scale(3))
	chatleft:SetFrameLevel(0)
	chatleft:SetFrameStrata("BACKGROUND")
 
-- CHAT RIGHT
local chatright = CreateFrame("Frame", "ChatRight", TukuiInfoRight)
	TukuiDB.CreatePanel(chatright, TukuiCF["panels"].tinfowidth, TukuiDB.Scale(125), "BOTTOM", TukuiInfoRight, "TOP", 0, TukuiDB.Scale(3))
	chatright:SetFrameLevel(0)
	chatright:SetFrameStrata("BACKGROUND")
end

--RIGHT BAR BACKGROUND
if TukuiCF["actionbar"].enable == true then
	local barbgr = CreateFrame("Frame", "TukuiActionBarBackgroundRight", UIParent)
	
	if TukuiCF["actionbar"].horizonbars == true then
		TukuiDB.CreatePanel(barbgr, (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13), 1, "BOTTOMLEFT", ChatRight, "TOPLEFT", TukuiDB.Scale(0), TukuiDB.Scale(4))
		if TukuiCF["actionbar"].rightbars == 1 then
			barbgr:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
		elseif TukuiCF["actionbar"].rightbars > 1 then
			barbgr:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
		else
			barbgr:Hide()
		end
	else
		TukuiDB.CreatePanel(barbgr, 1, (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-14), TukuiDB.Scale(-13.5))
		if TukuiCF["actionbar"].rightbars == 1 then
			barbgr:SetWidth(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
		elseif TukuiCF["actionbar"].rightbars > 1 then
			barbgr:SetWidth((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
		else
			barbgr:Hide()
		end
	end

	local petbg = CreateFrame("Frame", "TukuiPetActionBarBackground", PetActionButton1)
	if TukuiCF["actionbar"].horizonbars == true then
		if TukuiCF["actionbar"].rightbars > 0 then
			TukuiDB.CreatePanel(petbg, (TukuiDB.petbuttonsize * 10)+ (TukuiDB.petbuttonspacing * 11), TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), "BOTTOMRIGHT", barbgr, "TOPRIGHT", 0, TukuiDB.Scale(4))
		else
			TukuiDB.CreatePanel(petbg, (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), "BOTTOMRIGHT", ChatRight, "TOPRIGHT", 0, TukuiDB.Scale(4))
		end
	
	else 
		if TukuiCF["actionbar"].rightbars > 0 then
			TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", barbgr, "LEFT", TukuiDB.Scale(-6), 0)
		else
			TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-6), TukuiDB.Scale(-13.5))
		end
	end
end

--BATTLEGROUND STATS FRAME
if TukuiCF["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	TukuiDB.CreatePanel(bgframe, 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
	local function OnEvent(self, event)
		if event == "PLAYER_ENTERING_WORLD" then
			inInstance, instanceType = IsInInstance()
			if inInstance and (instanceType == "pvp") then
				bgframe:Show()
			else
				bgframe:Hide()
			end
		end
	end
	bgframe:SetScript("OnEnter", function(self)
	local numScores = GetNumBattlefieldScores()
		for i=1, numScores do
			name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
			if ( name ) then
				if ( name == UnitName("player") ) then
					GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, TukuiDB.Scale(4));
					GameTooltip:ClearLines()
					GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.Scale(1))
					GameTooltip:ClearLines()
					GameTooltip:AddLine(tukuilocal.datatext_ttstatsfor.."[|cffCC0033"..name.."|r]")
					GameTooltip:AddLine' '
					GameTooltip:AddDoubleLine(tukuilocal.datatext_ttkillingblows, killingBlows,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_tthonorkills, honorableKills,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_ttdeaths, deaths,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_tthonorgain, format('%d', honorGained),1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_ttdmgdone, damageDone,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_tthealdone, healingDone,1,1,1)
					--Add extra statistics to watch based on what BG you are in.
					if GetRealZoneText() == "Arathi Basin" then --
						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesassaulted,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesdefended,GetBattlefieldStatData(i, 2),1,1,1)
					elseif GetRealZoneText() == "Warsong Gulch" then --
						GameTooltip:AddDoubleLine(tukuilocal.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_flagsreturned,GetBattlefieldStatData(i, 2),1,1,1)
					elseif GetRealZoneText() == "Eye of the Storm" then --
						GameTooltip:AddDoubleLine(tukuilocal.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
					elseif GetRealZoneText() == "Alterac Valley" then
						GameTooltip:AddDoubleLine(tukuilocal.datatext_graveyardsassaulted,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_graveyardsdefended,GetBattlefieldStatData(i, 2),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_towersassaulted,GetBattlefieldStatData(i, 3),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_towersdefended,GetBattlefieldStatData(i, 4),1,1,1)
					elseif GetRealZoneText() == "Strand of the Ancients" then
						GameTooltip:AddDoubleLine(tukuilocal.datatext_demolishersdestroyed,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_gatesdestroyed,GetBattlefieldStatData(i, 2),1,1,1)
					elseif GetRealZoneText() == "Isle of Conquest" then
						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesassaulted,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesdefended,GetBattlefieldStatData(i, 2),1,1,1)
					end					
					GameTooltip:Show()
				end
			end
		end
	end) 
	bgframe:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	bgframe:RegisterEvent("PLAYER_ENTERING_WORLD")
	bgframe:SetScript("OnEvent", OnEvent)
end