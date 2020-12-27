/*
	
	hvh: redux v2
	by 0xymoron
	
	teams n shit
	
*/

local teams = HVH_CONFIG.Teams

for i = 1, #teams do

	local t = teams[i]
		
	team.SetUp( i, t.name, t.col )
	
end