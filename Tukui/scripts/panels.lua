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
icentre:SetWidth(((TukuiDB.buttonsize * 19) + (TukuiDB.buttonspacing * 16))+2)

local barbg = CreateFrame("Frame", "TukuiActionBarBackground", UIParent)
TukuiDB.CreatePanel(barbg, 1, 1, "BOTTOM", icentre, "TOP", 0, TukuiDB.Scale(4))
barbg:SetWidth((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13))
	if TukuiCF["actionbar"].bottomrows == 2 then
		barbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	else
		barbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	end
	
barbg:SetFrameStrata("BACKGROUND")
barbg:SetFrameLevel(1)


if TukuiCF["actionbar"].splitbar == true then
	-- Left Split Bar
	local leftbg = CreateFrame("Frame", "TukuiLeftSplitABBackground", UIParent)
	TukuiDB.CreatePanel(leftbg, 1, 1, "RIGHT", barbg, "LEFT", TukuiDB.Scale(-4), 0)
	leftbg:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
	if TukuiCF["actionbar"].bottomrows == 2 then
		leftbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	else
		leftbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	end
 
	-- Right Split Bar
	local rightbg = CreateFrame("Frame", "TukuiRightSplitABBackground", UIParent)
	TukuiDB.CreatePanel(rightbg, 1, 1, "LEFT", barbg, "RIGHT", TukuiDB.Scale(4), 0)
	rightbg:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
	if TukuiCF["actionbar"].bottomrows == 2 then
		rightbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	else
		rightbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	end
end


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


--NEW STAT PANELS // MINIMAP
if TukuiMinimap then
	
	--location panel
	local locationpanel = CreateFrame("Frame", "TukuiLocationPanel", TukuiMinimap)
	TukuiDB.CreatePanel(locationpanel, TukuiMinimap:GetWidth() + 4, 19, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, TukuiDB.Scale(-4))
	
	--left stats
	local minimapstatsleft = CreateFrame("Frame", "TukuiMinimapStatsLeft", locationpanel)
	TukuiDB.CreatePanel(minimapstatsleft, (TukuiMinimap:GetWidth() / 2), 19, "TOPLEFT", locationpanel, "BOTTOMLEFT", 0, TukuiDB.Scale(-4))
	
	--right stats
	local minimapstatsright = CreateFrame("Frame", "TukuiMinimapStatsRight", locationpanel)
	TukuiDB.CreatePanel(minimapstatsright, (TukuiMinimap:GetWidth() / 2), 19, "TOPRIGHT", locationpanel, "BOTTOMRIGHT", 0, TukuiDB.Scale(-4))
	
	 --minimap stats top
	local minimapstatstop = CreateFrame("Frame", "TukuiMinimapStatsTop", TukuiMinimap)
	TukuiDB.CreatePanel(minimapstatstop, (TukuiMinimap:GetWidth() + 4), 19, "TOPLEFT", TukuiMinimap, "TOPLEFT", 0, TukuiDB.Scale(22))
	
end

--Cooldown bar
if TukuiCF["actionbar"].cooldownbar then
	local cooldown = CreateFrame("Frame", "cooldown", barbg)
	TukuiDB.CreatePanel(cooldown, 1, 30, "Bottom", TukuiActionBarBackground, "TOP", 0, TukuiDB.Scale(4))
	cooldown:SetWidth(TukuiInfoCentre:GetWidth()+2)
end


--Chat backgrounds thanks to Hydra
-- CHAT LEFT
local chatleft = CreateFrame("Frame", "ChatLeft", TukuiInfoLeft)
	TukuiDB.CreatePanel(chatleft, TukuiCF["panels"].tinfowidth, TukuiDB.Scale(125), "BOTTOM", TukuiInfoLeft, "TOP", 0, TukuiDB.Scale(3))
	chatleft:SetFrameLevel(2)
	chatleft:SetBackdropColor(.075,.075,.075,.7)
	chatleft:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
	 
	leftborder = CreateFrame("Frame", nil, UIParent)
	leftborder:SetPoint("TOPLEFT", ChatLeft, "TOPLEFT", -1, 1)
	leftborder:SetFrameStrata("BACKGROUND")
	leftborder:SetBackdrop {
	edgeFile = TukuiCF["media"].blank, edgeSize = 3,
	insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
	leftborder:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
	leftborder:SetBackdropBorderColor(unpack(TukuiCF["media"].backdropcolor))
	leftborder:SetPoint("BOTTOMRIGHT", ChatLeft, "BOTTOMRIGHT", 1, -1)
 
-- CHAT RIGHT
local chatright = CreateFrame("Frame", "ChatRight", TukuiInfoRight)
	TukuiDB.CreatePanel(chatright, TukuiCF["panels"].tinfowidth, TukuiDB.Scale(125), "BOTTOM", TukuiInfoRight, "TOP", 0, TukuiDB.Scale(3))
	chatright:SetFrameLevel(2)
	chatright:SetBackdropColor(.075,.075,.075,.7)
	chatright:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
	 
	rightborder = CreateFrame("Frame", nil, UIParent)
	rightborder:SetPoint("TOPLEFT", ChatRight, "TOPLEFT", -1, 1)
	rightborder:SetFrameStrata("BACKGROUND")
	rightborder:SetBackdrop {
	edgeFile = TukuiCF["media"].blank, edgeSize = 3,
	insets = {left = 0, right = 0, top = 0, bottom = 0}
	}
	rightborder:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
	rightborder:SetBackdropBorderColor(unpack(TukuiCF["media"].backdropcolor))
	rightborder:SetPoint("BOTTOMRIGHT", ChatRight, "BOTTOMRIGHT", 1, -1)


--RIGHT BAR BACKGROUND
if TukuiCF["actionbar"].enable == true or not (IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4") or IsAddOnLoaded("Macaroon")) then
	local barbgr = CreateFrame("Frame", "TukuiActionBarBackgroundRight", MultiBarRight)
	TukuiDB.CreatePanel(barbgr, 1, (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-23), TukuiDB.Scale(-13.5))
	if TukuiCF["actionbar"].rightbars == 1 then
		barbgr:SetWidth(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	elseif TukuiCF["actionbar"].rightbars == 2 then
		barbgr:SetWidth((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	elseif TukuiCF["actionbar"].rightbars == 3 then
		barbgr:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
	else
		barbgr:Hide()
	end

	local petbg = CreateFrame("Frame", "TukuiPetActionBarBackground", PetActionButton1)
	if TukuiCF["actionbar"].rightbars > 0 then
		TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", barbgr, "LEFT", TukuiDB.Scale(-6), 0)
	else
		TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-6), TukuiDB.Scale(-13.5))
	end
end

--BATTLEGROUND STATS FRAME
if TukuiCF["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	TukuiDB.CreatePanel(bgframe, 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(3)
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
			name, killingBlows, honorKills, deaths, honorGained, faction, rank, race, class, classToken, damageDone, healingDone  = GetBattlefieldScore(i);
			if ( name ) then
				if ( name == UnitName("player") ) then
					GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, TukuiDB.Scale(4));
					GameTooltip:ClearLines()
					GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.Scale(1))
					GameTooltip:ClearLines()
					GameTooltip:AddLine(tukuilocal.datatext_ttstatsfor.."[|cffCC0033"..name.."|r]")
					GameTooltip:AddLine' '
					GameTooltip:AddDoubleLine(tukuilocal.datatext_ttkillingblows, killingBlows,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_tthonorkills, honorKills,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_ttdeaths, deaths,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_tthonorgain, honorGained,1,1,1)
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