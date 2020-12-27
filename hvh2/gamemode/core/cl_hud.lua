/*
	
	hvh: redux v2
	by 0xymoron
	
	hud stuff
	
*/

local ply = LocalPlayer()
local scrw, scrh = ScrW(), ScrH()

local gradient_up = Material( "vgui/gradient_up" )
local gradient_down = Material( "vgui/gradient_down" )
local gradient_right = Material( "vgui/gradient-r" )
local gradient_left = Material( "vgui/gradient-l" )

local wide = scrw * 0.25
local tall = 20

surface.CreateFont( "hvh_hud", {

	font = "Arial",
	size = ScreenScale( 6 ),
	antialias = true

} )

local _R = debug.getregistry()

local hide = {

	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudCrosshair"] = true,
	["CHudSecondaryAmmo"] = true,

}

function GM:HUDShouldDraw( element )

	if hide[element] then return false end
	
	return true
	
end

function GM:HUDDrawTargetID()
end

hook.Add( "HUDPaint", "hvh_HUD", function()
	
	if ply == nil or !IsValid( ply ) then
		
		ply = LocalPlayer() // i still don't know why the fuck this happens but whatever

	end
	
	if !_R.Player.Alive( ply ) then return end
	
	// health
	local health = _R.Entity.Health( ply )
	local maxhealth = _R.Entity.GetMaxHealth( ply )
	local health_percent = ( health / maxhealth )
	local health_wide = wide * ( health_percent )
	
	draw.RoundedBox( 0, 0, scrh - tall, wide, tall, Color( 0, 0, 0, 125 ) )
	
	draw.RoundedBox( 0, 0, scrh - tall, health_wide, tall, Color( 255, 0, 0 ) )
	
	surface.SetMaterial( gradient_up )
	
	surface.SetDrawColor( Color( 200, 0, 0 ) )
	
	surface.DrawTexturedRect( 0, scrh - tall, health_wide, tall )
	
	surface.SetDrawColor( Color( 0, 0, 0, 200 ) )
	
	surface.DrawOutlinedRect( 0, scrh - tall, wide, tall )
	
	if health_wide >= 15 then
	
		draw.SimpleTextOutlined( health, "hvh_hud", health_wide - 5, scrh - ( tall / 2 ), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, color_black )
		
	end
	
	// ammo
	local wep = _R.Player.GetActiveWeapon( ply )
	if !wep or !IsValid( wep ) then return end
	
	local clip = _R.Weapon.Clip1( wep )
	local maxclip = _R.Weapon.GetMaxClip1( wep )
	local clip_percent = ( clip / maxclip )
	local clip_wide = wide * ( clip_percent )
	
	draw.RoundedBox( 0, scrw - wide, scrh - tall, wide, tall, Color( 0, 0, 0, 125 ) )
	
	draw.RoundedBox( 0, scrw - clip_wide, scrh - tall, clip_wide, tall, Color( 255, 255, 0 ) )
	
	surface.SetMaterial( gradient_up )
	
	surface.SetDrawColor( Color( 200, 200, 0 ) )
	
	surface.DrawTexturedRect( scrw - clip_wide, scrh - tall, clip_wide, tall )
	
	surface.SetDrawColor( Color( 0, 0, 0, 200 ) )
	
	surface.DrawOutlinedRect( scrw - wide, scrh - tall, wide, tall )
	
	if clip_wide >= 15 then
	
		draw.SimpleTextOutlined( clip, "hvh_hud", scrw - clip_wide + 5, scrh - ( tall / 2 ), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black )
		
	end
	
end )