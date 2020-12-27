-- Hey guess what!? The MekoSniper Rifle use the worldmodel as base model :)

AddCSLuaFile()
--[[
game.AddAmmoType({
	name = "5.56"
})
]]
SWEP.Author				= "XmegaaAAa" -- Original Author : Hasster. Credits to him :)
SWEP.Purpose			= "So, I think you've fall on the right sniper rifle!"
SWEP.PrintName			= "SG550"
SWEP.Slot				= 4
SWEP.SlotPos			= 3
SWEP.ViewModelFlip				= false -- Flip the model? Usally used for CS:S models
SWEP.ViewModelFOV		= 54
SWEP.IconLetter			= "x"

SWEP.Spawnable = true
	
SWEP.Base = "weapon_base"
SWEP.Category 			= "Counter Strike: Source"	
SWEP.ViewModel		= "models/weapons/cstrike/c_snip_sg550.mdl"	
SWEP.WorldModel		= "models/weapons/w_snip_sg550.mdl"
SWEP.UseHands = true
SWEP.ReloadSound		= "Weapon_SMG1.Reload"	
SWEP.HoldType 					= "ar2"
SWEP.CSMuzzleFlashes	= true		

SWEP.Primary.Sound			= Sound("weapons/sg5520/sg550-1.wav")
SWEP.Primary.Damage		= 90
SWEP.Primary.NumShots		= 0	
SWEP.Primary.Recoil			= 3			
SWEP.Primary.Cone			= 2.4	
SWEP.Primary.Delay			= 0.1
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.Primary.ClipSize		= 30	
SWEP.Primary.DefaultClip	= 120		
SWEP.Primary.Force			= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "AR2"	
		
SWEP.Secondary.ClipSize		= -1	
SWEP.Secondary.DefaultClip	                  = -1
SWEP.Secondary.Automatic	   = false
SWEP.Secondary.Ammo		= "none"	

SWEP.Zoom = 0


function SWEP:Initialize()	
self:SetWeaponHoldType( self.HoldType )		
end

function SWEP:PrimaryAttack()		
	local bullet = {}	-- Set up the shot
	if ( !self:CanPrimaryAttack() ) then return end
				if (self.Zoom == 2 || self:Clip1() < 1 ) then
						self:ShootBullet( 65, 1, 0.003 )
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.3 )
		self:EmitSound(Sound("weapons/sg550/sg550-1.wav"))
		self:TakePrimaryAmmo( 1 )
        self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		
			self.Owner:MuzzleFlash()										
	self.Owner:ViewPunch(Angle( -2, 0, 0, 0 ))
		else
					if (self.Zoom == 1 || self:Clip1() < 1 ) then
		self:ShootBullet( 65, 1, 0.003 )
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.3 )
		self:EmitSound(Sound("weapons/sg550/sg550-1.wav"))
		self:TakePrimaryAmmo( 1 )
        self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			self.Owner:MuzzleFlash()										
	self.Owner:ViewPunch(Angle( -2, 0, 0, 0 ))
		else
					if (self.Zoom == 0 || self:Clip1() < 1 ) then
		self:ShootBullet( 65, 1, 0.2 )
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.3 )
		self:EmitSound(Sound("weapons/sg550/sg550-1.wav"))
		if (self.Owner:IsPlayer()) then -- I have enough of these NPCs trying to shoot even if the gun is empty.
			self:TakePrimaryAmmo( 1 )
		end
        self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			self.Owner:MuzzleFlash()	
	if (self.Owner:IsPlayer()) then						
		self.Owner:ViewPunch(Angle( -2, 0, 0, 0 ))
	end
		end
	self.Owner:MuzzleFlash()										
	self.Owner:ViewPunch(Angle( -1, 0, 0, 0 ))
	end
end
end
function SWEP:SecondaryAttack()

	        if(self.Zoom == 0) then
			self.Owner:DrawViewModel(false)
        self.Owner:SetFOV( 50, 0.1 )
		self:EmitSound("weapons/zoom.wav")
self.Owner:ConCommand( "pp_mat_overlay overlays/scope_lens.vmt");
self.DrawCrosshair = true
				self.Zoom = 1
				self.Owner:SetWalkSpeed(100)
				self.Owner:SetRunSpeed( 100 )
				self.Owner:SetNWBool( "Scoped", true )
						
		self:NextThink( CurTime() + self:SequenceDuration() )
	else
		if(self.Zoom == 2) then
		self.Owner:DrawViewModel(true)
        self.Owner:SetFOV( 0, 0.1)
		self.Owner:ConCommand("pp_mat_overlay \"\"");
		self.Owner:ConCommand( "");
		self:EmitSound("weapons/zoom.wav")
		self.Owner:SetWalkSpeed(200)
		self.Owner:SetRunSpeed( 400 )
		self.Owner:SetNWBool( "Scoped", false )
						self.DrawCrosshair = false
				self.Zoom = 0

						
		self:NextThink( CurTime() + self:SequenceDuration() )
		else
			        if(self.Zoom == 1) then
					self.Owner:DrawViewModel(false)
					self.Owner:SetWalkSpeed(100)
					self.Owner:SetRunSpeed( 100 )
					self.Owner:SetNWBool( "Scoped", true )
        self.Owner:SetFOV( 30, 0.1 )
		self:EmitSound("weapons/zoom.wav")
		self.Owner:ConCommand( "pp_mat_overlay overlays/scope_lens.vmt");
				self.DrawCrosshair = true
				self.Zoom = 2
		self:NextThink( CurTime() + self:SequenceDuration() )
			end
		end
	end
end

function SWEP:AdjustMouseSensitivity()
if self.Owner:GetNWBool( "Scoped", true ) then
	return 0.3
	else
		if  (self.Owner:GetNWBool( "Scoped" ) == false) then
	return 1
	end
end
end

function SWEP:DoDrawCrosshair( x, y )
if self.Owner:GetNWBool( "Scoped", true ) then
 	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawOutlinedRect( x - 3200, y - 1, 6000, 1 )
		surface.DrawOutlinedRect( x - 1, y - 3200, 1, 6000 )
		return true
		else
		if  (self.Owner:GetNWBool( "Scoped" ) == false) then
		surface.SetDrawColor( 0, 0, 0, 0 )
	surface.DrawOutlinedRect( x - 3200, y - 1, 6000, 1 )
		surface.DrawOutlinedRect( x - 1, y - 3200, 1, 6000 )
	return true
end
end
end


function SWEP:Reload()		
 if ( self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
	self:DefaultReload(ACT_VM_RELOAD)
	        self.Owner:SetFOV( 0, 0.1)
					self.Owner:DrawViewModel(true)
			self.Owner:ConCommand("pp_mat_overlay \"\"");
							self.Zoom = 0
							self.Owner:SetNWBool( "Scoped", false )
							self.Owner:SetWalkSpeed(200)
							self.Owner:SetRunSpeed( 400 )
							return true
							else
	return true
end
end

function SWEP:Deploy()				
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
				self.Zoom = 0
						self.Owner:DrawViewModel(true)
	//self.Reloadaftershoot = CurTime() + 1
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	--self.Owner:ConCommand("pp_mat_overlay \"\"");

	return true
end

function SWEP:Holster()	
	        self.Owner:SetFOV( 0, 0.1)
							self.Zoom = 0	
							self.Owner:SetWalkSpeed(200)
							self.Owner:SetNWBool( "Scoped", false )
							self.Owner:SetRunSpeed( 400 )
self.Owner:ConCommand("pp_mat_overlay \"\"");							
	return true
end


function SWEP:Think()
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
		else
			if self.Primary.Cone > 0.015 then
				self.Primary.Cone	= self.Primary.Cone - 0.0004
			end			
end			
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

	return 0.5, 0.65

end

function SWEP:GetNPCBurstSettings()

	-- Burst parameters
	-- 1st var is minimal burst number, 2nd var is maximal, 3rd var is the delay between each shots.
	-- The delay between each shots if weapon is automatic

	return 1, 1, self.Primary.Delay

end

function SWEP:GetNPCBulletSpread( proficiency )

	-- Determine the accuracy of the NPC holding the weapon. (We call that the Proficiency)
	-- The lower the var, the more accurate the NPC is. (Var in degrees)

	return 0

end