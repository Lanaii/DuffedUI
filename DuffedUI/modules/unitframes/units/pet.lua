local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]
local backdrop = {
	bgFile = C["media"].blank,
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

D["ConstructUFPet"] = function(self)
	self.colors = D["UnitColor"]

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self.menu = D["SpawnMenu"]

	if layout == 1 then
		local panel = CreateFrame("Frame", nil, self)
		panel:Size(129, 17)
		panel:Point("BOTTOM", self, "BOTTOM", 0, 0)
		panel:SetAlpha(0)
		self.panel = panel
	end

	local health = CreateFrame("StatusBar", nil, self)
	if layout == 1 then
		health:Height(17)
	elseif layout == 3 then
		health:Height(16)
	elseif layout == 4 then
		health:Height(20)
	end
	health:SetStatusBarTexture(texture)
	health:Point("TOPLEFT", 2, -2)
	health:Point("BOTTOMRIGHT", -2, 2)

	local HealthBorder = CreateFrame("Frame", nil, health)
	HealthBorder:Point("TOPLEFT", health, "TOPLEFT", D.Scale(-2), D.Scale(2))
	HealthBorder:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	HealthBorder:SetTemplate("Default")
	HealthBorder:SetFrameLevel(2)
	self.HealthBorder = HealthBorder

	local healthBG = health:CreateTexture(nil, "BORDER")
	healthBG:SetAllPoints()
	healthBG:SetTexture(0, 0, 0)

	self.Health = health
	self.Health.bg = healthBG
	health.PostUpdate = D.PostUpdatePetColor

	health.frequentUpdates = true
	if C["unitframes"].showsmooth == true then health.Smooth = true end
	if C["unitframes"].unicolor == true then
		health.colorTapping = false
		health.colorDisconnected = false
		health.colorClass = false
		health:SetStatusBarColor(unpack(C["unitframes"].healthbarcolor))
		healthBG:SetVertexColor(unpack(C["unitframes"].deficitcolor))
		healthBG:SetTexture(.6, .6, .6)
		if C["unitframes"].ColorGradient then
			health.colorSmooth = true
			--healthBG:SetTexture(0, 0, 0)
		end
	else
		health.colorDisconnected = true
		health.colorTapping = true
		health.colorClass = true
		health.colorReaction = true
	end

	if layout == 1 or layout == 3 then
		local power = CreateFrame("StatusBar", nil, self)
		if layout == 1 then
			power:Height(3)
			power:Point("TOPLEFT", health, "BOTTOMLEFT", 9, 1)
			power:Point("TOPRIGHT", health, "BOTTOMRIGHT", -9, -2)
		else
			power:Height(1)
			power:Point("TOPLEFT", health, "BOTTOMLEFT", 0, 1)
			power:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, 1)
		end
		power:SetStatusBarTexture(texture)
		power:SetFrameLevel(self.Health:GetFrameLevel() + 2)

		if layout == 1 then
			local PowerBorder = CreateFrame("Frame", nil, power)
			PowerBorder:Point("TOPLEFT", power, "TOPLEFT", D.Scale(-2), D.Scale(2))
			PowerBorder:Point("BOTTOMRIGHT", power, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
			PowerBorder:SetTemplate("Default")
			PowerBorder:SetFrameLevel(power:GetFrameLevel() - 1)
			self.PowerBorder = PowerBorder
		end

		local powerBG = power:CreateTexture(nil, "BORDER")
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(texture)
		powerBG.multiplier = .3

		power.frequentUpdates = true
		if C["unitframes"]["unicolor"] then
			power.colorTapping = true
			power.colorPower = true
		else
			power.colorPower = true
		end
		if C["unitframes"]["showsmooth"] then power.Smooth = true end

		self.Power = power
		self.Power.bg = powerBG
	end

	local Name = health:CreateFontString(nil, "OVERLAY")
	self:Tag(Name, "[DuffedUI:getnamecolor][DuffedUI:nameshort] [DuffedUI:diffcolor][level] [shortclassification]")
	if layout == 1 then Name:Point("CENTER", health, "CENTER", 2, 2) else Name:Point("CENTER", health) end
	Name:SetJustifyH("CENTER")
	Name:SetFontObject(font)
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(1.25, -1.25)
	self.Name = Name

	if C["unitframes"]["charportrait"] and layout == 3 then
		local portrait = CreateFrame("PlayerModel", nil, self)
		portrait:Size(16)
		portrait:Point("RIGHT", health, "LEFT", -6, 0)
		portrait:CreateBackdrop()
		portrait.PostUpdate = D.PortraitUpdate 
		self.Portrait = portrait
	end

	if C["castbar"]["enable"] then
		local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
		castbar:SetStatusBarTexture(texture)
		if layout == 3 then
			castbar:Height(16)
			castbar:SetFrameLevel(health:GetFrameLevel() + 4)
		else
			castbar:Height(3)
		end
		self.Castbar = castbar
		castbar:Point("TOPLEFT", health, "BOTTOMLEFT", 0, 16)
		castbar:Point("TOPRIGHT", health, "BOTTOMRIGHT", 0, 16)

		if layout == 1 or layout == 2 then
			castbar.bg = castbar:CreateTexture(nil, "BORDER")
			castbar.bg:SetTexture(texture)
			castbar.bg:SetVertexColor(0, 0, 0)
			castbar:SetFrameLevel(6)
		end

		if layout == 3 then
			castbar.time = castbar:CreateFontString(nil, "OVERLAY")
			castbar.time:SetFontObject(font)
			castbar.time:Point("RIGHT", castbar, "RIGHT", -5, 0)
			castbar.time:SetTextColor(.84, .75, .65)
			castbar.time:SetJustifyH("RIGHT")

			castbar.Text = castbar:CreateFontString(nil, "OVERLAY")
			castbar.Text:SetFontObject(font)
			castbar.Text:Point("LEFT", castbar, "LEFT", 6, 0)
			castbar.Text:SetTextColor(.84, .75, .65)
		end

		castbar.CustomTimeText = D["CustomTimeText"]
		castbar.CustomDelayText = D["CustomDelayText"]
		castbar.PostCastStart = D["CastBar"]
		castbar.PostChannelStart = D["CastBar"]

		self.Castbar.Time = castbar.time
	end
	self:RegisterEvent("UNIT_PET", D.updateAllElements)
end