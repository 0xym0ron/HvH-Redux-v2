/*
	
	hvh: redux v2
	by 0xymoron
	
	functions for the point system
	
*/

local plyM = FindMetaTable( "Player" )

function plyM:GetPoints()

	if SERVER then
		
		return self:GetPData( "hvh_points", 0 )
		
	else
	
		return self:GetNWInt( "hvh_points", 0 )
	
	end

end

if SERVER then
	
	function plyM:SetPoints( int )

		self:SetPData( "hvh_points", int )
		
		self:SetNWInt( "hvh_points", int )
		
	end
	
	function plyM:AddPoints( int )
		
		if int == 0 then return end
		
		local points = self:GetPoints()
		
		points = math.Clamp( points + int, 0, math.huge )

		self:SetPoints( int )
		
	end
	
end