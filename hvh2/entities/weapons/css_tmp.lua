AddCSLuaFile()
--[[
game.AddAmmoType({
	name = "7.64"
})
]]
SWEP.Author				= "XmegaaAAa" -- Original Author : Hasster. Credits to him :)
SWEP.Purpose			= "That's a Submachine gun."
SWEP.PrintName			= "TMP"
SWEP.Slot				= 2
SWEP.SlotPos			= 3
SWEP.ViewModelFlip				= false -- Flip the model? Usally used for CS:S models
SWEP.ViewModelFOV		= 54
SWEP.IconLetter			= "x"

SWEP.Base = "weapon_base"
SWEP.Category 			= "Counter Strike: Source"
SWEP.PrintName = "TMP"	
SWEP.ViewModel		= "models/weapons/cstrike/c_smg_tmp.mdl"	
SWEP.WorldModel		= "models/weapons/w_smg_tmp.mdl"
SWEP.UseHands = true
SWEP.ReloadSound		= "Weapon_SMG1.Reload"	
SWEP.HoldType		= "ar2"	
SWEP.CSMuzzleFlashes	= true		

SWEP.Weight		= 40		
SWEP.AutoSwitchTo		= true			
SWEP.Spawnable		= true		

SWEP.Primary.Sound			= Sound("weapons/tmp/tmp-1.wav")
SWEP.Primary.Damage		= 15
SWEP.Primary.NumShots		= 0	
SWEP.Primary.Recoil			= 3			
SWEP.Primary.Cone			= 6	
SWEP.Primary.Delay			= 0.09
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false
SWEP.Primary.ClipSize		= 30		
SWEP.Primary.DefaultClip	= 120		
SWEP.Primary.Force			= 3
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "SMG1"	
		
SWEP.Secondary.ClipSize		= -1	
SWEP.Secondary.DefaultClip	                  = -1
SWEP.Secondary.Automatic	   = false
SWEP.Secondary.Ammo		= "none"		



function SWEP:Initialize()	
self:SetWeaponHoldType( self.HoldType )		
end

function SWEP:PrimaryAttack()		
	if ( !self:CanPrimaryAttack() ) then return end		
	local bullet = {}	-- Set up the shot
		bullet.Num = self.Primary.NumShots				
		bullet.Src = self.Owner:GetShootPos()			
		bullet.Dir = self.Owner:GetAimVector()			
		bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 			90, 0 )
		bullet.Tracer = self.Primary.Tracer				
		bullet.Force = self.Primary.Force				
		bullet.Damage = self.Primary.Damage				
		bullet.AmmoType = self.Primary.Ammo				
		self.Owner:FireBullets( bullet )				
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )	
	self.Owner:MuzzleFlash()							
	self.Owner:SetAnimation( PLAYER_ATTACK1 )			
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	if (self.Owner:IsPlayer()) then
		self.Owner:ViewPunch(Angle( -0.5, 0, 0, 0 ))
	end
	if (self.Primary.TakeAmmoPerBullet) then			
		self:TakePrimaryAmmo(self.Primary.NumShots)
	else
		if (self.Owner:IsPlayer()) then -- I have enough of these NPCs trying to shoot even if the gun is empty.
			self:TakePrimaryAmmo(1)
		end
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )	
end

function SWEP:SecondaryAttack()
end

function SWEP:DrawHUD()
	local x, y

	x, y = ScrW() / 2.0, ScrH() / 2.0
	
	local scale = 10 * self.Primary.Cone
	
	local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))
	
	surface.SetDrawColor( 0, 255, 0, 255 )
	
	local gap = 0.9 * scale
	local length = gap + 0.4 * scale
	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )

end

function SWEP:Think()
local ground = self.Owner:GetGroundEntity()
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 4.6
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 2.4
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 2.4
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 2.4
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 2.4
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 4.6
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 4.6
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 4.6
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 2
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 6
			else
			self.Primary.Cone = 4
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end
							end

function SWEP:Reload()				
	self:DefaultReload(ACT_VM_RELOAD)
	return true
end

function SWEP:Deploy()				
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

	//self.Reloadaftershoot = CurTime() + 1
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	return true
end

function SWEP:Holster()				
	return true
end

-- Fonctionnement de l'arme par NPCs

function SWEP:GetCapabilities()
	-- The NPC capabilities.
	return bit.bor(CAP_WEAPON_RANGE_ATTACK1 , CAP_INNATE_RANGE_ATTACK1)
end

function SWEP:CanBePickedUpByNPCs()
	-- Weapon can be picked up by NPCs?
	return true
end

function SWEP:ShouldDropOnDie()
	-- Weapon should be dropped on death?
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

	return 1, 5, 0.09

end

function SWEP:GetNPCBulletSpread( proficiency )

	-- Determine the accuracy of the NPC holding the weapon. (We call that the Proficiency)
	-- The lower the var, the more accurate the NPC is. (Var in degrees)

	return 1

end