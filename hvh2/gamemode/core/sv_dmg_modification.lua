/*
	
	hvh: redux v2
	by 0xymoron
	
	change hitgroups to take different damage
	lets not make heads the only way to damage people
	hitscans are parts of cheats too, assholes.
	
	but yeah, head should be 1 shot kill
	
*/

function GM:ScalePlayerDamage( victim, hitgroup, dmginfo )
	
	local modifier = HVH_CONFIG.DamageModifications[hitgroup] or 1
	
	dmginfo:ScaleDamage( modifier )
	
	local attacker = dmginfo:GetAttacker()
		
	if IsValid( attacker ) && hitgroup == HITGROUP_HEAD then
		
		local players = player.GetAll()
		
		for i = 1, #players do
		
			local ply = players[i]
			
			local playsounds = ply:GetInfoNum( "hvh_quakesounds_headshot", 1 )
			
			if playsounds == 1 then
			
				local gender = string.lower( ply:GetInfo( "hvh_quakesounds_type" ) or "male" )
						
				if gender == nil or gender == "" or ( gender != "male" && gender != "female" ) then
						
					gender = "male"
							
				end
				
				net.Start( "hvh_playsound" )
				
					net.WriteString( HVH_CONFIG.QuakeSounds[gender]["headshot"] )
					
				net.Send( ply )

			end
			
		end
		
		//PrintMessage( HUD_PRINTCENTER, attacker:Nick() .. " got a HEADSHOT" )
			
	end
	
end