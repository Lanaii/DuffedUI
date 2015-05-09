local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local format = string.format

local function LoadSkin()
	GuildFrame:StripTextures(true)
	GuildFrame:SetTemplate("Transparent")

	GuildMemberDetailCloseButton:SkinCloseButton()
	GuildFrameCloseButton:SkinCloseButton()
	GuildInfoFrameApplicantsContainerScrollBar:SkinScrollBar()

	local striptextures = {
		"GuildFrameInset",
		"GuildFrameBottomInset",
		"GuildAllPerksFrame",
		"GuildMemberDetailFrame",
		"GuildMemberNoteBackground",
		"GuildInfoFrameInfo",
		"GuildLogContainer",
		"GuildLogFrame",
		"GuildRewardsFrame",
		"GuildMemberOfficerNoteBackground",
		"GuildTextEditContainer",
		"GuildTextEditFrame",
		"GuildRecruitmentRolesFrame",
		"GuildRecruitmentAvailabilityFrame",
		"GuildRecruitmentInterestFrame",
		"GuildRecruitmentLevelFrame",
		"GuildRecruitmentCommentFrame",
		"GuildRecruitmentCommentInputFrame",
		"GuildInfoFrameApplicantsContainer",
		"GuildInfoFrameApplicants",
		"GuildNewsBossModel",
		"GuildNewsBossModelTextFrame",
	}
	GuildRewardsFrameVisitText:ClearAllPoints()
	GuildRewardsFrameVisitText:SetPoint("TOP", GuildRewardsFrame, "TOP", 0, 30)
	for _, frame in pairs(striptextures) do _G[frame]:StripTextures() end

	GuildNewsBossModel:CreateBackdrop("Transparent")
	GuildNewsBossModelTextFrame:CreateBackdrop("Default")
	GuildNewsBossModelTextFrame.backdrop:Point("TOPLEFT", GuildNewsBossModel.backdrop, "BOTTOMLEFT", 0, -1)
	GuildNewsBossModel:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 4, -43)

	local buttons = {
		"GuildMemberRemoveButton",
		"GuildMemberGroupInviteButton",
		"GuildAddMemberButton",
		"GuildViewLogButton",
		"GuildControlButton",
		"GuildRecruitmentListGuildButton",
		"GuildTextEditFrameAcceptButton",
		"GuildRecruitmentInviteButton",
		"GuildRecruitmentMessageButton",
		"GuildRecruitmentDeclineButton",
	}
	for i, button in pairs(buttons) do
		if i == 1 then _G[button]:SkinButton() else _G[button]:SkinButton(true) end
	end

	local checkbuttons = {
		"Quest", 
		"Dungeon",
		"Raid",
		"PvP",
		"RP",
		"Weekdays",
		"Weekends",
		"LevelAny",
		"LevelMax",
	}
	for _, frame in pairs(checkbuttons) do _G["GuildRecruitment" .. frame .. "Button"]:SkinCheckBox() end

	GuildRecruitmentTankButton:GetChildren():SkinCheckBox()
	GuildRecruitmentHealerButton:GetChildren():SkinCheckBox()
	GuildRecruitmentDamagerButton:GetChildren():SkinCheckBox()

	for i = 1, 5 do _G["GuildFrameTab" .. i]:SkinTab() end

	GuildPerksContainerScrollBar:SkinScrollBar(4)

	GuildFactionBar:StripTextures()
	GuildFactionBar.progress:SetTexture(C["media"].normTex)
	GuildFactionBar:CreateBackdrop("Default")
	GuildFactionBar.backdrop:Point("TOPLEFT", GuildFactionBar.progress, "TOPLEFT", -2, 2)
	GuildFactionBar.backdrop:Point("BOTTOMRIGHT", GuildFactionBar, "BOTTOMRIGHT", 1, 0)

	--Roster
	GuildRosterContainerScrollBar:SkinScrollBar(5)
	GuildRosterShowOfflineButton:SkinCheckBox()
	for i = 1, 4 do _G["GuildRosterColumnButton" .. i]:StripTextures(true) end
	GuildRosterViewDropdown:SkinDropDownBox(200)
	for i = 1, 14 do _G["GuildRosterContainerButton"..i.."HeaderButton"]:SkinButton(true) end

	--Detail Frame
	GuildMemberDetailFrame:SetTemplate("Transparent")
	GuildMemberNoteBackground:SetTemplate("Transparent")
	GuildMemberOfficerNoteBackground:SetTemplate("Transparent")
	GuildMemberRankDropdown:SetFrameLevel(GuildMemberRankDropdown:GetFrameLevel() + 5)
	GuildMemberRankDropdown:SkinDropDownBox(175)

	--News
	GuildNewsFrame:StripTextures()
	for i = 1, 17 do
		if _G["GuildNewsContainerButton" .. i] then _G["GuildNewsContainerButton" .. i].header:Kill() end
	end
	GuildNewsFiltersFrame:StripTextures()
	GuildNewsFiltersFrame:SetTemplate("Transparent")
	GuildNewsFiltersFrameCloseButton:SkinCloseButton()
	for i = 1, 6 do _G["GuildNewsFilterButton" .. i]:SkinCheckBox() end
	GuildNewsFiltersFrame:Point("TOPLEFT", GuildFrame, "TOPRIGHT", 4, -20)
	GuildNewsContainerScrollBar:SkinScrollBar(4)

	--Info Frame
	GuildInfoDetailsFrameScrollBar:SkinScrollBar(4)
	for i = 1, 3 do _G["GuildInfoFrameTab" .. i]:StripTextures() end

	local backdrop1 = CreateFrame("Frame", nil, GuildInfoFrameInfo)
	backdrop1:SetTemplate("Transparent")
	backdrop1:SetFrameLevel(GuildInfoFrameInfo:GetFrameLevel() - 1)
	backdrop1:Point("TOPLEFT", GuildInfoFrameInfo, "TOPLEFT", 2, -22)
	backdrop1:Point("BOTTOMRIGHT", GuildInfoFrameInfo, "BOTTOMRIGHT", 0, 200)

	local backdrop2 = CreateFrame("Frame", nil, GuildInfoFrameInfo)
	backdrop2:SetTemplate("Transparent")
	backdrop2:SetFrameLevel(GuildInfoFrameInfo:GetFrameLevel() - 1)
	backdrop2:Point("TOPLEFT", GuildInfoFrameInfo, "TOPLEFT", 2, -158)
	backdrop2:Point("BOTTOMRIGHT", GuildInfoFrameInfo, "BOTTOMRIGHT", 0, 118)	

	local backdrop3 = CreateFrame("Frame", nil, GuildInfoFrameInfo)
	backdrop3:SetTemplate("Transparent")
	backdrop3:SetFrameLevel(GuildInfoFrameInfo:GetFrameLevel() - 1)
	backdrop3:Point("TOPLEFT", GuildInfoFrameInfo, "TOPLEFT", 2, -233)
	backdrop3:Point("BOTTOMRIGHT", GuildInfoFrameInfo, "BOTTOMRIGHT", 0, 3)	

	GuildRecruitmentCommentInputFrame:SetTemplate("Transparent")

	for _, button in next, GuildInfoFrameApplicantsContainer.buttons do
		button.selectedTex:Kill()
		button:GetHighlightTexture():Kill()
		button:SetBackdrop(nil)
	end

	--Text Edit Frame
	GuildTextEditFrame:SetTemplate("Transparent")
	GuildTextEditScrollFrameScrollBar:SkinScrollBar(5)
	GuildTextEditContainer:SetTemplate("Transparent")
	for i = 1, GuildTextEditFrame:GetNumChildren() do
		local child = select(i, GuildTextEditFrame:GetChildren())
		if child:GetName() == "GuildTextEditFrameCloseButton" and child:GetWidth() < 33 then
			child:SkinCloseButton()
		elseif child:GetName() == "GuildTextEditFrameCloseButton" then
			child:SkinButton(true)
		end
	end

	--Guild Log
	GuildLogScrollFrameScrollBar:SkinScrollBar(4)
	GuildLogFrame:SetTemplate("Transparent")

	--Blizzard has two buttons with the same name, this is a fucked up way of determining that it isn't the other button
	for i = 1, GuildLogFrame:GetNumChildren() do
		local child = select(i, GuildLogFrame:GetChildren())
		if child:GetName() == "GuildLogFrameCloseButton" and child:GetWidth() < 33 then
			child:SkinCloseButton()
		elseif child:GetName() == "GuildLogFrameCloseButton" then
			child:SkinButton(true)
		end
	end

	--Perks
	for i = 1, 9 do
		local button = _G["GuildPerksContainerButton" .. i]
		button:DisableDrawLayer("BACKGROUND")
		button:DisableDrawLayer("BORDER")

		button.icon:SetTexCoord(unpack(D.IconCoord))
		button:CreateBackdrop()
		button.backdrop:SetOutside(button.icon)
	end

	--Rewards
	GuildRewardsContainerScrollBar:SkinScrollBar(5)
	for i = 1, 8 do
		local button = _G["GuildRewardsContainerButton" .. i]
		button:StripTextures()

		if button.icon then
			button.icon:SetTexCoord(unpack(D.IconCoord))
			button.icon:ClearAllPoints()
			button.icon:Point("TOPLEFT", 2, -2)
			button:CreateBackdrop("Default")
			button.backdrop:SetOutside(button.icon)
			button.icon:SetParent(button.backdrop)
		end
	end
	local SIX_DAYS = 6 * 24 * 60 * 60
	local GUILD_EVENT_TEXTURES = {
		--[CALENDAR_EVENTTYPE_RAID] = "Interface\\LFGFrame\\LFGIcon-",
		--[CALENDAR_EVENTTYPE_DUNGEON] = "Interface\\LFGFrame\\LFGIcon-",
		[CALENDAR_EVENTTYPE_PVP] = "Interface\\Calendar\\UI-Calendar-Event-PVP",
		[CALENDAR_EVENTTYPE_MEETING] = "Interface\\Calendar\\MeetingIcon",
		[CALENDAR_EVENTTYPE_OTHER] = "Interface\\Calendar\\UI-Calendar-Event-Other",
		--[CALENDAR_EVENTTYPE_HEROIC_DUNGEON] = "Interface\\LFGFrame\\LFGIcon-",
	}
	local GUILD_EVENT_TEXTURE_PATH = "Interface\\LFGFrame\\LFGIcon-"
	function GuildInfoEvents_SetButton(button, eventIndex)
		local today = date("*t")
		local month, day, weekday, hour, minute, eventType, title, calendarType, textureName = CalendarGetGuildEventInfo(eventIndex)
		local displayTime = GameTime_GetFormattedTime(hour, minute, true)
		local displayDay

		if (today["day"] == day and today["month"] == month) then
			displayDay = NORMAL_FONT_COLOR_CODE .. GUILD_EVENT_TODAY .. FONT_COLOR_CODE_CLOSE
		else
			local year = today["year"]
			if (month < today["month"]) then year = year + 1 end
			local eventTime = time{year = year, month = month, day = day}
			if (eventTime - time() < SIX_DAYS) and CALENDAR_WEEKDAY_NAMES[weekday] then
				displayDay = CALENDAR_WEEKDAY_NAMES[weekday]
			elseif CALENDAR_WEEKDAY_NAMES[weekday] and day and month then
				displayDay = format(GUILD_NEWS_DATE, CALENDAR_WEEKDAY_NAMES[weekday], day, month)
			end
		end

		if displayDay then button.text:SetFormattedText(GUILD_EVENT_FORMAT, displayDay, displayTime, title) end
		button.index = eventIndex
		if button.icon.type ~= "event" then
			button.icon.type = "event"
			button.icon:SetTexCoord(0, 1, 0, 1)
			button.icon:SetWidth(14)
			button.icon:SetHeight(14)
		end
		if GUILD_EVENT_TEXTURES[eventType] then button.icon:SetTexture(GUILD_EVENT_TEXTURES[eventType]) else button.icon:SetTexture(GUILD_EVENT_TEXTURE_PATH .. textureName) end	
	end	
end

D.SkinFuncs["Blizzard_GuildUI"] = LoadSkin