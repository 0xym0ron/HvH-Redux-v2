/*
	
	hvh: redux v2
	by 0xymoron

	not another annoying ass round based hvh
	
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "lib.lua" )
AddCSLuaFile( "config.lua" )
include( "shared.lua" )
include( "lib.lua" )
include( "config.lua" )

local folder = GM.FolderName .. "/gamemode/"
local files, dirs = file.Find( folder .. "*", "LUA" )

for k, v in SortedPairs( dirs, true ) do
	
	conMsg( Color( 255, 0, 0 ), v )
	
	local lua = file.Find( folder .. "/" .. v .. "/sh_*.lua", "LUA" )
	for x, y in SortedPairs( lua, true ) do
		
		AddCSLuaFile( folder .. v .. "/" .. y )
		include( folder .. v .. "/" .. y )
		
		conMsg( color_white, "└─" .. y )
	
	end
	
	local lua = file.Find( folder .. "/" .. v .. "/sv_*.lua", "LUA" )
	for x, y in SortedPairs( lua, true ) do
		
		include( folder .. v .. "/" .. y )
		
		conMsg( color_white, "└─" .. y )
	
	end
	
	local lua = file.Find( folder .. "/" .. v .. "/cl_*.lua", "LUA" )
	for x, y in SortedPairs( lua, true ) do
		
		AddCSLuaFile( folder .. v .. "/" .. y )

		conMsg( color_white, "└─" .. y )
	
	end
	
end

hook.Add( "OnGamemodeLoaded", "GAMEMODE_LOADED", function()

	resource.AddWorkshop( "2312774455" ) // content pack
	
	local map = game.GetMap()
	
	local id = HVH_CONFIG.Maps[map]
	
	if !id then 
		
		conMsg( color_white, "Unable to find ",
		Color( 255, 0, 0 ), map,
		color_white, " Workshop ID! Check your config.lua" )
	
		return 
		
	end
	
	resource.AddWorkshop( id )
	
	conMsg( color_white, "added ",
	Color( 255, 0, 0 ), map .. " (" .. id .. ") ",
	color_white, "to download queue" )	
	
	conMsg( color_white, "loaded " )
	
end )

if GAMEMODE_LOADED then
	hook.Call( "OnGamemodeLoaded" )
end
GAMEMODE_LOADED = true