/*
	
	hvh: redux v2
	by 0xymoron

	not another annoying ass round based hvh
	
*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

AddCSLuaFile( "config.lua" )
include( "config.lua" )

AddCSLuaFile( "core/sh_util.lua" )
include( "core/sh_util.lua" )

AddCSLuaFile( "core/sh_points.lua" )
include( "core/sh_points.lua" )

AddCSLuaFile( "core/sh_teams.lua" )
include( "core/sh_teams.lua" )

include( "core/sv_player.lua" )

include( "core/sv_dmg_modification.lua" )

AddCSLuaFile( "core/cl_killicons.lua" )

AddCSLuaFile( "core/sh_killstreaks.lua" )
include( "core/sh_killstreaks.lua" )

AddCSLuaFile( "core/cl_scoreboard.lua" )
AddCSLuaFile( "core/cl_hud.lua" )

AddCSLuaFile( "core/sh_devtools.lua" )
include( "core/sh_devtools.lua" )

AddCSLuaFile( "core/sh_menu.lua" )
include( "core/sh_menu.lua" )

include( "plugins/sv_fakehit_impactfix.lua" )

resource.AddWorkshop( "2312774455" )

local map = game.GetMap()
resource.AddWorkshop( HVH_CONFIG.Maps[map] or "" )

conMsg( color_white, "loaded " )