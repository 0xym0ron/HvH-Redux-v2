/*
	
	hvh: redux v2
	by 0xymoron

	player related stuff
	
*/

function GM:CheckPassword( id64, ip, sv_pass, cl_pass, name )
	
	local sid = util.SteamIDFrom64( id64 )
	
	if HVH_CONFIG.WhitelistEnabled then
	
		if !HVH_CONFIG.Whitelist[sid] then
			
			return false, HVH_CONFIG.WhitelistKickMessage
			
		end
		
	end

end

function GM:PlayerAuthed( ply, sid, uid )

	if HVH_CONFIG.SpecialPlayers[ply:SteamID()] then
		
		ply:SetTeam( HVH_CONFIG.SpecialPlayers[ply:SteamID()] )
		
	else
	
		ply:SetTeam( 1 )
		
	end

	ply.Killstreak = 0

end

function GM:PlayerInitialSpawn( ply )
	
	if ply:IsBot() then
	
		ply:SetTeam( 1 )
	
	end	
	
end

function GM:PlayerSpawn( ply )
	
	// player model
	local model = "models/player/corpse1.mdl"
	
	local c_model = ply:GetInfo( "hvh_playermodel" )
	
	if table.HasValue( HVH_CONFIG.AllowedModels, c_model ) then
		
		model = c_model
		
	end
	
	ply:SetModel( model )
	
	// spawn point
	local map = string.lower( game.GetMap() )
	
	local spawns = HVH_CONFIG.Spawns[map]
	
	ply:SetPos( table.Random( spawns ) )

	// ammo
	local ammo_amt = 9999
	
	for k, v in next, HVH_CONFIG.AmmoTypes do
	
		ply:GiveAmmo( ammo_amt, v )
	
	end
	
	// loadout
	local primary = "css_ak47"
	local secondary = "css_glock"

	local c_primary = ply:GetInfo( "hvh_primary" )
	local c_secondary = ply:GetInfo( "hvh_secondary" )
	
	if HVH_CONFIG.AllowedWeapons.primary[c_primary] != nil then
	
		primary = c_primary
		
	end
	
	if HVH_CONFIG.AllowedWeapons.secondary[c_secondary] != nil then
	
		secondary = c_secondary
	
	end
	
	ply:Give( primary )
	ply:Give( secondary )
	
	ply:SetupHands()
	
end

function GM:PlayerDeathThink( ply )

	if !ply:Alive() && ply.LastDeath != nil && ( ply.LastDeath + HVH_CONFIG.RespawnTime ) <= ( CurTime() ) then
		
		ply:Spawn()
		
	end

	return true
	
end