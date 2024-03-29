/*
	
	hvh: redux v2
	by 0xymoron
	
	killstreak sounds & shit like that
	
*/

if SERVER then

	util.AddNetworkString( "hvh_playsound" )
	
	hook.Add( "hvh_HandleKillstreak", "hvh_Killstreaks", function( victim, attacker, dmginfo )		

		if HVH_CONFIG.KillstreaksEnabled && IsValid( attacker ) && IsValid( victim ) then

			attacker.Killstreak = attacker.Killstreak + 1
			
			local killstreak = HVH_CONFIG.Killstreaks[attacker.Killstreak]
			
			if killstreak != nil then
				
				PrintMessage( HUD_PRINTCENTER, attacker:Nick() .. " " .. killstreak.str )
				
				conMsg( color_white, attacker:Nick() .. " ", Color( 255, 0, 0 ), killstreak.str )
				
				local players = player.GetAll()
				
				for i = 1, #players do

					local ply = players[i]
					
					if ply == nil or !IsValid( ply ) then continue end
					
					local playsound = ply:GetInfoNum( "hvh_quakesounds", 1 )
					
					if playsound == 1 then
					
						local gender = string.lower( ply:GetInfo( "hvh_quakesounds_type" ) or "male" )
						
						if gender == nil or gender == "" or ( gender != "male" && gender != "female" ) then // yes, there is only two.
						
							gender = "male"
							
						end
						
						local sound = HVH_CONFIG.QuakeSounds[gender][killstreak.sound] or ""

						net.Start( "hvh_playsound" )
						
							net.WriteString( sound )
							
						net.Send( ply )
						
					end
					
				end
			
			end
			
			victim.Killstreak = 0
			
		end
		
	end )
	
end

if CLIENT then
	
	net.Receive( "hvh_playsound", function( len )
	
		local snd = net.ReadString()
		
		surface.PlaySound( snd )
	
	end )
	
end