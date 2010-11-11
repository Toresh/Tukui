if not TukuiCF["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarBottomRight as bar #2
---------------------------------------------------------------------------
---SECOND BOTTOM BAR

local TukuiBar2 = CreateFrame("Frame","TukuiBar2",UIParent)
TukuiBar2:SetAllPoints(TukuiActionBarBackground)
MultiBarBottomRight:SetParent(TukuiBar2)

for i= 1, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton"..i-1]
	b:SetSize(TukuiDB.buttonsize, TukuiDB.buttonsize)
	b:ClearAllPoints()
	if i == 1 then
			b:SetPoint("BOTTOM", ActionButton1, "TOP", 0, TukuiDB.Scale(4))
	else
			b:SetPoint("LEFT", b2, "RIGHT", TukuiDB.buttonspacing, 0)
	end
end

-- hide it if needed
if TukuiCF.actionbar.bottomrows == 1 then
	TukuiBar2:Hide()
end