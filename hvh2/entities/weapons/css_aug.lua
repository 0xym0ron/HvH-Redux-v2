AddCSLuaFile()
--[[
game.AddAmmoType({
	name = "7.50"
})
]]
SWEP.Author				= "XmegaaAAa" -- Original Author : Hasster. Credits to him :)
SWEP.Purpose			= "That's for me an alternative for the M4A1"
SWEP.PrintName			= "Aug"
SWEP.SlotPos			= 2
SWEP.Slot				= 3
SWEP.ViewModelFlip				= false -- Flip the model? Usally used for CS:S models
SWEP.ViewModelFOV		= 54
SWEP.IconLetter			= "x"
	
SWEP.Base = "weapon_base"
SWEP.Category 			= "Counter Strike: Source"
SWEP.PrintName = "Aug"	
SWEP.ViewModel		= "models/weapons/cstrike/c_rif_aug.mdl"	
SWEP.WorldModel		= "models/weapons/w_rif_aug.mdl"
SWEP.UseHands = true
SWEP.ReloadSound		= "Weapon_SMG1.Reload"	
SWEP.HoldType 					= "ar2"
SWEP.CSMuzzleFlashes	= true		

SWEP.Weight		= 40		
SWEP.AutoSwitchTo		= true			
SWEP.Spawnable		= true		
		
SWEP.Primary.Sound			= Sound("weapons/aug/aug-1.wav")
SWEP.Primary.Damage		= 13
SWEP.Primary.NumShots		= 0	
SWEP.Primary.Recoil			= 3			
SWEP.Primary.Delay			= 0.1
SWEP.DrawAmmo = true
SWEP.Primary.Cone = 2.4
SWEP.DrawCrosshair = false
SWEP.Primary.ClipSize		= 30		
SWEP.Primary.DefaultClip	= 120		
SWEP.Primary.Force			= 3
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "AR2"	
		
SWEP.Secondary.ClipSize		= -1	
SWEP.Secondary.DefaultClip	                  = -1
SWEP.Secondary.Automatic	   = false
SWEP.Secondary.Ammo		= "none"	

SWEP.Zoom = 1	


function SWEP:Initialize()	
self:SetWeaponHoldType( self.HoldType )		
end

function SWEP:PrimaryAttack()		
	if ( !self:CanPrimaryAttack() ) then return end
				if (self.Zoom == 0 || self:Clip1() < 1 ) then
						self:ShootBullet( 23, 1, 0.008 )
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.3 )
		self:EmitSound(Sound("weapons/aug/aug-1.wav"))
		if (self.Owner:IsPlayer()) then -- I have enough of these NPCs trying to shoot even if the gun is empty.
			self:TakePrimaryAmmo( 1 )
		end
        self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		else
					if (self.Zoom == 1 || self:Clip1() < 1 ) then
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.08 )
		self:ShootBullet( 23, 1, 0.02 )
		self:EmitSound(Sound("weapons/aug/aug-1.wav"))
		if (self.Owner:IsPlayer()) then -- I have enough of these NPCs trying to shoot even if the gun is empty.
			self:TakePrimaryAmmo( 1 )
		end
        self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		end
	self.Owner:MuzzleFlash()
	if (self.Owner:IsPlayer()) then								
		self.Owner:ViewPunch(Angle( -0.5, 0, 0, 0 ))
	end
	end
end
function SWEP:SecondaryAttack()
	        if(self.Zoom == 1) then
	        	if (self.Owner:IsPlayer()) then
        	self.Owner:SetFOV( 60, 0.1 )
        end
		self:EmitSound("weapons/zoom.wav")
		self.Primary.Cone = 1.4
				self.Zoom = 0
		self:NextThink( CurTime() + self:SequenceDuration() )
	else
		if(self.Zoom == 0) then
			if (self.Owner:IsPlayer()) then
        	self.Owner:SetFOV( 0, 0.1)
        end
		self.Primary.Cone = 2.4
		self:EmitSound("weapons/zoom.wav")
				self.Zoom = 1
		self:NextThink( CurTime() + self:SequenceDuration() )
			end
		end
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
		if self.Owner:KeyDown( IN_FORWARD ) then
			if self.Primary.Cone < 0.03 then
				self.Primary.Cone	= self.Primary.Cone + 0.0005
			end
		elseif self.Owner:KeyDown( IN_BACK ) then
			if self.Primary.Cone < 0.03 then
				self.Primary.Cone	= self.Primary.Cone + 0.0005
			end
		elseif self.Owner:KeyDown( IN_MOVELEFT ) then
			if self.Primary.Cone < 0.03 then
				self.Primary.Cone	= self.Primary.Cone + 0.0005
			end
		elseif self.Owner:KeyDown( IN_MOVERIGHT ) then
			if self.Primary.Cone < 0.03 then
				self.Primary.Cone	= self.Primary.Cone + 0.0005
			end
			end
end			

function SWEP:Reload()	
 if ( self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
	self:DefaultReload(ACT_VM_RELOAD)	
	if (self.Owner:IsPlayer()) then
	        	self.Owner:SetFOV( 0, 0.1)
	        end
							self.Zoom = 1	
	return true
end
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

	return 5, 10, self.Primary.Delay

end

function SWEP:GetNPCBulletSpread( proficiency )

	-- Determine the accuracy of the NPC holding the weapon. (We call that the Proficiency)
	-- The lower the var, the more accurate the NPC is. (Var in degrees)

	return 0.14

end