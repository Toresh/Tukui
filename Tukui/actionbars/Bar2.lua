if not TukuiCF["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarBottomLeft as bar #2
---------------------------------------------------------------------------
-- SPLIT BAR

local TukuiBar2 = CreateFrame("Frame","TukuiBar2",UIParent)
TukuiBar2:SetAllPoints(TukuiActionBarBackground)
MultiBarBottomLeft:SetParent(TukuiBar2)

MultiBarBottomLeftButton1:ClearAllPoints()
MultiBarBottomLeftButton1:SetPoint("BOTTOMLEFT", TukuiLeftSplitABBackground, "BOTTOMLEFT", TukuiDB.Scale(4), TukuiDB.Scale(4))
for i=2, 12 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton"..i-1]
	b:ClearAllPoints()
		b:SetPoint("LEFT", b2, "RIGHT", TukuiDB.buttonspacing, 0)
end

MultiBarBottomLeftButton4:ClearAllPoints()
MultiBarBottomLeftButton4:SetPoint("BOTTOMLEFT", TukuiRightSplitABBackground, "BOTTOMLEFT", TukuiDB.Scale(4), TukuiDB.Scale(4))
MultiBarBottomLeftButton7:ClearAllPoints()
MultiBarBottomLeftButton7:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1,"TOPLEFT", 0, TukuiDB.Scale(4));
MultiBarBottomLeftButton10:ClearAllPoints()
MultiBarBottomLeftButton10:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton4,"TOPLEFT", 0, TukuiDB.Scale(4));

-- hide it if needed
if TukuiCF.actionbar.bottomrows == 1 or TukuiCF.actionbar.splitbar == false then
	TukuiBar2:Hide()
end