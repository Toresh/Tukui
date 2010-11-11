if not TukuiCF["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarLeft as bar #4
---------------------------------------------------------------------------
--Second right bar

local TukuiBar4 = CreateFrame("Frame","TukuiBar4",UIParent)
TukuiBar4:SetAllPoints(TukuiActionBarBackground)
MultiBarLeft:SetParent(TukuiBar4)

for i= 1, 12 do
	local b = _G["MultiBarLeftButton"..i]
	local b2 = _G["MultiBarLeftButton"..i-1]
	b:SetSize(TukuiDB.buttonsize, TukuiDB.buttonsize)
	b:ClearAllPoints()
	if i == 1 then
		if TukuiCF["actionbar"].horizonbars == true then
			b:SetPoint("TOP", MultiBarRightButton1, "BOTTOM", 0, TukuiDB.Scale(-4))
		else
			b:SetPoint("RIGHT", MultiBarRightButton1, "LEFT", TukuiDB.Scale(-4), 0)
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
if TukuiCF.actionbar.rightbars < 2 then
	TukuiBar4:Hide()
end