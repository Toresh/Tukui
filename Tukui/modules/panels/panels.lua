local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales


--  Info Centre
local icentre = CreateFrame("Frame", "TukuiInfoCentre", UIParent)
icentre:CreatePanel("Defualt", 1, 23, "BOTTOM", UIParent, "BOTTOM", 0, 14)
icentre:SetWidth((T.buttonsize * 18) + (T.buttonspacing * 21) + 8)

local TukuiBar1 = CreateFrame("Frame", "TukuiBar1", UIParent, "SecureHandlerStateTemplate")
TukuiBar1:CreatePanel("Default", 1, 1, "BOTTOM", icentre, "TOP", 0, 4)
TukuiBar1:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar1:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar1:SetFrameStrata("BACKGROUND")
TukuiBar1:SetFrameLevel(1)

--left split bar
local TukuiBar2 = CreateFrame("Frame", "TukuiBar2", UIParent)
TukuiBar2:CreatePanel("Default", 1, 1, "BOTTOMRIGHT", TukuiBar1, "BOTTOMLEFT", -4, 0)
TukuiBar2:SetWidth((T.buttonsize * 3) + (T.buttonspacing * 4))
TukuiBar2:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar2:SetFrameStrata("BACKGROUND")
TukuiBar2:SetFrameLevel(2)

--right split bar
local TukuiBar3 = CreateFrame("Frame", "TukuiBar3", UIParent)
TukuiBar3:CreatePanel("Default", 1, 1, "BOTTOMLEFT", TukuiBar1, "BOTTOMRIGHT", 4, 0)
TukuiBar3:SetWidth((T.buttonsize * 3) + (T.buttonspacing * 4))
TukuiBar3:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar3:SetFrameStrata("BACKGROUND")
TukuiBar3:SetFrameLevel(2)

local TukuiBar4 = CreateFrame("Frame", "TukuiBar4", UIParent)
TukuiBar4:CreatePanel("Default", 1, 1, "BOTTOM", icentre, "TOP", 0, 4)
TukuiBar4:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar4:SetHeight((T.buttonsize * 2) + (T.buttonspacing * 3))
TukuiBar4:SetFrameStrata("BACKGROUND")
TukuiBar4:SetFrameLevel(2)

local TukuiBar5 = CreateFrame("Frame", "TukuiBar5", UIParent)
TukuiBar5:CreatePanel("Default", 1, (T.buttonsize * 12) + (T.buttonspacing * 13), "RIGHT", UIParent, "RIGHT", -23, -14)
TukuiBar5:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar5:SetFrameStrata("BACKGROUND")
TukuiBar5:SetFrameLevel(2)

local TukuiBar6 = CreateFrame("Frame", "TukuiBar6", UIParent)
TukuiBar6:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar6:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar6:SetPoint("LEFT", TukuiBar5, "LEFT", 0, 0)
TukuiBar6:SetFrameStrata("BACKGROUND")
TukuiBar6:SetFrameLevel(2)

local TukuiBar7 = CreateFrame("Frame", "TukuiBar7", UIParent)
TukuiBar7:SetWidth((T.buttonsize * 1) + (T.buttonspacing * 2))
TukuiBar7:SetHeight((T.buttonsize * 12) + (T.buttonspacing * 13))
TukuiBar7:SetPoint("TOP", TukuiBar5, "TOP", 0 , 0)
TukuiBar7:SetFrameStrata("BACKGROUND")
TukuiBar7:SetFrameLevel(2)

local petbg = CreateFrame("Frame", "TukuiPetBar", UIParent, "SecureHandlerStateTemplate")
petbg:CreatePanel("Default", T.petbuttonsize + (T.petbuttonspacing * 2), (T.petbuttonsize * 10) + (T.petbuttonspacing * 11), "RIGHT", TukuiBar5, "LEFT", -6, 0)

local ltpetbg1 = CreateFrame("Frame", "TukuiLineToPetActionBarBackground", petbg)
ltpetbg1:CreatePanel("Default", 24, 265, "LEFT", petbg, "RIGHT", 0, 0)
ltpetbg1:SetParent(petbg)
ltpetbg1:SetFrameStrata("BACKGROUND")
ltpetbg1:SetFrameLevel(0)
ltpetbg1:SetAlpha(.8)

-- INVISIBLE FRAME COVERING BOTTOM ACTIONBARS JUST TO PARENT UF CORRECTLY
local invbarbg = CreateFrame("Frame", "InvTukuiActionBarBackground", UIParent)
if T.lowversion then
	invbarbg:SetPoint("TOPLEFT", TukuiBar1)
	invbarbg:SetPoint("BOTTOMRIGHT", TukuiBar1)
	TukuiBar2:Hide()
	TukuiBar3:Hide()
else
	invbarbg:SetPoint("TOPLEFT", TukuiBar2)
	invbarbg:SetPoint("BOTTOMRIGHT", TukuiBar3)
end


-- CUBE AT LEFT, ACT AS A BUTTON (CHAT MENU)
local cubeleft = CreateFrame("Frame", "TukuiCubeLeft", icentre)
cubeleft:CreatePanel("Default", 10, 10, "RIGHT", icentre, "LEFT", -4, 0)
cubeleft:EnableMouse(true)
cubeleft:SetScript("OnMouseDown", function(self, btn)
	if TukuiInfoLeftBattleGround and UnitInBattleground("player") then
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
end)

-- CUBE AT RIGHT, ACT AS A BUTTON (CONFIGUI or BG'S)
local cuberight = CreateFrame("Frame", "TukuiCubeRight", icentre)
cuberight:CreatePanel("Default", 10, 10, "LEFT", icentre, "RIGHT", 4, 0)
if C["bags"].enable then
	cuberight:EnableMouse(true)
	cuberight:SetScript("OnMouseDown", function(self)
		ToggleKeyRing()
	end)
end

-- MOVE/HIDE SOME ELEMENTS IF CHAT BACKGROUND IS ENABLED
--local movechat = 0
--if C.chat.background then movechat = 10 ileftlv:SetAlpha(0) irightlv:SetAlpha(0) end

-- INFO LEFT (FOR STATS)
local ileft = CreateFrame("Frame", "TukuiInfoLeft", TukuiBar1)
ileft:CreatePanel("Default", T.InfoLeftRightWidth, 23, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", 14, 14)
ileft:SetFrameLevel(2)
ileft:SetFrameStrata("BACKGROUND")

-- INFO RIGHT (FOR STATS)
local iright = CreateFrame("Frame", "TukuiInfoRight", TukuiBar1)
iright:CreatePanel("Default", T.InfoLeftRightWidth, 23, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -14, 14)
iright:SetFrameLevel(2)
iright:SetFrameStrata("BACKGROUND")


if C.chat.background then	
	-- CHAT BG LEFT
	local chatleftbg = CreateFrame("Frame", "TukuiChatBackgroundLeft", TukuiInfoLeft)
	chatleftbg:CreatePanel("Transparent", T.InfoLeftRightWidth, 145, "BOTTOM", TukuiInfoLeft, "BOTTOM", 0, 0)

	-- CHAT BG RIGHT
	local chatrightbg = CreateFrame("Frame", "TukuiChatBackgroundRight", TukuiInfoRight)
	chatrightbg:CreatePanel("Transparent", T.InfoLeftRightWidth, 145, "BOTTOM", TukuiInfoRight, "BOTTOM", 0, 0)
	chatrightbg:Hide() --This will get shown if a chat exists in the bottomright corner	
end

if C["actionbar"].cooldownbar then
	local cooldown = CreateFrame("Frame", "Tukuicooldown", invbarbg)
	cooldown:CreatePanel("Default", 1, 30, "Bottom", TukuiBar1, "TOP", 0, 4)
	
	--if C["actionbar"].splitbar == true and C["actionbar"].bottomrows == 2 then
		cooldown:SetWidth(((T.buttonsize * 18) + (T.buttonspacing * 21))+ (T.Scale(4) * 2))
	--else
		--cooldown:SetWidth((T.buttonsize * 12) + (T.buttonspacing * 13))
	--end
end

if TukuiMinimap then
	local minimapstatsleft = CreateFrame("Frame", "TukuiMinimapStatsLeft", TukuiMinimap)
	minimapstatsleft:CreatePanel("Default", ((TukuiMinimap:GetWidth() + 4) / 2) -3, 19, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, -2)

	local minimapstatsright = CreateFrame("Frame", "TukuiMinimapStatsRight", TukuiMinimap)
	minimapstatsright:CreatePanel("Default", ((TukuiMinimap:GetWidth() + 4) / 2) -3, 19, "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, -2)
	
	if C["map"].topinfo == true then
		local minimapstatstop = CreateFrame("Frame", "TukuiMinimapStatsTop", TukuiMinimap)
		minimapstatstop:CreatePanel("Default", (TukuiMinimap:GetWidth() ), 19, "TOPLEFT", TukuiMinimap, "TOPLEFT", 0, T.Scale(22))
	end
end

--BATTLEGROUND STATS FRAME
if C["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	bgframe:CreatePanel("Default", 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
end
