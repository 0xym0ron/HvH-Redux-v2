/*
	
	hvh: redux v2
	by 0xymoron
	
	settings, loadout, menu, etc.
	lets try to avoid using the net library
	cus you dumbasses love to spam it
	
*/

if SERVER then

	function GM:ShowSpare2( ply )
	
		ply:ConCommand( "hvh_menu" )
	
	end
	
	function GM:ShowSpare1( ply )
	
		ply:ConCommand( "hvh_menu" )
		
	end
	
	function GM:ShowTeam( ply )
	
		ply:ConCommand( "hvh_menu" )
		
	end
	
	function GM:ShowHelp( ply )
	
		ply:ConCommand( "hvh_menu" )
		
	end

end

if CLIENT then
	
	local frame = nil
	
	local gradient_up = Material( "vgui/gradient_up" )
	local gradient_down = Material( "vgui/gradient_down" )
	local gradient_r = Material( "vgui/gradient-r" )
	
	local main = HVH_CONFIG.Colors.main
	local main_dark = HVH_CONFIG.Colors.main_dark
	
	local scrw, scrh = ScrW(), ScrH()
	
	local blur = Material( "pp/blurscreen" )
	local function drawBlur( panel, amount, col )

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
	
	local function hvh_menu()
		
		frame = vgui.Create( "DFrame" )
		frame:SetSize( 300, 300 )
		frame:Center()
		frame:MakePopup()
		frame:SetTitle( "" )
		frame:ShowCloseButton( false )
		
		frame.Paint = function( self, w, h )
			
			drawBlur( self, 6, Color( 0, 0, 0, 255 ) )
			
			draw.RoundedBox( 0, 0, 0, w, h , Color( 0, 0, 0, 200 ) )
			
		end

		local sheet = vgui.Create( "DPropertySheet", frame )
		sheet:SetPos( 0, 0 )
		sheet:SetSize( frame:GetWide(), frame:GetTall() )
		
		sheet.Paint = function( self, w, h )
		
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
			
			draw.RoundedBox( 0, 0, 0, w, 28, main_dark )
			
			draw.SimpleTextOutlined( "HvH Redux v2", "ChatFont", w - 10, 12, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, color_black )
			
		end
		
		// loadout
		local loadout_sheet = vgui.Create( "DScrollPanel", sheet )
		loadout_sheet:Dock( FILL )
		loadout_sheet.Paint = function( self, w, h ) end
		loadout_sheet:GetVBar():SetWide( 0 )
		
		local primary = loadout_sheet:Add( "DCollapsibleCategory" )
		primary:SetLabel( "Primary" )
		primary:Dock( TOP )
		primary:SetExpanded( 1 )
		primary.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, 20, main_dark ) end
		
		local primary_list = vgui.Create( "DIconLayout", primary )
		primary_list:Dock( FILL )
		primary_list:SetSpaceX( 5 )
		primary_list:SetSpaceY( 5 )
		primary_list.Paint = function( self, w, h ) end	
		
		primary:SetContents( primary_list )
	
		for wep, v in SortedPairs( HVH_CONFIG.AllowedWeapons.primary ) do

			local model = primary_list:Add( "SpawnIcon" )
			model:SetSize( 71, 71 )
			model:SetModel( v.mdl )
			model:SetToolTip()
			
			model.DoClick = function( self )
			
				chat.AddText( main, "hvh | ", color_white, "Set primary weapon to " .. wep )
				
				GetConVar( "hvh_primary" ):SetString( wep )
			
			end
			
			model.PaintOver = function( self, w, h )
			
				draw.SimpleText( v.name, "ChatFont", w / 2, h - 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
			
			end
			
		end
		
		local secondary = loadout_sheet:Add( "DCollapsibleCategory" )
		secondary:SetLabel( "Secondary" )
		secondary:Dock( TOP )
		secondary:SetExpanded( 1 )
		secondary.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, 20, main_dark ) end
		
		local secondary_list = vgui.Create( "DIconLayout", secondary )
		secondary_list:Dock( FILL )
		secondary_list:SetSpaceX( 5 )
		secondary_list:SetSpaceY( 5 )
		secondary_list.Paint = function( self, w, h ) end	
		
		secondary:SetContents( secondary_list )
	
		for wep, v in SortedPairs( HVH_CONFIG.AllowedWeapons.secondary ) do

			local model = secondary_list:Add( "SpawnIcon" )
			model:SetSize( 71, 71 )
			model:SetModel( v.mdl )
			model:SetToolTip()
			
			model.DoClick = function( self )
			
				chat.AddText( main, "hvh | ", color_white, "Set secondary weapon to " .. wep )
				
				GetConVar( "hvh_secondary" ):SetString( wep )
			
			end
			
			model.PaintOver = function( self, w, h )
			
				draw.SimpleText( v.name, "ChatFont", w / 2, h - 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM )
			
			end
			
		end

		// model selection
		local model_sheet = vgui.Create( "DScrollPanel", sheet )
		model_sheet:Dock( FILL )
		model_sheet:SetSize( frame:GetWide() - 10, frame:GetTall() - 10 ) 
		model_sheet.Paint = function( self, w, h ) end		
		model_sheet:GetVBar():SetWide( 0 )
		
		local models = vgui.Create( "DIconLayout", model_sheet )
		models:Dock( FILL )
		models:SetSpaceX( 5 )
		models:SetSpaceY( 5 )
		models.Paint = function( self, w, h ) end
		
		for i = 1, #HVH_CONFIG.AllowedModels do
			
			local mdl = HVH_CONFIG.AllowedModels[i]
		
			local model = models:Add( "SpawnIcon" )
			model:SetSize( 71, 71 )
			model:SetModel( mdl )
			model:SetToolTip()
			
			model.PaintOver = function( self, w, h ) end
			
			model.DoClick = function( self )
			
				chat.AddText( main, "hvh | ", color_white, "Set player model to " .. mdl )
			
				GetConVar( "hvh_playermodel" ):SetString( mdl )
			
			end
			
		end
		
		// settings
		local settings_sheet = vgui.Create( "DScrollPanel", sheet )
		settings_sheet:Dock( FILL )
		settings_sheet.Paint = function( self, w, h ) end
		settings_sheet:GetVBar():SetWide( 0 )
		
		local quakesounds = vgui.Create( "DCheckBoxLabel", settings_sheet )
		quakesounds:SetPos( 5, 5 )
		quakesounds:SetText( "Enable Quake Sounds" )
		quakesounds:SetConVar( "hvh_quakesounds" )
		quakesounds:SizeToContents()
		
		local headshotsounds = vgui.Create( "DCheckBoxLabel", settings_sheet )
		headshotsounds:SetPos( 5, 25 )
		headshotsounds:SetText( "Enable Headshot Sound" )
		headshotsounds:SetConVar( "hvh_quakesounds_headshot" )
		headshotsounds:SizeToContents()

		local quaketype_label = vgui.Create( "DLabel", settings_sheet )
		quaketype_label:SetText( "Quake Sounds Type" )
		quaketype_label:SetFont( "ChatFont" )
		quaketype_label:SetPos( 155, 5 )
		quaketype_label:SizeToContents()
		
		local quaketype = vgui.Create( "DComboBox", settings_sheet )
		quaketype:SetPos( 160, 25 )
		quaketype:SetSize( 130, 20 )
		quaketype:SetValue( GetConVarString( "hvh_quakesounds_type" ) )
		quaketype:AddChoice( "male" )
		quaketype:AddChoice( "female" )
		quaketype.OnSelect = function( self, index, value )
			GetConVar( "hvh_quakesounds_type" ):SetString( value )
			chat.AddText( main, "hvh | ", color_white, "Set quake sounds to " .. value )
		end
		
		sheet:AddSheet( "Loadout", loadout_sheet )
		sheet:AddSheet( "Model", model_sheet )
		sheet:AddSheet( "Settings", settings_sheet )
		
		for k, v in next, sheet.Items do
			
			v.Tab:SetTextColor( color_black )
			
			v.Tab.Paint = function( self, w, h )
				
				draw.RoundedBox( 0, 0, 0, w, h, main )
				
				surface.SetDrawColor( main_dark )
				
				surface.SetMaterial( gradient_up )
				
				surface.DrawTexturedRect( 0, 0, w, h )
				
				surface.SetDrawColor( Color( 0, 0, 0, 50 ) )
				
				surface.DrawOutlinedRect( 0, 0, w, h )
			
			end
			
		end
		
		frame.OnKeyCodePressed = function( self, key )
		
			local keys = { KEY_F1, KEY_F2, KEY_F3, KEY_F4 } // bruh
			
			if table.HasValue( keys, key ) then
			
				self:Close()
				
			end
		
		end
		
		frame.OnClose = function( self )
		
			frame = nil
		
		end
		
	end
	
	concommand.Add( "hvh_menu", hvh_menu )

end