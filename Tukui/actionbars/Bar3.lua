if not TukuiCF["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarRight as bar #3
---------------------------------------------------------------------------
--First right bar (Done)

local TukuiBar3 = CreateFrame("Frame","TukuiBar3",UIParent) -- bottomrightbar
TukuiBar3:SetAllPoints(TukuiActionBarBackground)
MultiBarRight:SetParent(TukuiBar3)

for i= 1, 12 do
	local b = _G["MultiBarRightButton"..i]
	local b2 = _G["MultiBarRightButton"..i-1]
	b:SetSize(TukuiDB.buttonsize, TukuiDB.buttonsize)
	b:ClearAllPoints()
	if i == 1 then
		if TukuiCF["actionbar"].horizonbars == true then
			b:SetPoint("TOPLEFT", TukuiActionBarBackgroundRight, "TOPLEFT", TukuiDB.Scale(4), TukuiDB.Scale(-4))
		else	
			b:SetPoint("TOPRIGHT", TukuiActionBarBackgroundRight, "TOPRIGHT", TukuiDB.Scale(-4), TukuiDB.Scale(-4))
		end
	else
		if TukuiCF["actionbar"].horizonbars == true then
			b:SetPoint("LEFT", b2, "RIGHT", TukuiDB.buttonspacing, 0)
		else
			b:SetPoint("TOP", b2, "BOTTOM", 0, -TukuiDB.buttonspacing)
		end
	end	
end

-- hide it if needed
if TukuiCF.actionbar.rightbars < 1 then
	TukuiBar3:Hide()
end