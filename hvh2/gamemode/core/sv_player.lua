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

function GM:PlayerDisconnected( ply )
	
	if ply:IsBot() then return end
	
	if HVH_CONFIG.EnableBots then
		
		local players = player.GetAll()
		
		if table.Count( players ) == 1 then
		
			for i = 1, HVH_CONFIG.BotAmount do
			
				RunConsoleCommand( "bot" )
			
			end
		
		else
		
			for k, v in next, players do
			
				if v:IsBot() then v:Kick() end
			
			end
		
		end
		
	end

end

function GM:PlayerInitialSpawn( ply )
	
	// points
	if HVH_CONFIG.EnablePoints then
	
		local points = ply:GetPoints()
	
		ply:SetNWInt( "hvh_points", points ) 
		
	end
	
	// useful for working on cheats alone on the server, got sick of manually spawning them in.
	if HVH_CONFIG.EnableBots then
		
		local players = player.GetAll()
		
		if table.Count( players ) == 1 && !players[1]:IsBot() then
			
			for i = 1, HVH_CONFIG.BotAmount do
			
				RunConsoleCommand( "bot" )
			
			end
		
		elseif !ply:IsBot() then // dont want bots kicking themselves
		
			for k, v in next, players do
			
				if v:IsBot() then v:Kick() end
			
			end
		
		end
		
	end
	
	// bots dont call playerauth so this is goin here
	if ply:IsBot() then
	
		ply:SetTeam( config.SpecialPlayers["BOT"] )
		
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
	
	if spawns != nil then
	
		ply:SetPos( table.Random( spawns ) )

	end
		
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

function GM:PlayerDeath( victim, inflictor, attacker )
	
	if HVH_CONFIG.EnablePoints /*&& IsValid( victim ) && !victim:IsBot()*/ && IsValid( attacker ) && attacker:IsPlayer() then
		
		local hitgroup = victim:LastHitGroup()
		
		if hitgroup && hitgroup == HITGROUP_HEAD then
	
			attacker:AddPoints( HVH_CONFIG.Points["Headshot"] )
	
		else
		
			attacker:AddPoints( HVH_CONFIG.Points["Kill"] )
	
		end

		victim:AddPoints( HVH_CONFIG.Points["Death"] )
 	
	end

end

function GM:PlayerDeathThink( ply )

	if HVH_CONFIG.AutoRespawn && !ply:Alive() && ply.LastDeath != nil && ( ply.LastDeath + HVH_CONFIG.RespawnTime ) <= ( CurTime() ) then
		
		ply:Spawn()
		
	end

	return true
	
end

function GM:PlayerShouldTaunt( ply, act )
	
	return HVH_CONFIG.AllowTaunts

end