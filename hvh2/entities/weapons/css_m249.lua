AddCSLuaFile()
--[[
game.AddAmmoType({
	name = "5.56"
})
]]
SWEP.PrintName =			"M249"
SWEP.AuthorName =			"XmegaaAAa"
SWEP.Purpose =				"I'll be honnest, it's my favourite weapon from CS:S."
SWEP.Category =				"Counter Strike: Source"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Slot = 2
SWEP.SlotPos = 5

SWEP.BobScale				= 1
SWEP.SwayScale				= 1

SWEP.Primary.ClipSize		= 90
SWEP.Primary.DefaultClip	= 500
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"
SWEP.Primary.Delay			= 0.07

SWEP.Primary.Sound = Sound("weapons/m249/m249-1.wav")
SWEP.Primary.Damage = 13
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Spread = 0.5 
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Recoil = 1

SWEP.Secondary.Ammo			= "none"

SWEP.FiresUnderwater = false -- Weapon can shoot underwater?
SWEP.DrawCrosshair = true
SWEP.AccurateCrosshair = false -- If true, the crosshair is accurate but the +zoom feature will be completly messed up.
SWEP.DrawAmmo = true
SWEP.BobScale = 0.75
SWEP.SwayScale = 0.35
SWEP.Base = "weapon_base"

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
end

function SWEP:PrimaryAttack()

	if not (self:CanPrimaryAttack()) then return self:Reload() end

	local bullet = {} 
	bullet.Num = self.Primary.NumberofShots 
	bullet.Src = self.Owner:GetShootPos() 
	bullet.Dir = self.Owner:GetAimVector() 
	bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
	bullet.Tracer = 1
	bullet.TracerName = "Tracer" -- This add a sort of trail for each bullets.
	bullet.Force = self.Primary.Force 
	bullet.Damage = self.Primary.Damage 
	bullet.AmmoType = self.Primary.Ammo 
		 
	self:ShootEffects()
		 
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound(self.Primary.Sound)) 
		
	if (self.Owner:IsPlayer()) then -- I have enough of these NPCs trying to shoot even if the gun is empty.
		self.Owner:ViewPunch( Angle( 0, math.random(-0.1, 0.1), math.random(-0.35, 0.35) ) ) 
		self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	end
		 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + 0.25 )
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon:SequenceDuration())
	return true
end

-------- WEAPON CONFIGURATION FOR NPCS --------

function SWEP:ShouldDropOnDie()
	-- Weapon should be dropped on death?
	return true
end

function SWEP:CanBePickedUpByNPCs()
	-- Weapon can be picked up by NPCs?
	return true
end

function SWEP:GetNPCRestTimes()

	-- Handles the time between bursts.
	-- First var is min, second var is max. (All in seconds)
	-- Rest time before the NPC shoots again.

	return 0.35, 0.5

end

function SWEP:GetNPCBurstSettings()

	-- Burst parameters
	-- 1st var is minimal burst number, 2nd var is maximal, 3rd var is the delay between each shots.
	-- The delay between each shots if weapon is automatic

	return 5, 10, 0.07

end

function SWEP:GetNPCBulletSpread( proficiency )

	-- Determine the accuracy of the NPC holding the weapon. (We call that the Proficiency)
	-- The lower the var, the more accurate the NPC is. (Var in degrees)

	return 0.01

end