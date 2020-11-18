
TARDIS:AddSetting({
	id="extprojlight-enabled",
	name="Door Light Enabled",
	section="Misc",
	desc="Should light shine out through the doors when they're open?",
	value=true,
	type="bool",
	option=true,
	networked=true
})

function ENT:CalcLightBrightness()
    local lightcolour = render.GetLightColor(self:GetPos()):ToColor()
    local rm = 0.299*lightcolour.r
    local gm = 0.587*lightcolour.g
    local bm = 0.114*lightcolour.b
    local luminance = rm + gm + rm
    return luminance
end

ENT:AddHook("Initialize", "projectedlight", function(self)
    self.projectedlight = ProjectedTexture()
    self.projectedlight:SetTexture("effects/flashlight/square")
    self.projectedlight:SetFarZ(250)
    self.projectedlight:SetVerticalFOV(self.metadata.Exterior.Portal.height)
    self.projectedlight:SetHorizontalFOV(self.metadata.Exterior.Portal.width+10)
    self.projectedlight:SetColor(self.metadata.Interior.Light.color)
    --self.projectedlight:SetBrightness(0.5)
	self.projectedlight:SetPos(self:LocalToWorld(Vector(0,0,50)))
	self.projectedlight:SetAngles(self:GetAngles())
	self.projectedlight:Update()
end)

ENT:AddHook("OnRemove", "projectedlight", function(self)
	if ( IsValid( self.projectedlight ) ) then
		self.projectedlight:Remove()
	end
end)

ENT:AddHook("Think", "projectedlight", function(self)
    if (not TARDIS:GetSetting("extprojlight-enabled")) then
        if self.projectedlight:GetEnableShadows() == true then 
            self.projectedlight:SetEnableShadows(false)
            self.projectedlight:SetBrightness(0)
            self.projectedlight:Update()
        end
        return
    end
    if self.projectedlight:GetBrightness() > 0 and not self:DoorOpen(true) then
        self.projectedlight:SetEnableShadows(false)
        self.projectedlight:SetBrightness(0)
        self.projectedlight:Update()
    elseif self:DoorOpen(true) and self.projectedlight:GetBrightness() == 0 then
        self.projectedlight:SetEnableShadows(true)
        self.projectedlight:SetBrightness(0.5)
    end
    if ( IsValid( self.projectedlight ) ) and self:DoorOpen(true) then
		self.projectedlight:SetPos( self:LocalToWorld(Vector(-25,0,51.1)) )
		self.projectedlight:SetAngles( self:LocalToWorldAngles(Angle(0,0,0)) )
		self.projectedlight:Update()
	end
end)