/*
	
	hvh: redux v2
	by 0xymoron
	
	a bunch of useful utility functions & boring nonsense
	
*/

local plyM = FindMetaTable( "Player" )
local entM = FindMetaTable( "Entity" )

/*
	
	random useful functions
	
*/

function conMsg( ... )
	
	MsgC( Color( 255, 0, 0 ), "hvh: redux | " )
	
	local args = { ... }
	
	local col = color_white
	local str = "nil"
	
	for i = 1, #args do

		if ( i % 2 == 0 ) then
			
			col = args[i-1]
			str = tostring( args[i] )

			if !IsColor( col ) then error( "Invalid color" ) return end
			if !isstring( str ) then error( "Invalid string" ) return end
			
			MsgC( col, str )
			
		end
	
	end
	
	MsgN()

end


if SERVER then

	util.AddNetworkString( "hvh_chat.AddText" )

	chat = {}
	
	function chat.AddText( ... )

	end

end

/*
	
	PData rewrite
	
*/

local format = Format
local sqlstr = SQLStr
local sqlite = sql

function plyM:GetPData( str, default )
	
	str = format( "%s[%s]", self:SteamID64(), str )
	
	local val = sqlite.QueryValue( "SELECT val FROM playerpdata WHERE str = " .. sqlstr( str ) .. " LIMIT 1" )

	return val or default
	
end

function plyM:SetPData( str, val )

	str = format( "%s[%s]", self:SteamID64(), str )
	
	return sqlite.Query( "REPLACE INTO playerpdata (str, val) VALUES (" .. sqlstr( str ) .. ", " .. sqlstr( val ) .. " )" ) != false
	
end

function plyM:RemovePData( str )

	str = format( "%s[%s]", self:SteamID64(), str )
	
	return sqlite.Query( "DELETE FROM playerpdata WHERE str = " .. sqlstr( str ) ) != false
	
end

function util.GetPData( sid, str, default )

	if string.find( str, "STEAM_" ) then

		sid = util.SteamIDTo64( sid )
	
	end
	
	if !sid or sid == "0" then 
	
		error( "util.GetPData SteamID invalid!", 1 )

		return
	
	end
	
	str = format( "%s[%s]", sid, str )
	
	local val = sqlite.QueryValue( "SELECT val FROM playerpdata WHERE str = " .. sqlstr( str ) .. " LIMIT 1" )

	return val or default	

end

function util.SetPData( sid, str, val )

	if string.find( str, "STEAM_" ) then

		sid = util.SteamIDTo64( sid )
	
	end
	
	if !sid or sid == "0" then 
	
		error( "util.SetPData SteamID invalid!", 1 )

		return
	
	end
	
	str = format( "%s[%s]", sid, str )
	
	return sqlite.Query( "REPLACE INTO playerpdata (str, val) VALUES (" .. sqlstr( str ) .. ", " .. sqlstr( val ) .. " )" ) != false

end

function util.RemovePData( sid, str )

	if string.find( str, "STEAM_" ) then

		sid = util.SteamIDTo64( sid )
	
	end
	
	if !sid or sid == "0" then 
	
		error( "util.SetPData SteamID invalid!", 1 )

		return
	
	end

	str = format( "%s[%s]", sid, str )
	
	return sqlite.Query( "DELETE FROM playerpdata WHERE str = " .. sqlstr( str ) ) != false
	
end