------------------------------------------------------------------------
-- Launch Tukui Script
------------------------------------------------------------------------
local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

-- this install Tukui with default settings.
local function install()
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
	SetCVar("Maxfps", 120)
	SetCVar("autoDismountFlying", 1)
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
	
	--call functions to set up addons
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
	
	-- reset saved variables on char
	TukuiDataPerChar = {}
	
	-- reset movable stuff into original position
	for i = 1, getn(T.MoverFrames) do
		if T.MoverFrames[i] then T.MoverFrames[i]:SetUserPlaced(false) end
	end
	
	-- tell savedvariable that we installed Tukui perfectly
	TukuiDataPerChar.install = true
			
	ReloadUI()
end

local function cvar()

end

local function DisableTukui()
	DisableAddOn("Tukui")
	ReloadUI()
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

StaticPopupDialogs["TUKUIINSTALL_UI"] = {
	text = L.popup_install,
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = install,
	OnCancel = function() TukuiDataPerChar.install = true end,
    timeout = 0,
    whileDead = 1,
}

StaticPopupDialogs["TUKUIRESET_UI"] = {
	text = L.popup_reset,
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = install,
	OnCancel = function() TukuiDataPerChar.install = true end,
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
			StaticPopup_Show("TUKUIINSTALL_UI")
		end
	end
	
	if (IsAddOnLoaded("Tukui_Raid") and IsAddOnLoaded("Tukui_Raid_Healing")) then
		StaticPopup_Show("TUKUIDISABLE_RAID")
	end
	
	print(L.core_welcome1..T.version)
	print(L.core_welcome2)
end)

------------------------------------------------------------------------
--	UI HELP
------------------------------------------------------------------------

-- Print Help Messages
local function UIHelp()
	print(" ")
	print(L.core_uihelp1)
	print(L.core_uihelp2)
	print(L.core_uihelp3)
	print(L.core_uihelp4)
	print(L.core_uihelp5)
	print(L.core_uihelp6)
	print(L.core_uihelp7)
	print(L.core_uihelp8)
	print(L.core_uihelp9)
	print(L.core_uihelp10)
	print(L.core_uihelp11)
	print(" ")
	print(L.core_uihelp100)
end

SLASH_UIHELP1 = "/UIHelp"
SlashCmdList["UIHELP"] = UIHelp

SLASH_CONFIGURE1 = "/resetui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("TUKUIRESET_UI") end



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
		Recount.db.profile.MainWindow.Position.y = TukuiDB.Scale(-430.250643299163)
		Recount.db.profile.MainWindow.Position.x = TukuiDB.Scale(371)
		Recount.db.profile.MainWindow.Position.w = 188.0000075911726
		Recount.db.profile.MainWindow.Position.h = 159.8336667240456
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
		Omen.db.profile.PositionX = TukuiDB.Scale(372)--359.4994234613777
		Omen.db.profile.PositionY = TukuiDB.Scale(165)--146.9990649412748
		Omen.db.profile.PositionW = 192--199.0000127884138
		Omen.db.profile.PositionH = 152--142.9999017275369		
		Omen.db.profile.Shown = true
		Omen.db.profile.Locked = true
		
	end
end

function Setup_Coolline()
	if IsAddOnLoaded ("CoolLine") then	
		CoolLineDB.x = 0
		CoolLineDB.y = TukuiDB.Scale(-403)
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