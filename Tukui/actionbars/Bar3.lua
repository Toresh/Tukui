if not TukuiCF["actionbar"].enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarLeft as bar #3
---------------------------------------------------------------------------
--TOP BAR OF RIGHT SIDE

local TukuiBar3 = CreateFrame("Frame","TukuiBar3",UIParent) -- bottomrightbar
TukuiBar3:SetAllPoints(TukuiActionBarBackground)
MultiBarLeft:SetParent(TukuiBar3)

for i= 1, 12 do
	local b = _G["MultiBarLeftButton"..i]
	local b2 = _G["MultiBarLeftButton"..i-1]
	b:ClearAllPoints()
	if i == 1 then
		if TukuiCF.actionbar.rightbars > 2 then
			b:SetPoint("TOP", TukuiActionBarBackgroundRight, "TOP", 0, TukuiDB.Scale(-4))
		end
	else
		if TukuiCF.actionbar.rightbars > 2 then
			b:SetPoint("TOP", b2, "BOTTOM", 0, -TukuiDB.buttonspacing)
		end
	end
end

-- hide it if needed
if TukuiCF.actionbar.rightbars < 3 then
	TukuiBar3:Hide()
end