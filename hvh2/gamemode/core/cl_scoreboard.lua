/*
	
	gClassic Scoreboard
	by 0xymoron
	
	This was designed for DarkRP/Sandbox/TTT but i'm gonna strip it down for hvh (for now) cus I like it.

*/	
	
local score = {}

local config = {}

local scrw, scrh = ScrW(), ScrH()

/*********************************

	You can modify stuff here
	
**********************************/

config.HeaderText = "Hack vs. Hack Redux v2" // header text

config.FooterText = { // add whatever to this table, it'll scroll through it on the footer

	"Currently playing on " .. game.GetMap(),
	"Hack vs. Hack: Redux v2 by 0xymoron",
	"No dick measuring",
	"Kill them with bullets",
	"I don't know what else to put here",

}

config.Size = { // scoreboard size, scrw is screen width, scrh is screen height

	wide = scrw * 0.6,
	tall = scrh * 0.7

}

config.ShowRanks = false // show user ranks on the scoreboard drop downs
config.ShowMoney = false // show user's wallet on the scoreboard drop down

config.Sounds = true // enable sounds for hovering & clicking scoreboard elements

config.Ranks = { // ranks that have access to the quick use commands in the scoreboard dropdowns
	
	["admin"] = true,
	["superadmin"] = true,
	["owner"] = true,
	
}

local colors = { // change these if you want

	["main"] = HVH_CONFIG.Colors.main, // main theme color
	["secondary"] = HVH_CONFIG.Colors.main_dark, // secondary theme color (probably should make this lighter than your main color)

	["black"] = Color( 15, 15, 15 ),
	["grey"] = Color( 145, 145, 145 ),
	["dark grey"] = Color( 85, 85, 85 ),
	["white"] = Color( 255, 255, 255 ),
	
	["red"] = Color( 255, 0, 0 ),
	["green"] = Color( 0, 255, 0 ),
	["blue"] = Color( 0, 0, 255 ),

}

/*****************************************

	Don't modify below this comment.
	
*****************************************/

config.FooterText = table.concat( config.FooterText, "                    " ) // don't say it.

local gradient_up = Material( "vgui/gradient_up" )
local gradient_down = Material( "vgui/gradient_down" )
local gradient_r = Material( "vgui/gradient-r" )

local function color( col, alpha ) // so we can continue to use the cached colors with different alphas. idk if this really helps performance but gmodstore says to do it so i guess
	
	col = colors[col]
	
	col.a = alpha
	
	return col

end

local blur = Material( "pp/blurscreen" )
local function drawBlur( panel, amount, col ) // shoutout to whoever made this function

    local x, y = panel:LocalToScreen( 0, 0 )
	
    surface.SetDrawColor( col.r, col.g, col.b, col.a )
    surface.SetMaterial( blur )

    for i = 1, 3 do
	
        blur:SetFloat( "$blur", ( i / 3 ) * ( amount or 6 ) )
        blur:Recompute()
		
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect( x * -1, y * -1, scrw, scrh )
		
    end
	
end

local function DrawScrollingText( text, font, col, x, y, texwide ) // yoinked from gmod_tool/cl_viewscreen.lua

	local w, h = surface.GetTextSize( text )
	w = w + 64
	
	x = RealTime() * 150 % w * -1

	while ( x < texwide ) do

		surface.SetTextColor( 0, 0, 0, 255 )
		surface.SetTextPos( x + 1.25, y + 1.25 )
		surface.SetFont( font )
		surface.DrawText( text )

		surface.SetTextColor( col )
		surface.SetTextPos( x, y )
		surface.SetFont( font )
		surface.DrawText( text )
			
		x = x + w

	end

end

local fonts = { 20, 22, 24, 60 }

for k, v in next, fonts do // lol

	surface.CreateFont( "Scoreboard_" .. v, {
	
		font = "coolvetica",
		size = v,
		weight = 400,
		antialias = true
	
	} )

end

local hovered = nil
local function addPlayerRow( panel, ply )
	
	local wide, tall = panel:GetWide(), 35
	
	local col = team.GetColor( ply:Team() )

	col.r = math.Clamp( col.r + 20, 0, 255 )
	col.g = math.Clamp( col.g + 20, 0, 255 )
	col.b = math.Clamp( col.b + 20, 0, 255 )

	local col_dark = table.Copy( col )
	col_dark.r = math.Clamp( col_dark.r - 50, 0, 255 )
	col_dark.g = math.Clamp( col_dark.g - 50, 0, 255 )
	col_dark.b = math.Clamp( col_dark.b - 50, 0, 255 )
	
	local row = panel:Add( "DCollapsibleCategory" )
	row:SetLabel( "" )
	row:Dock( TOP )
	row:DockMargin( 0, 0, 0, 3 )
	row:SetExpanded( 0 )
	row:SetWide( wide )
	row:SetHeaderHeight( tall )
	
	row.Think = function( self )
		
		self:DoExpansion( false )
		
		if !IsValid( ply ) or ply == nil then
		
			self:Remove()
			
		end
	
	end
	
	row:GetChildren()[1].Think = function( self )
	
		if self:IsHovered() && ( hovered != self or hovered == nil ) then
			
			if config.Sounds then
			
				surface.PlaySound( "UI/buttonrollover.wav" )
				
			end
			
			hovered = self
		
		end
		
	end

	row:GetChildren()[1].Paint = function( self, w, h )
		
		if !IsValid( ply ) or ply == nil then return end
		
		// bg
		draw.RoundedBox( 0, 0, 0, w, h, col )
		
		// gradient
		surface.SetMaterial( gradient_up )
		
		surface.SetDrawColor( col_dark )
		
		if !self:IsHovered() then

			surface.DrawTexturedRect( 0, 0, wide, tall )
		
		end
		
		// outline
		surface.DrawOutlinedRect( 0, 0, wide, tall )
		
		// name
		draw.SimpleText( ply:Nick(), "Scoreboard_22", 40, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

		// team
		draw.SimpleText( team.GetName( ply:Team() ), "Scoreboard_20", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
		
	end
	
	local mute = vgui.Create( "DButton", row )
	mute:SetSize( tall - 4, tall - 4 )
	mute:SetPos( ( row:GetWide() - mute:GetWide() ) - 2, 2 )
	mute:SetIcon( "icon16/sound.png" )
	mute:SetText( "" )
	
	mute.Think = function( self )
		
		if !IsValid( ply ) or ply == nil then return end
		
		if ply:IsMuted() then
		
			mute:SetIcon( "icon16/sound_mute.png" )
		
		else
		
			mute:SetIcon( "icon16/sound.png" )
		
		end
	
	end
	
	mute.Paint = function( self, w, h ) end
	
	mute.DoClick = function( self )
	
		ply:SetMuted( !ply:IsMuted() )
	
	end
	
	local avatar = vgui.Create( "AvatarImage", row )
	avatar:SetPos( 5, 5 )
	avatar:SetSize( tall - 10, tall - 10 )
	avatar:SetPlayer( ply )
	
	local avatar_button = vgui.Create( "DButton", avatar )
	avatar_button:SetSize( avatar:GetWide(), avatar:GetTall() )
	avatar_button:SetText( "" )
	
	avatar_button.Paint = function( self, w, h )
		
		local alpha = 75
		
		if self:IsHovered() then
			
			alpha = 0
		
		end

		draw.RoundedBox( 0, 0, 0, w, h, color( "black", alpha ) )
	
	end
	
	avatar_button.DoClick = function( self )
	
		ply:ShowProfile()
	
	end
	
end

local frame = nil

function score.Show()

	frame = vgui.Create( "DFrame" )
	frame:SetSize( config.Size.wide, config.Size.tall )
	frame:SetTitle( "" )
	frame:Center()
	frame:MakePopup()
	frame:ShowCloseButton( false )
	frame:SetDraggable( false )
	
	frame.Paint = function( self, w, h )
		
		drawBlur( self, 6, color( "black", 255 ) )
		
		// bg
		draw.RoundedBox( 0, 0, 0, w, h, color( "black", 235 ) )
		
	end
	
	frame.PaintOver = function( self, w, h )
		
		// outline
		surface.SetDrawColor( color( "black", 255 ) )
		
		surface.DrawOutlinedRect( 0, 0, w, h )
		
	end
	
	frame.Think = function( self ) if self:IsHovered() then hovered = nil end end // ignore me
	
	local header = vgui.Create( "DPanel", frame )
	header:SetPos( 0, 0 )
	header:SetSize( frame:GetWide(), 80 )
	
	header.Paint = function( self, w, h )
		
		// bg
		draw.RoundedBox( 0, 0, 0, w, h, color( "secondary", 255 ) )
		
		// top gradient
		surface.SetMaterial( gradient_down )
		
		surface.SetDrawColor( color( "main", 255 ) )
		
		surface.DrawTexturedRect( 0, 0, w, h )		
		
		// text
		draw.SimpleTextOutlined( config.HeaderText, "Scoreboard_60", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black )
		
		// seperator
		surface.SetDrawColor( color( "black", 255 ) )
	
		surface.DrawLine( 0, h - 1, w, h - 1 )
	
	end

	local footer = vgui.Create( "DPanel", frame )
	footer:SetSize( frame:GetWide(), 40 )
	footer:SetPos( 0, frame:GetTall() - footer:GetTall() )
	
	footer.Paint = function( self, w, h )
		
		// bg
		draw.RoundedBox( 0, 0, 0, w, h, color( "secondary", 255 ) )
		
		// gradient
		surface.SetMaterial( gradient_down )
		
		surface.SetDrawColor( color( "main", 255 ) )
		
		surface.DrawTexturedRect( 0, 0, w, h )
		
		// seperator
		surface.SetDrawColor( color( "black", 255 ) )
		
		surface.DrawLine( 0, 0, w, 0 )
		
		DrawScrollingText( config.FooterText, "Scoreboard_24", color_white, 0, h * 0.25, w )
		
	end
	
	local panel = vgui.Create( "DScrollPanel", frame )
	panel:SetPos( 5, header:GetTall() + 5 )
	panel:SetSize( frame:GetWide() - 10, frame:GetTall() - ( header:GetTall() + footer:GetTall() ) - 10 )
	
	panel.Paint = function( self, w, h )
		
	end
	
	panel:GetVBar():SetWide( 0 )
	
	panel.Think = function( self ) if self:IsHovered() then hovered = nil end end // ignore me
	
	local sort = player.GetAll()
	
	table.sort( sort, function( a, b )
	
		return a:Team() < b:Team()
		
	end )	
	
	for k, v in next, sort do
	
		addPlayerRow( panel, v )
	
	end
	
	return true // hide default scoreboard
	
end

function score.Hide()

	if frame != nil && ispanel( frame ) then
		
		frame:Close()
			
	end
	
end

hook.Add( "ScoreboardShow", "show da board", score.Show )
hook.Add( "ScoreboardHide", "hide da board", score.Hide )