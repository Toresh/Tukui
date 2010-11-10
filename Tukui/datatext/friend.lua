--------------------------------------------------------------------
-- FRIEND
--------------------------------------------------------------------
 
if TukuiCF["datatext"].friends and TukuiCF["datatext"].friends > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
 
	local tthead = {r=0.4,g=0.78,b=1}
	local ttsubh = {r=0.75,g=0.9,b=1}
 
	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].friends, Text)
 
	local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
	local menuList = {
		{ text = "Select an Option", isTitle = true,notCheckable=true},
		{ text = "Invite", hasArrow = true,notCheckable=true,
			menuList = {
				{ text = "Option 3", func = function() print("You've chosen option 3"); end }
			}
		},
		{ text = "Whisper", hasArrow = true,notCheckable=true,
			menuList = {
				{ text = "Option 4", func = function() print("You've chosen option 4"); end }
			}
		}
	}
 
	function inviteClick(self, arg1, arg2, checked)
		menuFrame:Hide()
		InviteUnit(arg1)
	end
 
	function whisperClick(self,arg1,arg2,checked)
		menuFrame:Hide()
		SetItemRef( "player:"..arg1, ("|Hplayer:%1$s|h[%1$s]|h"):format(arg1), "LeftButton" )
	end
 
	local menuCountWhispers = 0
	local menuCountInvites = 0
 
	Stat:SetScript("OnMouseUp", function(self, btn)
		if btn == "RightButton" then
			GameTooltip:Hide()
			EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
		end
	end)		
 
	local function Update(self, event)
			local online, total = 0, GetNumFriends()
			local BNonline, BNtotal = 0, BNGetNumFriends()
			for i = 0, total do if select(5, GetFriendInfo(i)) then online = online + 1 end end
			if BNtotal > 0 then
				for i = 1, BNtotal do if select(7, BNGetFriendInfo(i)) then BNonline = BNonline + 1 end end
			end
			local totalonline = online + BNonline
			Text:SetText(tukuilocal.datatext_friends..": "..totalonline)
			self:SetAllPoints(Text)
	end
 
	Stat:RegisterEvent("FRIENDLIST_SHOW")
	Stat:RegisterEvent("FRIENDLIST_UPDATE")
	Stat:RegisterEvent("MUTELIST_UPDATE")
	Stat:RegisterEvent("WHO_LIST_UPDATE")
	Stat:RegisterEvent("PLAYER_FLAGS_CHANGED")
	Stat:RegisterEvent("BN_FRIEND_LIST_SIZE_CHANGED")
	Stat:RegisterEvent("BN_FRIEND_INFO_CHANGED")
	Stat:RegisterEvent("BN_FRIEND_INVITE_LIST_INITIALIZED")
	Stat:RegisterEvent("BN_FRIEND_INVITE_ADDED")
	Stat:RegisterEvent("BN_FRIEND_INVITE_REMOVED")
	Stat:RegisterEvent("BN_SELF_ONLINE")
	Stat:RegisterEvent("BN_BLOCK_LIST_UPDATED")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:RegisterEvent("BN_CONNECTED")
	Stat:RegisterEvent("BN_DISCONNECTED")
	Stat:RegisterEvent("CHAT_MSG_SYSTEM")
	Stat:SetScript("OnMouseDown", function(self, btn)
		if btn == "LeftButton" then
			ToggleFriendsFrame(1)
		end
	end)
	Stat:SetScript("OnEnter", function(self)
		if not InCombatLockdown() then
			ShowFriends()
			menuCountWhispers = 0
			menuCountInvites = 0
			menuList[2].menuList = {}
			menuList[3].menuList = {}
			self.hovered = true
			local online, total = 0, GetNumFriends()
			local name, level, class, zone, connected, status, note, classc, levelc, zone_r, zone_g, zone_b, grouped
			for i = 0, total do if select(5, GetFriendInfo(i)) then online = online + 1 end end
			local BNonline, BNtotal = 0, BNGetNumFriends()
			local presenceID, givenName, surname, toonName, toonID, client, isOnline
			if BNtotal > 0 then
				for i = 1, BNtotal do if select(7, BNGetFriendInfo(i)) then BNonline = BNonline + 1 end end
			end
			local totalonline = online + BNonline
			local totalfriends = total + BNtotal
			if online > 0 or BNonline > 0 then
				GameTooltip:SetOwner(self, "ANCHOR_TOP", 0, TukuiDB.Scale(6));
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.mult)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(tukuilocal.datatext_friendlist, format(tukuilocal.datatext_online .. "%s/%s",totalonline,totalfriends),tthead.r,tthead.g,tthead.b,tthead.r,tthead.g,tthead.b)
				if online > 0 then
					GameTooltip:AddLine' '
					GameTooltip:AddLine("World of Warcraft")
					-- name, level, class, area, connected, status, note
					for i = 1, total do
						name, level, class, zone, connected, status, note = GetFriendInfo(i)
						if not connected then break end
						if GetRealZoneText() == zone then zone_r, zone_g, zone_b = 0.3, 1.0, 0.3 else zone_r, zone_g, zone_b = 0.65, 0.65, 0.65 end
						for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
						if GetLocale() ~= "enUS" then -- feminine class localization (unsure if it's really needed)
							for k,v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
						end
						classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)
						if UnitInParty(name) or UnitInRaid(name) then grouped = "|cffaaaaaa*|r" else grouped = "" end
						GameTooltip:AddDoubleLine(format("|cff%02x%02x%02x%d|r %s%s%s",levelc.r*255,levelc.g*255,levelc.b*255,level,name,grouped," "..status),zone,classc.r,classc.g,classc.b,zone_r,zone_g,zone_b)
						if self.altdown and note then GameTooltip:AddLine("  "..note,ttsubh.r,ttsubh.g,ttsubh.b,1) end
 
						menuCountInvites = menuCountInvites + 1
						menuCountWhispers = menuCountWhispers + 1
 
						menuList[2].menuList[menuCountInvites] = {text = format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r",levelc.r*255,levelc.g*255,levelc.b*255,level,classc.r*255,classc.g*255,classc.b*255,name), arg1 = name,notCheckable=true, func = inviteClick}
						menuList[3].menuList[menuCountWhispers] = {text = format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r",levelc.r*255,levelc.g*255,levelc.b*255,level,classc.r*255,classc.g*255,classc.b*255,name), arg1 = name,notCheckable=true, func = whisperClick}
 
					end
				end
				if BNonline > 0 then
					colors = {
						name = { .14, .76, .15 },
						note = { 1, .56, .25 }
					}
					local r,g,b = unpack(colors.name)
					local nameColor = ("\124cff%.2x%.2x%.2x"):format( r*255, g*255, b*255 )
					r,g,b = unpack(colors.note)
					local noteColor = ("\124cff%.2x%.2x%.2x"):format( r*255, g*255, b*255 )
 
					GameTooltip:AddLine' '
					GameTooltip:AddLine("Battle.net")
 
					for i = 1, BNtotal do
						presenceID, givenName, surname, toonName, toonID, client, isOnline,lastOnline, isAFK, isDND, broadcast, note = BNGetFriendInfo(i)
						local realID = (BATTLENET_NAME_FORMAT):format(givenName, surname)
						if not isOnline then break end
 
						menuCountWhispers = menuCountWhispers + 1																		
 
						if client == "WoW" then
							local hasFocus, toonName, client, realmName, faction, race, class, guild, zoneName, level= BNGetToonInfo(toonID)
 
							for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
							if GetLocale() ~= "enUS" then -- feminine class localization (unsure if it's really needed)
								for k,v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
							end
							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)
 
							if note ~= nil then
								notes = format(" %s%s",noteColor,note)
							else
								notes = ""
							end
							if isAFK then
								status = "|cffff0000[AFK]|r"
							elseif isDND then
								status = "|cffff0000[DND]|r"
							else
								status = ""
							end
							if faction == 0 then
								faction = "|cffff0000 H|r"
							else
								faction = "|cff00ffff A|r"
							end	
 
							zone_r, zone_g, zone_b = 0.65, 0.65, 0.65
 
							GameTooltip:AddDoubleLine(format("|cff%02x%02x%02x%d|r %s %s %s%s%s",levelc.r*255,levelc.g*255,levelc.b*255,level,toonName,nameColor,realID,notes,' '..status),zoneName.." - "..realmName.." "..faction,classc.r,classc.g,classc.b,zone_r,zone_g,zone_b)
							if broadcast ~= '' then
								GameTooltip:AddLine("            "..broadcast)
							end
 
							menuCountInvites = menuCountInvites + 1
							menuList[2].menuList[menuCountInvites] = {text = format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r%s",levelc.r*255,levelc.g*255,levelc.b*255,level,classc.r*255,classc.g*255,classc.b*255,toonName,notes), arg1 = name,notCheckable=true, func = inviteClick}
							menuList[3].menuList[menuCountWhispers] = {text = nameColor..realID..notes, arg1 = realID,notCheckable=true, func = whisperClick}
						else
							menuList[3].menuList[menuCountWhispers] = {text = nameColor..realID, arg1 = realID,notCheckable=true, func = whisperClick}
							GameTooltip:AddDoubleLine("|cffeeeeee"..client.." ("..toonName..")|r", "|cffeeeeee"..givenName.." "..surname.."|r")
						end
					end
				end
				GameTooltip:Show()
			else
				GameTooltip:Hide()
			end
		end
	end)
 
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:SetScript("OnEvent", Update)
end