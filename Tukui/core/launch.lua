------------------------------------------------------------------------
-- Launch Tukui Script
------------------------------------------------------------------------
local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local function chatsetup()
	-- setting chat frames if using Tukui chats.					
	FCF_ResetChatWindows()
	FCF_SetLocked(ChatFrame1, 1)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)
	FCF_OpenNewWindow(L.chat_general)
	FCF_SetLocked(ChatFrame3, 1)
	FCF_DockFrame(ChatFrame3)

	FCF_OpenNewWindow(LOOT)
	FCF_UnDockFrame(ChatFrame4)
	FCF_SetLocked(ChatFrame4, 1)
	ChatFrame4:Show()

	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%s", i)]
		local chatFrameId = frame:GetID()
		local chatName = FCF_GetChatWindowInfo(chatFrameId)
		
		-- set the size of chat frames
		frame:Size(T.InfoLeftRightWidth + 1, 111)
		
		-- tell wow that we are using new size
		SetChatWindowSavedDimensions(chatFrameId, T.Scale(T.InfoLeftRightWidth + 1), T.Scale(111))
		
		-- move general bottom left or Loot (if found) on right
		if i == 1 then
			frame:ClearAllPoints()
			frame:Point("BOTTOMLEFT", TukuiInfoLeft, "TOPLEFT", 0, 6)
		elseif i == 4 and chatName == LOOT then
			frame:ClearAllPoints()
			frame:Point("BOTTOMRIGHT", TukuiInfoRight, "TOPRIGHT", 0, 6)
		end
				
		-- save new default position and dimension
		FCF_SavePositionAndDimensions(frame)
		
		-- set default tukui font size
		FCF_SetChatWindowFontSize(nil, frame, 12)
		
		-- rename windows general and combat log
		if i == 1 then FCF_SetWindowName(frame, "G, S & W") end
		if i == 2 then FCF_SetWindowName(frame, "Log") end
	end
	
	ChatFrame_RemoveAllMessageGroups(ChatFrame1)
	ChatFrame_RemoveChannel(ChatFrame1, L.chat_trade) -- erf, it seem we need to localize this now
	ChatFrame_RemoveChannel(ChatFrame1, L.chat_general) -- erf, it seem we need to localize this now
	ChatFrame_RemoveChannel(ChatFrame1, L.chat_defense) -- erf, it seem we need to localize this now
	ChatFrame_RemoveChannel(ChatFrame1, L.chat_recrutment) -- erf, it seem we need to localize this now
	ChatFrame_RemoveChannel(ChatFrame1, L.chat_lfg) -- erf, it seem we need to localize this now
	ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
	ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
	ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND")
	ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
	ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
	ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
	ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
	ChatFrame_AddMessageGroup(ChatFrame1, "DND")
	ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
	ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
				
	-- Setup the spam chat frame
	ChatFrame_RemoveAllMessageGroups(ChatFrame3)
	ChatFrame_AddChannel(ChatFrame3, L.chat_trade) -- erf, it seem we need to localize this now
	ChatFrame_AddChannel(ChatFrame3, L.chat_general) -- erf, it seem we need to localize this now
	ChatFrame_AddChannel(ChatFrame3, L.chat_defense) -- erf, it seem we need to localize this now
	ChatFrame_AddChannel(ChatFrame3, L.chat_recrutment) -- erf, it seem we need to localize this now
	ChatFrame_AddChannel(ChatFrame3, L.chat_lfg) -- erf, it seem we need to localize this now
			
	-- Setup the right chat
	ChatFrame_RemoveAllMessageGroups(ChatFrame4)
	ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_XP_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_HONOR_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_FACTION_CHANGE")
	ChatFrame_AddMessageGroup(ChatFrame4, "LOOT")
	ChatFrame_AddMessageGroup(ChatFrame4, "MONEY")
			
	-- enable classcolor automatically on login and on each character without doing /configure each time.
	ToggleChatColorNamesByClassGroup(true, "SAY")
	ToggleChatColorNamesByClassGroup(true, "EMOTE")
	ToggleChatColorNamesByClassGroup(true, "YELL")
	ToggleChatColorNamesByClassGroup(true, "GUILD")
	ToggleChatColorNamesByClassGroup(true, "OFFICER")
	ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "WHISPER")
	ToggleChatColorNamesByClassGroup(true, "PARTY")
	ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID")
	ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")	
	ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
end

local function cvarsetup()
	SetCVar("buffDurations", 1)
	SetCVar("mapQuestDifficulty", 1)
	SetCVar("scriptErrors", 1)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("screenshotQuality", 8)
	SetCVar("chatMouseScroll", 1)
	SetCVar("chatStyle", "im")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("showTutorials", 0)
	SetCVar("showNewbieTips", 0)
	SetCVar("autoQuestWatch", 1)
	SetCVar("autoQuestProgress", 1)
	SetCVar("UberTooltips", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("showVKeyCastbar", 1)
	SetCVar("bloatthreat", 0)
	SetCVar("bloattest", 0)
	SetCVar("showArenaEnemyFrames", 0)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("cameraDistanceMaxFactor", 3.4)
	
	-- setting this the creator or tukui only, because a lot of people don't like this.		
	if T.myname == "Tukz" then
		SetCVar("Maxfps", 120)
		SetCVar("autoDismountFlying", 1)
		SetCVar("secureAbilityToggle", 0)
		SetCVar("colorblindMode", 0)
		SetCVar("showLootSpam", 1)
		SetCVar("guildMemberNotify", 1)
		SetCVar("chatBubblesParty", 0)
		SetCVar("chatBubbles", 0)	
		SetCVar("UnitNameOwn", 0)
		SetCVar("UnitNameNPC", 0)
		SetCVar("UnitNameNonCombatCreatureName", 0)
		SetCVar("UnitNamePlayerGuild", 1)
		SetCVar("UnitNamePlayerPVPTitle", 1)
		SetCVar("UnitNameFriendlyPlayerName", 0)
		SetCVar("UnitNameFriendlyPetName", 0)
		SetCVar("UnitNameFriendlyGuardianName", 0)
		SetCVar("UnitNameFriendlyTotemName", 0)
		SetCVar("UnitNameEnemyPlayerName", 1)
		SetCVar("UnitNameEnemyPetName", 1)
		SetCVar("UnitNameEnemyGuardianName", 1)
		SetCVar("UnitNameEnemyTotemName", 1)
		SetCVar("CombatDamage", 1)
		SetCVar("CombatHealing", 1)
		SetCVar("nameplateShowFriends", 0)
		SetCVar("nameplateShowFriendlyPets", 0)
		SetCVar("nameplateShowFriendlyGuardians", 0)
		SetCVar("nameplateShowFriendlyTotems", 0)
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("nameplateShowEnemyPets", 1)
		SetCVar("nameplateShowEnemyGuardians", 1)
		SetCVar("nameplateShowEnemyTotems", 1)	
		SetCVar("consolidateBuffs", 0)
		SetCVar("lootUnderMouse", 1)
		SetCVar("autoSelfCast", 1)
		SetCVar("cameraDistanceMax", 50)
		SetCVar("cameraDistanceMaxFactor", 3.4)
	end
--[[
	
	--call functions to set up addons
	Setup_DBM()
	Setup_DXE()
	Setup_Recount()
	Setup_Omen()
	Setup_Coolline()

	-- Var ok, now setting chat frames if using Tukui chats.	
	if (C.chat.enable == true) and (not IsAddOnLoaded("Prat") or not IsAddOnLoaded("Chatter")) then					
		FCF_ResetChatWindows()
		FCF_SetLocked(ChatFrame1, 1)
		FCF_DockFrame(ChatFrame2)
		FCF_SetLocked(ChatFrame2, 1)

		FCF_OpenNewWindow("Spam")
		FCF_UnDockFrame(ChatFrame3)
		FCF_SetLocked(ChatFrame3, 1)
		ChatFrame3:Show()

		for i = 1, NUM_CHAT_WINDOWS do
			local frame = _G[format("ChatFrame%s", i)]
			local chatFrameId = frame:GetID()
			local chatName = FCF_GetChatWindowInfo(chatFrameId)
			
			-- set the size of chat frames
			frame:Size(T.InfoLeftRightWidth, 111)
			
			-- tell wow that we are using new size
			SetChatWindowSavedDimensions(chatFrameId, T.Scale(T.InfoLeftRightWidth - 4), T.Scale(111))
			
			-- move general bottom left or Loot (if found) on right
			if i == 1 then
				frame:ClearAllPoints()
				frame:Point("BOTTOMLEFT", TukuiInfoLeft, "TOPLEFT", 2, 6)
			elseif i == 3 and chatName == "Spam" then
				frame:ClearAllPoints()
				frame:Point("BOTTOMRIGHT", TukuiInfoRight, "TOPRIGHT", 2, 6)
			end
					
			-- save new default position and dimension
			FCF_SavePositionAndDimensions(frame)
			
			-- set default tukui font size
			FCF_SetChatWindowFontSize(nil, frame, 12)
			
			-- rename windows general and combat log
			if i == 1 then FCF_SetWindowName(frame, "G, S & W") end
			if i == 2 then FCF_SetWindowName(frame, "Log") end
		end
		
		ChatFrame_RemoveAllMessageGroups(ChatFrame1)
		ChatFrame_RemoveChannel(ChatFrame1, L.chat_trade) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, L.chat_general) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, L.chat_defense) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, L.chat_recrutment) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, L.chat_lfg) -- erf, it seem we need to localize this now
		ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
		ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
		ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
		ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
		ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND")
		ChatFrame_AddMessageGroup(ChatFrame1, "BATTLEGROUND_LEADER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
		ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
		ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
		ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
		ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
		ChatFrame_AddMessageGroup(ChatFrame1, "DND")
		ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
		ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")
		ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
					
		-- Setup the spam chat frame
		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_AddChannel(ChatFrame3, L.chat_trade) -- erf, it seem we need to localize this now
		ChatFrame_AddChannel(ChatFrame3, L.chat_general) -- erf, it seem we need to localize this now
		ChatFrame_AddChannel(ChatFrame3, L.chat_defense) -- erf, it seem we need to localize this now
		ChatFrame_AddChannel(ChatFrame3, L.chat_recrutment) -- erf, it seem we need to localize this now
		ChatFrame_AddChannel(ChatFrame3, L.chat_lfg) -- erf, it seem we need to localize this now
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_XP_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_HONOR_GAIN")
		ChatFrame_AddMessageGroup(ChatFrame3, "COMBAT_FACTION_CHANGE")
		ChatFrame_AddMessageGroup(ChatFrame3, "LOOT")
		ChatFrame_AddMessageGroup(ChatFrame3, "MONEY")
				
		-- enable classcolor automatically on login and on each character without doing /configure each time.
		ToggleChatColorNamesByClassGroup(true, "SAY")
		ToggleChatColorNamesByClassGroup(true, "EMOTE")
		ToggleChatColorNamesByClassGroup(true, "YELL")
		ToggleChatColorNamesByClassGroup(true, "GUILD")
		ToggleChatColorNamesByClassGroup(true, "OFFICER")
		ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "WHISPER")
		ToggleChatColorNamesByClassGroup(true, "PARTY")
		ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID")
		ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")	
		ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	end
	--]]

end

local function positionsetup()
	-- reset saved variables on char
	TukuiDataPerChar = {}
	
	-- reset movable stuff into original position
	for i = 1, getn(T.MoverFrames) do
		if T.MoverFrames[i] then T.MoverFrames[i]:SetUserPlaced(false) end
	end
end

local v = CreateFrame("Button", "TukuiVersionFrame", UIParent)
v:SetSize(160, 36)
v:SetPoint("CENTER")
v:SetTemplate("Default")
v:CreateShadow("Default")
v:FontString("Text", C.media.font, 12)
v.Text:SetPoint("CENTER")
v.Text:SetText("Tukui ".. T.version ..", www.tukui.org")
v:SetScript("OnClick", function()
	v:Hide()
end)
v:Hide()

local f = CreateFrame("Frame", "TukuiInstallFrame", UIParent)
f:SetSize(400, 400)
f:SetPoint("CENTER")
f:SetTemplate("Default")
f:CreateShadow("Default")
f:Hide()

local sb = CreateFrame("StatusBar", nil, f)
sb:SetStatusBarTexture(C.media.normTex)
sb:SetPoint("BOTTOM", f, "BOTTOM", 0, 60)
sb:SetHeight(20)
sb:SetWidth(f:GetWidth()-44)
sb:SetFrameStrata("HIGH")
sb:SetFrameLevel(6)
sb:Hide()

local sbd = CreateFrame("Frame", nil, sb)
sbd:SetTemplate("Default")
sbd:SetPoint("TOPLEFT", sb, -2, 2)
sbd:SetPoint("BOTTOMRIGHT", sb, 2, -2)
sbd:SetFrameStrata("HIGH")
sbd:SetFrameLevel(5)

local header = f:CreateFontString(nil, "OVERLAY")
header:SetFont(C.media.font, 16, "THINOUTLINE")
header:SetPoint("TOP", f, "TOP", 0, -20)

local text1 = f:CreateFontString(nil, "OVERLAY")
text1:SetJustifyH("LEFT")
text1:SetFont(C.media.font, 12)
text1:SetWidth(f:GetWidth()-40)
text1:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -60)

local text2 = f:CreateFontString(nil, "OVERLAY")
text2:SetJustifyH("LEFT")
text2:SetFont(C.media.font, 12)
text2:SetWidth(f:GetWidth()-40)
text2:SetPoint("TOPLEFT", text1, "BOTTOMLEFT", 0, -20)

local text3 = f:CreateFontString(nil, "OVERLAY")
text3:SetJustifyH("LEFT")
text3:SetFont(C.media.font, 12)
text3:SetWidth(f:GetWidth()-40)
text3:SetPoint("TOPLEFT", text2, "BOTTOMLEFT", 0, -20)

local text4 = f:CreateFontString(nil, "OVERLAY")
text4:SetJustifyH("LEFT")
text4:SetFont(C.media.font, 12)
text4:SetWidth(f:GetWidth()-40)
text4:SetPoint("TOPLEFT", text3, "BOTTOMLEFT", 0, -20)

local credits = f:CreateFontString(nil, "OVERLAY")
credits:SetFont(C.media.font, 12, "THINOUTLINE")
credits:SetText("")
credits:SetPoint("BOTTOM", f, "BOTTOM", 0, 4)

local sbt = sb:CreateFontString(nil, "OVERLAY")
sbt:SetFont(C.media.font, 13, "THINOUTLINE")
sbt:SetPoint("CENTER", sb)

local option1 = CreateFrame("Button", "TukuiInstallOption1", f)
option1:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 20, 20)
option1:SetSize(128, 25)
option1:SetTemplate("Default")
option1:FontString("Text", C.media.font, 12)
option1.Text:SetPoint("CENTER")

local option2 = CreateFrame("Button", "TukuiInstallOption2", f)
option2:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -20, 20)
option2:SetSize(128, 25)
option2:SetTemplate("Default")
option2:FontString("Text", C.media.font, 12)
option2.Text:SetPoint("CENTER")

local close = CreateFrame("Button", "TukuiInstallCloseButton", f, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", f, "TOPRIGHT")
close:SetScript("OnClick", function()
	f:Hide()
end)

local step4 = function()
	TukuiDataPerChar.install = true
	sb:SetValue(4)
	PlaySoundFile("Sound\\interface\\LevelUp.wav")
	header:SetText(L.install_header_11)
	text1:SetText(L.install_step_4_line_1)
	text2:SetText(L.install_step_4_line_2)
	text3:SetText(L.install_step_4_line_3)
	text4:SetText(L.install_step_4_line_4)
	sbt:SetText("4/4")
	option1:Hide()
	option2.Text:SetText(L.install_button_finish)
	option2:SetScript("OnClick", function()
		ReloadUI()
	end)
end

local step3 = function()
	if not option2:IsShown() then option2:Show() end	
	sb:SetValue(3)
	header:SetText(L.install_header_10)
	text1:SetText(L.install_step_3_line_1)
	text2:SetText(L.install_step_3_line_2)
	text3:SetText(L.install_step_3_line_3)
	text4:SetText(L.install_step_3_line_4)
	sbt:SetText("3/4")
	option1:SetScript("OnClick", step4)
	option2:SetScript("OnClick", function()
		positionsetup()
		step4()
	end)
end

local step2 = function()
	sb:SetValue(2)
	header:SetText(L.install_header_9)
	sbt:SetText("2/4")
	if IsAddOnLoaded("Prat") or IsAddOnLoaded("Chatter") then 
		text1:SetText(L.install_step_2_line_0)
		text2:SetText("")
		text3:SetText("")
		text4:SetText("")
		option2:Hide()
	else
		text1:SetText(L.install_step_2_line_1)
		text2:SetText(L.install_step_2_line_2)
		text3:SetText(L.install_step_2_line_3)
		text4:SetText(L.install_step_2_line_4)
		option2:SetScript("OnClick", function()
			chatsetup()
			step3()
		end)
	end	
	option1:SetScript("OnClick", step3)
end

local step1 = function()
	close:Hide()
	sb:SetMinMaxValues(0, 4)
	sb:Show()
	sb:SetValue(1)
	sb:SetStatusBarColor(0.26, 1, 0.22)
	header:SetText(L.install_header_8)
	text1:SetText(L.install_step_1_line_1)
	text2:SetText(L.install_step_1_line_2)
	text3:SetText(L.install_step_1_line_3)
	text4:SetText(L.install_step_1_line_4)
	sbt:SetText("1/4")

	option1:Show()

	option1.Text:SetText(L.install_button_skip)
	option2.Text:SetText(L.install_button_continue)

	option1:SetScript("OnClick", step2)
	option2:SetScript("OnClick", function()
		cvarsetup()
		step2()
	end)
	
	-- this is really essential, whatever if skipped or not
	SetActionBarToggles(1, 1, 1, 1, 0)
	SetCVar("alwaysShowActionBars", 0)
end

local tut6 = function()
	sb:SetValue(6)
	header:SetText(L.install_header_7)
	text1:SetText(L.tutorial_step_6_line_1)
	text2:SetText(L.tutorial_step_6_line_2)
	text3:SetText(L.tutorial_step_6_line_3)
	text4:SetText(L.tutorial_step_6_line_4)

	sbt:SetText("6/6")

	option1:Show()

	option1.Text:SetText(L.install_button_close)
	option2.Text:SetText(L.install_button_install)

	option1:SetScript("OnClick", function()
		f:Hide()
	end)
	option2:SetScript("OnClick", step1)
end

local tut5 = function()
	sb:SetValue(5)
	header:SetText(L.install_header_6)
	text1:SetText(L.tutorial_step_5_line_1)
	text2:SetText(L.tutorial_step_5_line_2)
	text3:SetText(L.tutorial_step_5_line_3)
	text4:SetText(L.tutorial_step_5_line_4)

	sbt:SetText("5/6")

	option2:SetScript("OnClick", tut6)
end

local tut4 = function()
	sb:SetValue(4)
	header:SetText(L.install_header_5)
	text1:SetText(L.tutorial_step_4_line_1)
	text2:SetText(L.tutorial_step_4_line_2)
	text3:SetText(L.tutorial_step_4_line_3)
	text4:SetText(L.tutorial_step_4_line_4)

	sbt:SetText("4/6")

	option2:SetScript("OnClick", tut5)
end

local tut3 = function()
	sb:SetValue(3)
	header:SetText(L.install_header_4)
	text1:SetText(L.tutorial_step_3_line_1)
	text2:SetText(L.tutorial_step_3_line_2)
	text3:SetText(L.tutorial_step_3_line_3)
	text4:SetText(L.tutorial_step_3_line_4)

	sbt:SetText("3/6")

	option2:SetScript("OnClick", tut4)
end

local tut2 = function()
	sb:SetValue(2)
	header:SetText(L.install_header_3)
	text1:SetText(L.tutorial_step_2_line_1)
	text2:SetText(L.tutorial_step_2_line_2)
	text3:SetText(L.tutorial_step_2_line_3)
	text4:SetText(L.tutorial_step_2_line_4)

	sbt:SetText("2/6")

	option2:SetScript("OnClick", tut3)
end

local tut1 = function()
	sb:SetMinMaxValues(0, 6)
	sb:Show()
	close:Show()
	sb:SetValue(1)
	sb:SetStatusBarColor(0, 0.76, 1)
	header:SetText(L.install_header_2)
	text1:SetText(L.tutorial_step_1_line_1)
	text2:SetText(L.tutorial_step_1_line_2)
	text3:SetText(L.tutorial_step_1_line_3)
	text4:SetText(L.tutorial_step_1_line_4)
	sbt:SetText("1/6")
	option1:Hide()
	option2.Text:SetText(L.install_button_next)
	option2:SetScript("OnClick", tut2)
end

local function DisableTukui()
	DisableAddOn("Tukui")
	ReloadUI()
end

-- this install Tukui with default settings.
local function install()
	f:Show()
	sb:Hide()
	
	Setup_DBM()
	Setup_DXE()
	Setup_Recount()
	Setup_Omen()
	Setup_Coolline()
	
	option1:Show()
	option2:Show()
	close:Show()
	header:SetText(L.install_header_1)
	text1:SetText(L.install_init_line_1)
	text2:SetText(L.install_init_line_2)
	text3:SetText(L.install_init_line_3)
	text4:SetText(L.install_init_line_4)

	option1.Text:SetText(L.install_button_tutorial)
	option2.Text:SetText(L.install_button_install)

	option1:SetScript("OnClick", tut1)
	option2:SetScript("OnClick", step1)			
end

------------------------------------------------------------------------
--	Popups
------------------------------------------------------------------------

StaticPopupDialogs["TUKUIDISABLE_UI"] = {
	text = L.popup_disableui,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = DisableTukui,
	timeout = 0,
	whileDead = 1,
}

StaticPopupDialogs["TUKUIDISABLE_RAID"] = {
	text = L.popup_2raidactive,
	button1 = "DPS - TANK",
	button2 = "HEAL",
	OnAccept = function() DisableAddOn("Tukui_Raid_Healing") EnableAddOn("Tukui_Raid") ReloadUI() end,
	OnCancel = function() EnableAddOn("Tukui_Raid_Healing") DisableAddOn("Tukui_Raid") ReloadUI() end,
	timeout = 0,
	whileDead = 1,
}

------------------------------------------------------------------------
--	On login function, look for some infos!
------------------------------------------------------------------------

local TukuiOnLogon = CreateFrame("Frame")
TukuiOnLogon:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiOnLogon:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	
	-- create empty saved vars if they doesn't exist.
	if (TukuiData == nil) then TukuiData = {} end
	if (TukuiDataPerChar == nil) then TukuiDataPerChar = {} end

	if T.getscreenwidth < 1200 then
			SetCVar("useUiScale", 0)
			StaticPopup_Show("TUKUIDISABLE_UI")
	else
		SetCVar("useUiScale", 1)
		if C["general"].multisampleprotect == true then
			SetMultisampleFormat(1)
		end
		if C["general"].uiscale > 1 then C["general"].uiscale = 1 end
		if C["general"].uiscale < 0.64 then C["general"].uiscale = 0.64 end

		-- set our uiscale
		SetCVar("uiScale", C["general"].uiscale)
		
		-- we adjust UIParent to screen #1 if Eyefinity is found
		if T.eyefinity then
			local width = T.eyefinity
			local height = T.getscreenheight
			
			-- if autoscale is off, find a new width value of UIParent for screen #1.
			if not C.general.autoscale or height > 1200 then
				local h = UIParent:GetHeight()
				local ratio = T.getscreenheight / h
				local w = T.eyefinity / ratio
				
				width = w
				height = h			
			end
			
			UIParent:SetSize(width, height)
			UIParent:ClearAllPoints()
			UIParent:SetPoint("CENTER")		
		end
		
		-- install default if we never ran Tukui on this character.
		if not TukuiDataPerChar.install then			
			install()
		end
	end
	
	if (IsAddOnLoaded("Tukui_Raid") and IsAddOnLoaded("Tukui_Raid_Healing")) then
		StaticPopup_Show("TUKUIDISABLE_RAID")
	end
end)

SLASH_TUTORIAL1 = "/uihelp"
SLASH_TUTORIAL2 = "/tutorial"
SlashCmdList.TUTORIAL = function() f:Show() tut1() end

SLASH_VERSION1 = "/version"
SlashCmdList.VERSION = function() if v:IsShown() then v:Hide() else v:Show() end end

SLASH_CONFIGURE1 = "/install"
SlashCmdList.CONFIGURE = install

SLASH_RESETUI1 = "/resetui"
SlashCmdList.RESETUI = function() f:Show() step1() end


--------------------------------------------------------------------------
--  Set up addons
-------------------------------------------------------------------------

function Setup_DXE()

	-- force DXE to load so that we can set it up it
	if IsAddOnLoadOnDemand("DXE") then
		LoadAddOn("DXE")
	end

	if IsAddOnLoaded("DXE") then
		local namespace = DXE.db:GetNamespace("Alerts").profile
		
		DXEIconDB.hide = true
		--DXE.db.profile.Globals.BarTexture = "TukTex"
		--DXE.db.profile.Globals.BackgroundColor = { 0.1529411764705883, 0.1607843137254902, 0.1647058823529412 }
		DXE.db.profile.Pane.TitleFontSize = 12
		DXE.db.profile.Pane.Width = 352
		--DXE.db.profile.Pane.NeutralColor = { 0.1529411764705883, 0.1607843137254902, 0.1647058823529412 }
		--DXE.db.profile.NeutralColor = { 0.1529411764705883, 0.1607843137254902, 0.1647058823529412 }
		DXE.db.profile.Pane.OnlyInRaid = true
		DXE.db.profile.Pane.OnlyInRaidInstance = true
		
		DXE.db.profile.Positions.DXEPane.yOfs = TukuiDB.Scale(187)
		DXE.db.profile.Positions.DXEPane.xOfs = TukuiDB.Scale(14)
		DXE.db.profile.Positions.DXEPane.point = "BOTTOMLEFT"
		DXE.db.profile.Positions.DXEPane.relativePoint = "BOTTOMLEFT"
		
		DXE.db.profile.Positions.DXEAlertsCenterStackAnchor.yOfs = TukuiDB.Scale(8.99)
		DXE.db.profile.Positions.DXEAlertsCenterStackAnchor.xOfs = TukuiDB.Scale(-305.49)
		DXE.db.profile.Positions.DXEAlertsCenterStackAnchor.point = "RIGHT"
		DXE.db.profile.Positions.DXEAlertsCenterStackAnchor.relativePoint = "RIGHT"
		
		--namespace.CenterScale = 1
		--namespace.CenterAlpha = 1
		namespace.CenterGrowth = "UP"
		--namespace.TopAlpha = 1
		--namespace.TopScale = 1

		--DXE.db.profile.Windows.TitleBarColor = { 0.1529411764705883, 0.1607843137254902, 0.1647058823529412 }
	end

end

function Setup_Recount()
	if IsAddOnLoaded("Recount") then		
		Recount.db.profile.MainWindow.ShowScrollbar = false	
		Recount.db.profile.BarTextColorSwap = false
		Recount.db.profile.ConfirmDeleteRaid = false
		Recount.db.profile.ConfirmDeleteInstance = false
		Recount.db.profile.ConfirmDeleteGroup = false
		Recount.db.profile.MainWindow.ShowScrollbar = false
		Recount.db.profile.ReportLines = 4
		Recount.db.profile.MainWindow.Position.point = "BOTTOMRIGHT"
		Recount.db.profile.MainWindow.Position.relativePoint = "BOTTOMRIGHT"
		Recount.db.profile.MainWindow.Position.y = T.Scale(-432.)
		Recount.db.profile.MainWindow.Position.x = T.Scale(372)
		Recount.db.profile.MainWindow.Position.w = 188
		Recount.db.profile.MainWindow.Position.h = 151
		Recount.db.profile.MainWindowHeight = 159.8336667240456
		Recount.db.profile.MainWindowWidth = 188.0000255850633
		
		local function RecountSetColor(Branch,Name,r,g,b,a)
			Recount.db.profile.Colors[Branch][Name].r=r
			Recount.db.profile.Colors[Branch][Name].g=g
			Recount.db.profile.Colors[Branch][Name].b=b
			Recount.db.profile.Colors[Branch][Name].a=a
		end
		
		RecountSetColor("Window","Title",0.1333333333333333,0.1333333333333333,0.1333333333333333,0)			
		Recount:LockWindows(false)
		Recount.MainWindow:SetResizable(true)
		Recount.db.profile.MainWindowHeight = 245
		Recount.db.profile.MainWindowWidth = 197
		Recount:SetBarTextures(Recount.db.profile.BarTexture)
		Recount:RestoreMainWindowPosition(Recount.db.profile.MainWindow.Position.x,Recount.db.profile.MainWindow.Position.y,Recount.db.profile.MainWindow.Position.w,Recount.db.profile.MainWindow.Position.h)
		Recount:ResizeMainWindow()
		Recount:FullRefreshMainWindow()
		Recount:SetupMainWindowButtons()
		Recount.profilechange = true
		Recount:CloseAllRealtimeWindows()
		Recount.Colors:UpdateAllColors()
		Recount.profilechange = nil
		Recount:SetStrataAndClamp()
		Recount.db.profile.Locked = true
		Recount:LockWindows(true)
		
		TukuiDB.SetTemplate(Recount_MainWindow)
	end

end

function Setup_Omen()
	if IsAddOnLoaded("Omen") then
		Omen.db.profile.MinimapIcon.hide = true
		Omen.db.profile.ShowWith.UseShowWith = false	
		Omen.db.profile.PositionX = T.Scale(372)
		Omen.db.profile.PositionY = T.Scale(163)
		Omen.db.profile.PositionW = 188
		Omen.db.profile.PositionH = 150	
		Omen.db.profile.Shown = true
		Omen.db.profile.Locked = true
		
	end
end

function Setup_Coolline()
	if IsAddOnLoaded ("CoolLine") then	
		CoolLineDB.x = 0
		CoolLineDB.y = T.Scale(-403)
		CoolLineDB.h = 23
		CoolLineDB.w = 512
		CoolLineDB.bgcolor.a = 0
		CoolLineDB.bgcolor.r = 0
		CoolLineDB.bgcolor.g = 0
		CoolLineDB.bgcolor.b = 0
		CoolLineDB.spellcolor.a = 1
		CoolLineDB.spellcolor.b = 0.94
		CoolLineDB.spellcolor.g = 0.96
		CoolLineDB.spellcolor.r = 0.95
		CoolLineDB.border = "none"
		CoolLineDB.iconplus = 2
		CoolLineDB.activealpha = 0.9999999999999999
	end
end

--mostly taken from affis dbm skin.
function Setup_DBM()

	if IsAddOnLoadOnDemand("DBM-Core") then
		LoadAddOn("DBM-Core")
	end

	if IsAddOnLoaded("DBM-Core") then
		DBM_SavedOptions.Enabled=true
		DBM_SavedOptions.WarningIconLeft=false
		DBM_SavedOptions.WarningIconRight=false
		DBM_SavedOptions.ShowMinimapButton=false
		DBT_SavedOptions["DBM"].Scale=1
		DBT_SavedOptions["DBM"].HugeScale=1
		DBT_SavedOptions["DBM"].BarXOffset=0
		DBT_SavedOptions["DBM"].BarYOffset=3
		DBT_SavedOptions["DBM"].IconLeft=true
		DBT_SavedOptions["DBM"].ExpandUpwards=false
		DBT_SavedOptions["DBM"].Texture=C["media"].normTex
		DBT_SavedOptions["DBM"].IconRight=false
		DBT_SavedOptions["DBM"].FillUpBars=true
		DBT_SavedOptions["DBM"].HugeTimerY=T.Scale(260)
		DBT_SavedOptions["DBM"].HugeBarXOffset=-7
		DBT_SavedOptions["DBM"].HugeBarYOffset=20
		DBT_SavedOptions["DBM"].BarYOffset=20
		DBT_SavedOptions["DBM"].TimerX=T.Scale(10.5)
		DBT_SavedOptions["DBM"].HugeTimerX=T.Scale(-340)
		DBT_SavedOptions["DBM"].TimerY=T.Scale(-21)
		DBT_SavedOptions["DBM"].TimerPoint="TOP"
		DBT_SavedOptions["DBM"].HugeTimerPoint="RIGHT"
		DBT_SavedOptions["DBM"].FillUpBars="TRUE"
	end
end
