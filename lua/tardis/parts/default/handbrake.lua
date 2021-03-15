-- Default Interior - Handbrake

local PART = {}
PART.ID = "default_handbrake"
PART.Name = "Default Handbrake"
PART.Control = "handbrake"
PART.Model = "models/drmatt/tardis/handbrake.mdl"
PART.AutoSetup = true
PART.Collision = true
PART.Animate = true
PART.Sound = "tardis/control_handbrake.wav"

TARDIS:AddPart(PART)
