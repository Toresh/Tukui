------------------------------------------------------------------------
--	First Time Launch and On Login file
------------------------------------------------------------------------

local function install()
	SetCVar("buffDurations", 1)
	SetCVar("consolidateBuffs", 0)
	SetCVar("lootUnderMouse", 1)
	SetCVar("autoSelfCast", 1)
	SetCVar("mapQuestDifficulty", 1)
	SetCVar("scriptErrors", 1)
	SetCVar("nameplateShowFriends", 0)
	SetCVar("nameplateShowFriendlyPets", 0)
	SetCVar("nameplateShowFriendlyGuardians", 0)
	SetCVar("nameplateShowFriendlyTotems", 0)
	SetCVar("nameplateShowEnemies", 1)
	SetCVar("nameplateShowEnemyPets", 1)
	SetCVar("nameplateShowEnemyGuardians", 1)
	SetCVar("nameplateShowEnemyTotems", 1)
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("screenshotQuality", 8)
	SetCVar("cameraDistanceMax", 50)
	SetCVar("cameraDistanceMaxFactor", 3.4)
	SetCVar("chatMouseScroll", 1)
	SetCVar("chatStyle", "im")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("ConversationMode", "inline")
	SetCVar("CombatDamage", 1)
	SetCVar("CombatHealing", 1)
	SetCVar("showTutorials", 0)
	SetCVar("showNewbieTips", 0)
	SetCVar("Maxfps", 120)
	SetCVar("autoDismountFlying", 1)
	SetCVar("autoQuestWatch", 1)
	SetCVar("autoQuestProgress", 1)
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
	SetCVar("UberTooltips", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("showVKeyCastbar", 1)
	SetCVar("colorblindMode", 0)
	--SetCVar("bloatthreat", 0)
	
	--call functions to set up addons
	Setup_DXE()
	Setup_Recount()
	Setup_Omen()
	Setup_Skinner()
	Setup_Forte()
	Setup_Quartz()
	
	-- setting this the creator or tukui only, because a lot of people don't like this change.		
	if TukuiDB.myname == "Tukz" then	
		SetCVar("secureAbilityToggle", 0)
	end
	
	-- Var ok, now setting chat frames if using Tukui chats.	
	if (TukuiCF.chat.enable == true) and (not IsAddOnLoaded("Prat") or not IsAddOnLoaded("Chatter")) then					
		FCF_ResetChatWindows()
		FCF_SetLocked(ChatFrame1, 1)
		FCF_DockFrame(ChatFrame2)
		FCF_SetLocked(ChatFrame2, 1)
		FCF_OpenNewWindow(Spam)
		FCF_UnDockFrame(ChatFrame3)
		FCF_SetLocked(ChatFrame3, 1)
		ChatFrame3:Show()


		for i = 1, NUM_CHAT_WINDOWS do
			local frame = _G[format("ChatFrame%s", i)]
			local chatFrameId = frame:GetID()
			local chatName = FCF_GetChatWindowInfo(chatFrameId)
			
			frame:SetSize(TukuiDB.Scale(TukuiCF["panels"].tinfowidth -7 ), TukuiDB.Scale(111))
			
			-- this is the default width and height of tukui chats.
			SetChatWindowSavedDimensions(chatFrameId, TukuiDB.Scale(TukuiCF["panels"].tinfowidth - 7), TukuiDB.Scale(111))
			
			-- move general bottom left or Loot (if found) on right.
			if i == 1 then
				frame:ClearAllPoints()
				frame:SetPoint("BOTTOMLEFT", TukuiInfoLeft, "TOPLEFT", TukuiDB.Scale(6), TukuiDB.Scale(6))

			elseif i == 3 and chatName == Spam then
				frame:ClearAllPoints()
				frame:SetPoint("BOTTOM", TukuiInfoRight, "TOP", 0, TukuiDB.Scale(8))
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
		ChatFrame_RemoveChannel(ChatFrame1, tukuilocal.chat_trade) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, tukuilocal.chat_general) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, tukuilocal.chat_defense) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, tukuilocal.chat_recrutment) -- erf, it seem we need to localize this now
		ChatFrame_RemoveChannel(ChatFrame1, tukuilocal.chat_lfg) -- erf, it seem we need to localize this now
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
					
		-- Setup the right spam chat frame
		ChatFrame_RemoveAllMessageGroups(ChatFrame3)
		ChatFrame_AddChannel(ChatFrame3, tukuilocal.chat_trade) -- erf, it seem we need to localize this now
		ChatFrame_AddChannel(ChatFrame3, tukuilocal.chat_general) -- erf, it seem we need to localize this now
		ChatFrame_AddChannel(ChatFrame3, tukuilocal.chat_defense) -- erf, it seem we need to localize this now
		ChatFrame_AddChannel(ChatFrame3, tukuilocal.chat_recrutment) -- erf, it seem we need to localize this now
		ChatFrame_AddChannel(ChatFrame3, tukuilocal.chat_lfg) -- erf, it seem we need to localize this now
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
		   
	TukuiInstallv1200 = true
	
	-- reset unitframe position
	if TukuiCF["unitframes"].positionbychar == true then
		TukuiUFpos = {}
	else
		TukuiData.ufpos = {}
	end
			
	ReloadUI()
end

local function DisableTukui()
	DisableAddOn("Tukui")
	ReloadUI()
end

------------------------------------------------------------------------
--	Popups
------------------------------------------------------------------------

StaticPopupDialogs["DISABLE_UI"] = {
	text = tukuilocal.popup_disableui,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = DisableTukui,
	timeout = 0,
	whileDead = 1,
}

StaticPopupDialogs["INSTALL_UI"] = {
	text = tukuilocal.popup_install,
	button1 = ACCEPT,
	button2 = CANCEL,
    OnAccept = install,
	OnCancel = function() TukuiInstallv1100 = true TukuiData.SetcVar = true end,
    timeout = 0,
    whileDead = 1,
}

StaticPopupDialogs["DISABLE_RAID"] = {
	text = tukuilocal.popup_2raidactive,
	button1 = "DPS - TANK",
	button2 = "HEAL",
	OnAccept = function() DisableAddOn("Tukui_Heal_Layout") EnableAddOn("Tukui_Dps_Layout") ReloadUI() end,
	OnCancel = function() EnableAddOn("Tukui_Heal_Layout") DisableAddOn("Tukui_Dps_Layout") ReloadUI() end,
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

	if TukuiDB.getscreenresolution == "800x600"
		or TukuiDB.getscreenresolution == "1024x768"
		or TukuiDB.getscreenresolution == "720x576"
		or TukuiDB.getscreenresolution == "1024x600" -- eeepc reso
		or TukuiDB.getscreenresolution == "1152x864" then
			SetCVar("useUiScale", 0)
			StaticPopup_Show("DISABLE_UI")
	else
		SetCVar("useUiScale", 1)
		if TukuiCF["general"].multisampleprotect == true then
			SetMultisampleFormat(1)
		end
		if TukuiCF["general"].uiscale > 1 then TukuiCF["general"].uiscale = 1 end
		if TukuiCF["general"].uiscale < 0.64 then TukuiCF["general"].uiscale = 0.64 end
		SetCVar("uiScale", TukuiCF["general"].uiscale)
		if TukuiInstallv1200 ~= true then
			if (TukuiData == nil) then TukuiData = {} end
			StaticPopup_Show("INSTALL_UI")
		end
	end
	
	if (IsAddOnLoaded("Tukui_Dps_Layout") and IsAddOnLoaded("Tukui_Heal_Layout")) then
		StaticPopup_Show("DISABLE_RAID")
	end
	
	print(tukuilocal.core_welcome1..TukuiDB.version)
	print(tukuilocal.core_welcome2)
end)

------------------------------------------------------------------------
--	UI HELP
------------------------------------------------------------------------

-- Print Help Messages
local function UIHelp()
	print(" ")
	print(tukuilocal.core_uihelp1)
	print(tukuilocal.core_uihelp2)
	print(tukuilocal.core_uihelp3)
	print(tukuilocal.core_uihelp4)
	print(tukuilocal.core_uihelp5)
	print(tukuilocal.core_uihelp6)
	print(tukuilocal.core_uihelp7)
	print(tukuilocal.core_uihelp8)
	print(tukuilocal.core_uihelp9)
	print(tukuilocal.core_uihelp10)
	print(tukuilocal.core_uihelp11)
	--print(tukuilocal.core_uihelp12)  -- temp disabled, don't know yet if i'll readd this feature
	print(tukuilocal.core_uihelp13)
	print(tukuilocal.core_uihelp15)
	print(" ")
	print(tukuilocal.core_uihelp14)
end

SLASH_UIHELP1 = "/UIHelp"
SlashCmdList["UIHELP"] = UIHelp

SLASH_CONFIGURE1 = "/resetui"
SlashCmdList.CONFIGURE = function() StaticPopup_Show("INSTALL_UI") end


--------------------------------------------------------------------------
--  Set up addons
-------------------------------------------------------------------------

function Setup_DXE()

	-- force DXE to load so that we can skin it
	if IsAddOnLoadOnDemand("DXE") then
		LoadAddOn("DXE")
	end

	if IsAddOnLoaded("DXE") then
		local namespace = DXE.db:GetNamespace("Alerts").profile
		
		DXEIconDB.hide = true
		DXE.db.profile.Globals.BarTexture = "TukTex"
		DXE.db.profile.Globals.BackgroundColor = { 0.1529411764705883, 0.1607843137254902, 0.1647058823529412 }
		DXE.db.profile.Pane.TitleFontSize = 12
		DXE.db.profile.Pane.Width = 352
		DXE.db.profile.Pane.NeutralColor = { 0.1529411764705883, 0.1607843137254902, 0.1647058823529412 }
		DXE.db.profile.NeutralColor = { 0.1529411764705883, 0.1607843137254902, 0.1647058823529412 }
		
		DXE.db.profile.Positions.DXEPane.yOfs = 187
		DXE.db.profile.Positions.DXEPane.xOfs = 14
		DXE.db.profile.Positions.DXEPane.point = "BOTTOMLEFT"
		DXE.db.profile.Positions.DXEPane.relativePoint = "BOTTOMLEFT"
		
		DXE.db.profile.Positions.DXEAlertsCenterStackAnchor.yOfs = 8.99
		DXE.db.profile.Positions.DXEAlertsCenterStackAnchor.xOfs = -305.49
		DXE.db.profile.Positions.DXEAlertsCenterStackAnchor.point = "RIGHT"
		DXE.db.profile.Positions.DXEAlertsCenterStackAnchor.relativePoint = "RIGHT"
		
		namespace.CenterScale = 1
		namespace.CenterAlpha = 1
		namespace.CenterGrowth = "UP"
		namespace.TopAlpha = 1
		namespace.TopScale = 1

		DXE.db.profile.Windows.TitleBarColor = { 0.1529411764705883, 0.1607843137254902, 0.1647058823529412 }
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
		Recount.db.profile.MainWindow.Position.y = -430.250643299163
		Recount.db.profile.MainWindow.Position.x = 372.0003691559128
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
		Omen.db.profile.PositionX = 372--359.4994234613777
		Omen.db.profile.PositionY = 165--146.9990649412748
		Omen.db.profile.PositionW = 192--199.0000127884138
		Omen.db.profile.PositionH = 152--142.9999017275369		
		Omen.db.profile.Shown = true
		Omen.db.profile.Locked = true
		
	end
end

function Setup_Skinner()
	if IsAddOnLoaded("Skinner") then
		Skinner.db.profile.MinimapIcon.hide = true
	end
end

function Setup_Forte()
	if IsAddOnLoaded ("Forte_Core")and IsAddOnLoaded ("Forte_Casting") then
		if IsAddOnLoaded ("Forte_Timer")then
			FC_Saved.Profiles.Profile.Timer.y = 188.8039247910538
			FC_Saved.Profiles.Profile.Timer.x = 412.5257419558476
			FC_Saved.Profiles.Profile.Timer.Width = 247
			FC_Saved.Profiles.Profile.Timer.lock = true
			FC_Saved.Profiles.Profile.Timer.Expand = true
			FC_Saved.Profiles.Profile.Timer.BuffEnable = false
			FC_Saved.Profiles.Profile.Timer.CooldownsOtherEnable = false
			FC_Saved.Profiles.Profile.Timer.CoolDownsEnable = false
			FC_Saved.Profiles.Profile.Timer.DebuffsEnable = false
			FC_Saved.Profiles.Profile.Timer.DebuffsOtherEnable = false
			FC_Saved.Profiles.Profile.Timer.SelfDebuffOtherEnable = false
			FC_Saved.Profiles.Profile.Timer.BuffOtherEnable = false
			FC_Saved.Profiles.Profile.Timer.Texture = "Interface\\AddOns\\Tukui\\media\\textures\\normTex"
			FC_Saved.Profiles.Profile.Timer.LabelFont = "Interface\\AddOns\\Tukui\\media\\fonts\\uf_font"
			FC_Saved.Profiles.Profile.Timer.Font = "Interface\\AddOns\\Tukui\\media\\fonts\\uf_font"
			FC_Saved.Profiles.Profile.Timer.Backdrop = { "Interface\\AddOns\\Tukui\\media\\textures\\blank", "Interface\\AddOns\\Tukui\\media\\textures\\blank", false, 16, 5, 3 }
			FC_Saved.Profiles.Profile.Timer.NormalBgColor = { 0.1, 0.1, 0.1, 1 }
			end
		
		if IsAddOnLoaded ("Forte_Cooldown") then
			FC_Saved.Profiles.Profile.Cooldown.IconSize = 16
			FC_Saved.Profiles.Profile.Cooldown.x = 614.3999600954436
			FC_Saved.Profiles.Profile.Cooldown.y = 89.26663520305853
			FC_Saved.Profiles.Profile.Cooldown.Height = 22
			FC_Saved.Profiles.Profile.Cooldown.Vertical = false
			FC_Saved.Profiles.Profile.Cooldown.Width = 534
			FC_Saved.Profiles.Profile.Cooldown.Flip = false
			FC_Saved.Profiles.Profile.Cooldown.Texture = "Interface\\AddOns\\Tukui\\media\\textures\\normTex"
			FC_Saved.Profiles.Profile.Cooldown.Font = "Interface\\AddOns\\Tukui\\media\\fonts\\uf_font"
			FC_Saved.Profiles.Profile.Cooldown.Backdrop = { "Interface\\AddOns\\Tukui\\media\\textures\\blank", "Interface\\AddOns\\Tukui\\media\\textures\\blank", false, 16, 5, 3 }
		end
	end
end

function Setup_Quartz()
	if IsAddOnLoaded ("Quartz") then
		Quartz3DB.namespaces.Player.profiles.Default.y = 282
		Quartz3DB.namespaces.Player.profiles.Default.x = 711
		Quartz3DB.namespaces.Player.profiles.Default.icongap = 8
		Quartz3DB.namespaces.Player.profiles.Default.hideicon = true
		Quartz3DB.namespaces.Player.profiles.Default.border = "Tukui Border"
		Quartz3DB.namespaces.Player.profiles.Default.texture = "Tukui StatusBar"
		Quartz3DB.profiles.Default.modules.Buff = false
		Quartz3DB.profiles.Default.modules.Interrupt = false
		Quartz3DB.profiles.Default.modules.GCD = false
		Quartz3DB.profiles.Default.modules.Pet = false
		Quartz3DB.profiles.Default.modules.Focus = false
		Quartz3DB.profiles.Default.modules.Target = false
		Quartz3DB.profiles.Default.modules.Range = false
		Quartz3DB.profiles.Default.modules.Timer = false
		Quartz3DB.profiles.Default.modules.Mirror = false
	end
end