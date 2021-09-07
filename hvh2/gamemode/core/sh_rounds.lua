/*
	
	hvh: redux v2
	by 0xymoron

	work in progress: round based mode support
	i always hated round based hvh but lots of people love it so here you go
	
*/

ROUND = ROUND or {}

local TEAM_T = 5
local TEAM_CT = 6

function team.GetTerrorists()
	
	return team.GetPlayers( TEAM_T )
	
end

function team.GetCounterTerrorists()

	return team.GetPlayers( TEAM_CT )

end

if SERVER then
	
	function ROUND.CheckStatus()
		
		if !HVH_CONFIG.RoundBased then return end
		
		local t_alive = 0
		local ct_alive = 0
		
		for k, v in next, team.GetTerrorists() do
		
			if !v:Alive() then continue end
			
			t_alive = t_alive + 1
		
		end

		for k, v in next, team.GetCounterTerrorists() do
		
			if !v:Alive() then continue end
			
			ct_alive = ct_alive + 1
		
		end		
		
		if t_alive == 0 && ct_alive >= 1 then
		
			ROUND.EndRound( TEAM_CT )
		
		elseif ct_alive == 0 && t_alive >= 1 then
		
			ROUND.EndRound( TEAM_T )
		
		end
	
	end
	
	function ROUND.StartRound()
		
		if !HVH_CONFIG.RoundBased then return end
		
	end
	
	function ROUND.EndRound( winner )
		
		if !HVH_CONFIG.RoundBased then return end
		
	end
	
end