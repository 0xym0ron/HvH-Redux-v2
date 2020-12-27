/*
	
	hvh: redux v2
	by 0xymoron
	
	dev tools. ignore all this junk
	
*/

if SERVER then

end

if CLIENT then

	local positions = {}

	concommand.Add( "pos", function( ply ) // used to get spawn location vectors for config
		
		local pos = ply:GetPos()
		
		table.insert( positions, pos )
		
		MsgN( "\n\n\n\n\n" )
		
		for k, v in next, positions do
		
			MsgN( "Vector( " .. math.floor( v.x ) .. ", " .. math.floor( v.y ) .. ", " .. math.floor( v.z ) .. " )," )
		
		end
		
	end )

end