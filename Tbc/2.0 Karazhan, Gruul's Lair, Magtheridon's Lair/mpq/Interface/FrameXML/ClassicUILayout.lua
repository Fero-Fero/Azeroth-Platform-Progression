-- Classic/vanilla UI layout overrides for AzerothCore 3.3.5a

local TALENTS_TAB = 1;
local GLYPH_TALENT_TAB = 4;

local function ClassicUI_SelectTalentsTab()
	if not PlayerTalentFrame then
		return;
	end

	local talentsTab = _G["PlayerTalentFrameTab"..TALENTS_TAB];
	if not talentsTab then
		return;
	end

	if PanelTemplates_GetSelectedTab(PlayerTalentFrame) == GLYPH_TALENT_TAB then
		if PlayerTalentTab_OnClick then
			PlayerTalentTab_OnClick(talentsTab);
		elseif PlayerTalentFrameTab_OnClick then
			PlayerTalentFrameTab_OnClick(talentsTab);
		end
	end
end

local function ClassicUI_HideGlyphTab()
	local glyphTab = _G["PlayerTalentFrameTab"..GLYPH_TALENT_TAB];
	if glyphTab then
		glyphTab:Hide();
		glyphTab:EnableMouse(false);
	end

	ClassicUI_SelectTalentsTab();
end

local function ClassicUI_HookTalentUI()
	if not PlayerTalentFrame then
		return;
	end

	ClassicUI_HideGlyphTab();

	if not ClassicUI_TalentUIHooked then
		if PlayerTalentFrame_UpdateTabs then
			hooksecurefunc("PlayerTalentFrame_UpdateTabs", ClassicUI_HideGlyphTab);
		end

		if PlayerTalentFrame_Refresh then
			hooksecurefunc("PlayerTalentFrame_Refresh", ClassicUI_SelectTalentsTab);
		end

		if PlayerGlyphTab_OnClick then
			PlayerGlyphTab_OnClick = function()
				ClassicUI_SelectTalentsTab();
			end;
		end

		PlayerTalentFrame:HookScript("OnShow", ClassicUI_HideGlyphTab);
		ClassicUI_TalentUIHooked = true;
	end
end

local function ClassicUI_HideAchievementFrame()
	if AchievementFrame and AchievementFrame:IsShown() then
		HideUIPanel(AchievementFrame);
	end
end

local function ClassicUI_BlockAchievementFrameShow(frame)
	if frame and frame.HookScript then
		frame:HookScript("OnShow", function(self)
			self:Hide();
		end);
	end
	frame:Hide();
end

function ClassicUI_BlockAchievements()
	ToggleAchievementFrame = function()
		ClassicUI_HideAchievementFrame();
	end;

	InspectAchievements = function()
	end;

	AchievementFrame_LoadUI = function()
	end;

	AchievementFrame_ToggleAchievementFrame = function()
		ClassicUI_HideAchievementFrame();
	end;

	AchievementFrame_SelectAchievement = function()
	end;

	AchievementFrame_DisplayComparison = function()
	end;

	WatchFrame_OpenAchievementFrame = function()
	end;

	AchievementAlertFrame_OnClick = function()
	end;

	if not ClassicUI_ShowUIPanelHooked then
		hooksecurefunc("ShowUIPanel", function(frame)
			if frame and frame.GetName and frame:GetName() == "AchievementFrame" then
				frame:Hide();
			end
		end);
		ClassicUI_ShowUIPanelHooked = true;
	end

	for _, menu in pairs({"PARTY", "PLAYER", "RAID_PLAYER"}) do
		local popupMenu = UnitPopupMenus[menu];
		if popupMenu then
			for i = #popupMenu, 1, -1 do
				if popupMenu[i] == "ACHIEVEMENTS" then
					table.remove(popupMenu, i);
				end
			end
		end
	end

	if AchievementFrame then
		ClassicUI_BlockAchievementFrameShow(AchievementFrame);
	end
end

function ClassicUI_ApplyLayout()
	if AchievementMicroButton then
		AchievementMicroButton:Hide();
		AchievementMicroButton:EnableMouse(false);
	end

	if QuestLogMicroButton and TalentMicroButton then
		QuestLogMicroButton:ClearAllPoints();
		QuestLogMicroButton:SetPoint("BOTTOMLEFT", TalentMicroButton, "BOTTOMRIGHT", -3, 0);
	end

	if LFDMicroButton then
		LFDMicroButton:Hide();
		LFDMicroButton:EnableMouse(false);
	end

	if LFDParentFrame then
		LFDParentFrame:Hide();
	end

	if LFRParentFrame then
		LFRParentFrame:Hide();
	end

	if MiniMapLFGFrame then
		MiniMapLFGFrame:Hide();
	end

	if LFDSearchStatus then
		LFDSearchStatus:Hide();
	end

	if RaidFrameRaidBrowserDescription then
		RaidFrameRaidBrowserDescription:Hide();
	end

	if RaidFrameNotInRaidRaidBrowserButton then
		RaidFrameNotInRaidRaidBrowserButton:Hide();
	end

	TalentFrame_LoadUI();
	ClassicUI_HookTalentUI();
	ClassicUI_BlockAchievements();
end

ClassicUI_BlockAchievements();

local classicUIFrame = CreateFrame("Frame");
classicUIFrame:RegisterEvent("ADDON_LOADED");
classicUIFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
classicUIFrame:SetScript("OnEvent", function(self, event, addonName)
	if event == "ADDON_LOADED" and addonName == "Blizzard_AchievementUI" then
		ClassicUI_BlockAchievements();
		if AchievementFrame then
			HideUIPanel(AchievementFrame);
			ClassicUI_BlockAchievementFrameShow(AchievementFrame);
		end
	elseif event == "ADDON_LOADED" and addonName == "Blizzard_TalentUI" then
		ClassicUI_HookTalentUI();
	elseif event == "PLAYER_ENTERING_WORLD" then
		ClassicUI_ApplyLayout();
	end
end);
