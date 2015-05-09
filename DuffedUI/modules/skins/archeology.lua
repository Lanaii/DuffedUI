local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	ArchaeologyFrame:StripTextures(true)
	ArchaeologyFrameInset:StripTextures(true)
	ArchaeologyFrame:SetTemplate("Transparent")

	ArchaeologyFrameArtifactPageSolveFrameSolveButton:SkinButton(true)
	ArchaeologyFrameRaceFilter:SkinDropDownBox(125)
	
	ArchaeologyFrameRankBar:StripTextures()
	ArchaeologyFrameRankBar:SetStatusBarTexture(C["media"].normTex)
	ArchaeologyFrameRankBar:CreateBackdrop("Default")

	ArchaeologyFrameArtifactPageSolveFrameStatusBar:StripTextures()
	ArchaeologyFrameArtifactPageSolveFrameStatusBar:SetStatusBarTexture(C["media"].normTex)
	ArchaeologyFrameArtifactPageSolveFrameStatusBar:SetStatusBarColor(.7, .2, 0)
	ArchaeologyFrameArtifactPageSolveFrameStatusBar:CreateBackdrop("Default")

	for i=1, ARCHAEOLOGY_MAX_COMPLETED_SHOWN do
		local artifact = _G["ArchaeologyFrameCompletedPageArtifact"..i]

		if artifact then
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."Border"]:Kill()
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."Bg"]:Kill()
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"]:SetTexCoord(.08, .92, .08, .92)
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"].backdrop = CreateFrame("Frame", nil, artifact)
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"].backdrop:SetTemplate("Default")
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"].backdrop:Point("TOPLEFT", _G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"], "TOPLEFT", -2, 2)
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"].backdrop:Point("BOTTOMRIGHT", _G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"], "BOTTOMRIGHT", 2, -2)
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"].backdrop:SetFrameLevel(artifact:GetFrameLevel() - 2)
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."Icon"]:SetDrawLayer("OVERLAY")
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."ArtifactName"]:SetTextColor(1, 1, 0)
			_G["ArchaeologyFrameCompletedPageArtifact"..i.."ArtifactSubText"]:SetTextColor(.6, .6, .6)
		end
	end

	for i=1, ARCHAEOLOGY_MAX_RACES do
		local frame = _G["ArchaeologyFrameSummaryPageRace"..i]
		if frame then frame.raceName:SetTextColor(1, 1, 1) end
	end

	for i=1, ArchaeologyFrameCompletedPage:GetNumRegions() do
		local region = select(i, ArchaeologyFrameCompletedPage:GetRegions())
		if region:GetObjectType() == "FontString" then region:SetTextColor(1, 1, 0) end
	end

	for i=1, ArchaeologyFrameSummaryPage:GetNumRegions() do
		local region = select(i, ArchaeologyFrameSummaryPage:GetRegions())
		if region:GetObjectType() == "FontString" then region:SetTextColor(1, 1, 0) end
	end

	ArchaeologyFrameCompletedPage.infoText:SetTextColor(1, 1, 1)
	ArchaeologyFrameHelpPageTitle:SetTextColor(1, 1, 0)
	ArchaeologyFrameHelpPageDigTitle:SetTextColor(1, 1, 0)
	ArchaeologyFrameHelpPageHelpScrollHelpText:SetTextColor(1, 1, 1)

	ArchaeologyFrameArtifactPageHistoryTitle:SetTextColor(1, 1, 0)
	ArchaeologyFrameArtifactPageIcon:SetTexCoord(.08, .92, .08, .92)
	ArchaeologyFrameArtifactPageIcon.backdrop = CreateFrame("Frame", nil, ArchaeologyFrameArtifactPage)
	ArchaeologyFrameArtifactPageIcon.backdrop:SetTemplate("Default")
	ArchaeologyFrameArtifactPageIcon.backdrop:Point("TOPLEFT", ArchaeologyFrameArtifactPageIcon, "TOPLEFT", -2, 2)
	ArchaeologyFrameArtifactPageIcon.backdrop:Point("BOTTOMRIGHT", ArchaeologyFrameArtifactPageIcon, "BOTTOMRIGHT", 2, -2)
	ArchaeologyFrameArtifactPageIcon.backdrop:SetFrameLevel(ArchaeologyFrameArtifactPage:GetFrameLevel())
	ArchaeologyFrameArtifactPageIcon:SetParent(ArchaeologyFrameArtifactPageIcon.backdrop)
	ArchaeologyFrameArtifactPageIcon:SetDrawLayer("OVERLAY")

	ArchaeologyFrameArtifactPageHistoryScrollChildText:SetTextColor(1, 1, 1)
	ArchaeologyFrameCloseButton:SkinCloseButton()
	ArchaeologyFrameCompletedPagePrevPageButton:SkinCloseButton()
	ArchaeologyFrameCompletedPageNextPageButton:SkinCloseButton()
	ArchaeologyFrameCompletedPagePrevPageButton.t:SetText("<")
	ArchaeologyFrameCompletedPageNextPageButton.t:SetText(">")

	ArcheologyDigsiteProgressBar:StripTextures()
	ArcheologyDigsiteProgressBar.FillBar:StripTextures()
	ArcheologyDigsiteProgressBar.FillBar:SetStatusBarTexture(C["media"].normTex)
	ArcheologyDigsiteProgressBar.FillBar:SetStatusBarColor(.7, .2, 0)
	ArcheologyDigsiteProgressBar.FillBar:SetFrameLevel(ArchaeologyFrameArtifactPageSolveFrameStatusBar:GetFrameLevel() + 2)
	ArcheologyDigsiteProgressBar.FillBar:CreateBackdrop("Transparent")
	ArcheologyDigsiteProgressBar.BarTitle:SetFont(C["media"].font, 11, "THINOUTLINE")
	ArcheologyDigsiteProgressBar:ClearAllPoints()
	ArcheologyDigsiteProgressBar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 200)
end

D.SkinFuncs["Blizzard_ArchaeologyUI"] = LoadSkin