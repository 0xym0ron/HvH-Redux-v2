AddCSLuaFile()
--[[
game.AddAmmoType({
	name = "75.Call"
})
]]
SWEP.Author				= "XmegaaAAa" -- Original Author : Hasster. Credits to him :)
SWEP.Purpose			= "That's a good gun. Why not."
SWEP.PrintName			= "USP"
SWEP.Slot				= 1
SWEP.SlotPos			= 3
SWEP.ViewModelFlip				= false -- Flip the model? Usally used for CS:S models
SWEP.ViewModelFOV		= 54
SWEP.IconLetter			= "x"
	
SWEP.Base = "weapon_base"
SWEP.Category 			= "Counter Strike: Source"
SWEP.PrintName = "USP"	
SWEP.ViewModel		= "models/weapons/cstrike/c_pist_usp.mdl"	
SWEP.WorldModel		= "models/weapons/w_pist_usp.mdl"
SWEP.UseHands = true
SWEP.ReloadSound		= "Weapon_SMG1.Reload"	
SWEP.HoldType		= "pistol"	
SWEP.CSMuzzleFlashes	= true		

SWEP.Weight		= 40		
SWEP.AutoSwitchTo		= true			
SWEP.Spawnable		= true		
	
SWEP.Primary.Sound			= Sound("weapons/usp/usp_unsil-1")
SWEP.Primary.UnsilSound	 	= Sound( "Weapon_AK47.Single" )
SWEP.Primary.SilSound	 	= Sound( "Weapon_AK47.Single" )
SWEP.Primary.Damage		= 18
SWEP.Primary.NumShots		= 0	
SWEP.Primary.Recoil			= 3			
SWEP.Primary.Cone			= 2.9		
SWEP.Primary.Delay			= 0.15
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false
SWEP.Primary.ClipSize		= 13		
SWEP.Primary.DefaultClip	= 72
SWEP.Primary.Force			= 3
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "Pistol"
		
SWEP.Secondary.ClipSize		= -1	
SWEP.Secondary.DefaultClip	                  = -1
SWEP.Secondary.Automatic	   = false
SWEP.Secondary.Ammo		= "none"	

SWEP.Zoom = 0	



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

				if (self.Zoom == 1) then
					self:EmitSound( Sound("weapons/usp/usp1.wav") )
					        self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
								self.Owner:MuzzleFlash()	
								self.Owner:SetAnimation( PLAYER_ATTACK1 )
							else
							if (self.Zoom == 0) then
												self:EmitSound( Sound("weapons/usp/usp_unsil-1.wav") )
					        self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
							self.Owner:SetAnimation( PLAYER_ATTACK1 )
end		
end		
		if (self.Owner:IsPlayer()) then			
			self.Owner:ViewPunch( Angle( -0.5 *self.Primary.Recoil,0, 0 ) )
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
	        if(self.Zoom == 0) then
			self.Weapon:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
				self.Zoom = 1
		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration())
		self:NextThink( CurTime() + self:SequenceDuration() )
	else
		if(self.Zoom == 1) then
			self.Weapon:SendWeaponAnim(ACT_VM_DETACH_SILENCER)
				self.Zoom = 0
		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration())
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
		if self.Owner:KeyDown( IN_FORWARD ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2.3
			else
			if self.Owner:KeyDown( IN_BACK ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 1.3
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 1.3
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 1.3
			else
			if self.Owner:KeyDown( IN_FORWARD ) and self.Owner:KeyDown( IN_DUCK ) and (IsValid(ground) or ground:IsWorld()) then
			self.Primary.Cone = 1.3
			else
			if self.Owner:KeyDown( IN_BACK ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2.3
			else
			if self.Owner:KeyDown( IN_MOVELEFT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2.3
			else
			if self.Owner:KeyDown( IN_MOVERIGHT ) and !self.Owner:KeyDown( IN_DUCK ) and (ground:IsWorld() or ground:IsWorld()) then
			self.Primary.Cone = 2.3
			else
			if self.Owner:KeyDown ( IN_DUCK ) and (IsValid(ground) or ground:IsWorld())  then
			self.Primary.Cone = 1
			else
			if !ground:IsWorld() or !ground:IsWorld() then
			self.Primary.Cone = 3.4
			else
			self.Primary.Cone = 1.7
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
	if(self.Zoom == 0) then
			self.Weapon:DefaultReload(ACT_VM_RELOAD)
                self.Zoom = 0
				end
		if(self.Zoom == 1) then
			self.Weapon:DefaultReload(ACT_VM_RELOAD_SILENCED)
	return true
end
end

function SWEP:Deploy()
			if (self.Zoom == 1) then
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
	else
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end

	//self.Reloadaftershoot = CurTime() + 1
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	return true
end

function SWEP:CSShootBullet( dmg, recoil, numbul, cone )

	numbul 	= numbul 	or 1
	cone 	= cone 		or 0.01

	local bullet = {}
	bullet.Num 		= numbul
	bullet.Src 		= self.Owner:GetShootPos()			// Source
	bullet.Dir 		= self.Owner:GetAimVector()			// Dir of bullet
	bullet.Spread 	= Vector( cone, cone, 0 )			// Aim Cone
	bullet.Tracer	= 4									// Show a tracer on every x bullets 
	bullet.Force	= 5									// Amount of force to give to phys objects
	bullet.Damage	= dmg
	
	self.Owner:FireBullets( bullet )
	
		if self.Weapon:Clip1() == 1 then
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			local Animation = self.Owner:GetViewModel()
			Animation:SetSequence(Animation:LookupSequence(self.LastShoot))
		else
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

		end
	self.Owner:SetAnimation( PLAYER_ATTACK1 )				// 3rd Person Animation
	
	if ( self.Owner:IsNPC() ) then return end
	
	// CUSTOM RECOIL !
	if ( (game.SinglePlayer() and SERVER) || ( !game.SinglePlayer() and CLIENT && IsFirstTimePredicted() ) ) then
	
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - 0.7
		self.Owner:SetEyeAngles( eyeang )
	
	end

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

	return 1, 5, 0.15

end

function SWEP:GetNPCBulletSpread( proficiency )

	-- Determine the accuracy of the NPC holding the weapon. (We call that the Proficiency)
	-- The lower the var, the more accurate the NPC is. (Var in degrees)

	return 1

end