SWEP.base = "weapon_base"
SWEP.Category = "Counter Strike: Source"
SWEP.Author = "XmegaaAAa" -- Original Author : Hasster. Credits to him :)
SWEP.Purpose = "It's a knife, from CS:S. Yeah."
SWEP.PrintName = "Knife"
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.DrawCrosshair = false
SWEP.DrawAmmo = false
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_ct.mdl"
SWEP.ShowWorldModel = true
SWEP.ViewModelFOV = 59 -- 54 maybe? Or should I remake it to 63?
SWEP.UseHands = true
SWEP.HoldType = "knife"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Weight = 0;
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true
SWEP.FiresUnderwater = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Recoil = 1
SWEP.Primary.Spread = 0.1
SWEP.Primary.Delay = 0.5
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.TakeAmmo = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 5
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.TakeAmmo = 1

function SWEP:PrimaryAttack()
self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)

local trace = self.Owner:GetEyeTrace()
local tgt = trace.Entity

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 85 then
self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
        self.Owner:SetAnimation( PLAYER_ATTACK1 )
	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 5
	bullet.Damage = 20
   
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			        self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:FireBullets(bullet)
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
        self.Owner:SetAnimation( PLAYER_ATTACK1 );
    self.Owner:EmitSound("weapons/knife/knife_hitwall1.wav")
else
	self.Weapon:EmitSound("weapons/cbar_miss1.wav")
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
end
end

function SWEP:DrawHUD()
	local x, y

	x, y = ScrW() / 2.0, ScrH() / 2.0
	
	local scale = 20
	
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

function SWEP:SecondaryAttack()
self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)

local trace = self.Owner:GetEyeTrace()
local tgt = trace.Entity

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 85 then
			self.Weapon:SendWeaponAnim(ACT_VM_HITRIGHT)
	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 2
	bullet.Damage = 50
   
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER2)
        self.Owner:FireBullets(bullet)
    self.Owner:EmitSound("weapons/knife/knife_hit4.wav")
else
	self.Weapon:EmitSound("weapons/cbar_miss1.wav")
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
end
end

function SWEP:Deploy()
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

	//self.Reloadaftershoot = CurTime() + 1
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)

end 

function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
	return true
end

function SWEP:OnRemove()
end

function SWEP:PrimaryAttack()
	local trace = self.Owner:GetEyeTrace()
	local tgt = trace.Entity
	local e = EffectData()
self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
        self.Owner:SetAnimation( PLAYER_ATTACK1 )
self.Weapon:SetNextPrimaryFire(CurTime() + 0.6)
self.Weapon:SetNextSecondaryFire(CurTime() + 0.6)

local trace = self.Owner:GetEyeTrace()
local tgt = trace.Entity

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 85 then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			        self.Owner:SetAnimation( PLAYER_ATTACK1 )
	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 2
	bullet.Damage = 20
     if tgt:IsNPC() or  tgt:IsPlayer() and
 trace.HitPos:Distance(self.Owner:GetShootPos()) <= 85 then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			        self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:FireBullets(bullet)
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			        self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:SetAnimation( PLAYER_ATTACK1 );
	self.Weapon:EmitSound("weapons/knife/knife_hit"..math.random(1,4)..".wav")
	else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			        self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Owner:FireBullets(bullet)
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
        self.Owner:SetAnimation( PLAYER_ATTACK1 );
    self.Owner:EmitSound("weapons/knife/knife_hitwall1.wav")
		end
	else
	    self.Owner:EmitSound("weapons/knife/knife_slash"..math.random(1,2)..".wav")
				self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
	end
	end
	
    function SWEP:SecondaryAttack()
	local trace = self.Owner:GetEyeTrace()
	local tgt = trace.Entity
	local e = EffectData()
self.Weapon:SetNextPrimaryFire(CurTime() + 1.2)
self.Weapon:SetNextSecondaryFire(CurTime() + 1.2)

local trace = self.Owner:GetEyeTrace()
local tgt = trace.Entity

if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 85 then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			        self.Owner:SetAnimation( PLAYER_ATTACK1 )
	bullet = {}
	bullet.Num    = 1
	bullet.Src    = self.Owner:GetShootPos()
	bullet.Dir    = self.Owner:GetAimVector()
	bullet.Spread = Vector(0, 0, 0)
	bullet.Tracer = 0
	bullet.Force  = 10
	bullet.Damage = 80
     if tgt:IsNPC() and
 trace.HitPos:Distance(self.Owner:GetShootPos()) <= 85 then
        self.Owner:FireBullets(bullet)
	self.Weapon:EmitSound("weapons/knife/knife_stab.wav")
	else
        self.Owner:FireBullets(bullet)
    self.Owner:EmitSound("weapons/knife/knife_hitwall1.wav")
	end
	else
	    self.Owner:EmitSound("weapons/knife/knife_slash"..math.random(1,2)..".wav")
				self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
				        self.Owner:SetAnimation( PLAYER_ATTACK1 )
	end
	end
	
	function SWEP:DoImpactEffect( tr, nDamageType )
	util.Decal("ManhackCut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)	
	return true;
	
end

	