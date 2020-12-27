/*
	
	hvh: redux v2
	by 0xymoron

	not another annoying ass round based hvh
	
*/

if CLIENT then
	
	// lets create convars here for convenience (we're using convars so we don't have to use the net library)
	CreateClientConVar( "hvh_primary", "css_ak47", true, true, "Primary Weapon" ) // primary wep
	CreateClientConVar( "hvh_secondary", "css_glock", true, true, "Secondary Weapon" ) // secondary wep
	CreateClientConVar( "hvh_playermodel", "models/player/corpse1.mdl", true, true, "Player Model" )
	CreateClientConVar( "hvh_quakesounds", 1, true, true, "Enable Quake Sounds", 0, 1 ) // toggle quake sounds
	CreateClientConVar( "hvh_quakesounds_headshot", 0, true, true, "Enable Headshot Quake Sound", 0, 1 ) // toggle headshot quake sound (this shit can be annoying)
	CreateClientConVar( "hvh_quakesounds_type", "male", true, true, "Quake Sounds Type (male or female", 0, 1 ) // male/female quake sounds

end

local config = {}

config.RespawnTime = 1 // seconds between auto respawns

config.WhitelistEnabled = false // yeah, we may not want any of you dipshits playing this.
config.WhitelistKickMessage = "Whitelist Enabled\nGo away." // lol
config.Whitelist = {
	
	["STEAM_0:0:40143824"] = true, // 0xymoron

}

config.AllowedModels = { // allowed player models
	
	// special models
	"models/player/corpse1.mdl",

	// civillian females
	"models/player/Group01/female_01.mdl",
	"models/player/Group01/female_02.mdl",
	"models/player/Group01/female_03.mdl",
	"models/player/Group01/female_04.mdl",
	"models/player/Group01/female_05.mdl",
	"models/player/Group01/female_06.mdl",

	// civillian males
	"models/player/Group01/male_01.mdl",
	"models/player/Group01/male_02.mdl",
	"models/player/Group01/male_03.mdl",
	"models/player/Group01/male_04.mdl",
	"models/player/Group01/male_05.mdl",
	"models/player/Group01/male_06.mdl",
	"models/player/Group01/male_07.mdl",
	"models/player/Group01/male_08.mdl",
	"models/player/Group01/male_09.mdl",

	// hostages
	"models/player/hostage/hostage_01.mdl",
	"models/player/hostage/hostage_02.mdl",
	"models/player/hostage/hostage_03.mdl",
	"models/player/hostage/hostage_04.mdl",
	
	// css
	"models/player/arctic.mdl",
	"models/player/gasmask.mdl",
	"models/player/guerilla.mdl",
	"models/player/leet.mdl",
	"models/player/phoenix.mdl",
	"models/player/riot.mdl",
	"models/player/swat.mdl",
	"models/player/urban.mdl",
	
}

config.AllowedWeapons = { // weapons players can have in their loadout (and their spawnicon)

	primary = {
		
		["weapon_smg1"] = {
			name = "HL2 SMG",
			mdl = "models/weapons/w_smg1.mdl"
		},
		
		["css_ak47"] = {
			name = "AK47",
			mdl = "models/weapons/w_rif_ak47.mdl"
		},
		
		["css_m4a1"] = {
			name = "M4A1",
			mdl = "models/weapons/w_rif_m4a1.mdl"
		},
		
		["css_galil"] = {
			name = "Galil",
			mdl = "models/weapons/w_rif_galil.mdl"
		},
		
		["css_m249"] = {
			name = "M249",
			mdl = "models/weapons/w_mach_m249para.mdl"
		},
		
		["css_mac10"] = {
			name = "Mac-10",
			mdl = "models/weapons/w_smg_mac10.mdl"
		},
		
		["css_mp5"] = {
			name = "MP5",
			mdl = "models/weapons/w_smg_mp5.mdl"
		},
		
		["css_tmp"] = {
			name = "TMP",
			mdl = "models/weapons/w_smg_tmp.mdl"		
		},

	},
	
	secondary = {
		
		["css_57"] = { 
			name = "FiveSeven",
			mdl = "models/weapons/w_pist_fiveseven.mdl"
		},
		
		["css_deagle"] = {
			name = "Deagle",
			mdl = "models/weapons/w_pist_deagle.mdl"
		},
		
		["css_glock"] = {
			name = "Glock",
			mdl = "models/weapons/w_pist_glock18.mdl"
		},
		
		["css_p228"] = {
			name = "P228",
			mdl = "models/weapons/w_pist_p228.mdl"
		},
		
		["css_dualellites"] = {
			name = "Dual Elites",
			mdl = "models/weapons/w_pist_elite.mdl"
		},
	
	}

}

config.AmmoTypes = { // give player a bunch of these ammo types

	"pistol",
	"smg1",
	"AR2",
	"buckshot",

}

config.Teams = { // teams
	
	[1] = { name = "Cheater", col = Color( 145, 145, 145 ) },
	[2] = { name = "Juden", col = Color( 234, 177, 236 ) },
	[3] = { name = "the admen", col = Color( 245, 85, 85 ) },
	
}

config.SpecialPlayers = { // these people are special and get special teams :)
	
	["STEAM_0:0:40143824"] = 3,
	
}

config.Killicons = { // killicons - https://wiki.facepunch.com/gmod/CS:S_Kill_Icons
		
	["css_57"] = { font = "CSS", id = "u", color = Color( 255, 80, 0 ) },
	["css_ak47"] = { font = "CSS", id = "b", color = Color( 255, 80, 0 ) },
	["css_aug"] = { font = "CSS", id = "e", color = Color( 255, 80, 0 ) },
	["css_awp"] = { font = "CSS", id = "r", color = Color( 255, 80, 0 ) },
	["css_deagle"] = { font = "CSS", id = "f", color = Color( 255, 80, 0 ) },
	["css_dualellites"] = { font = "CSS", id = "s", color = Color( 255, 80, 0 ) },
	["css_famas"] = { font = "CSS", id = "t", color = Color( 255, 80, 0 ) },
	["css_g3sg1"] = { font = "CSS", id = "i", color = Color( 255, 80, 0 ) },
	["css_galil"] = { font = "CSS", id = "v", color = Color( 255, 80, 0 ) },
	["css_glock"] = { font = "CSS", id = "c", color = Color( 255, 80, 0 ) },
	["css_knife"] = { font = "CSS", id = "j", color = Color( 255, 80, 0 ) },
	["css_m3"] = { font = "CSS", id = "k", color = Color( 255, 80, 0 ) },
	["css_m4a1"] = { font = "CSS", id = "w", color = Color( 255, 80, 0 ) },
	["css_m249"] = { font = "CSS", id = "z", color = Color( 255, 80, 0 ) },
	["css_mac10"] = { font = "CSS", id = "l", color = Color( 255, 80, 0 ) },
	["css_mp5"] = { font = "CSS", id = "x", color = Color( 255, 80, 0 ) },
	["css_p90"] = { font = "CSS", id = "m", color = Color( 255, 80, 0 ) },
	["css_p228"] = { font = "CSS", id = "y", color = Color( 255, 80, 0 ) },
	["css_scout"] = { font = "CSS", id = "n", color = Color( 255, 80, 0 ) },
	["css_sg550"] = { font = "CSS", id = "o", color = Color( 255, 80, 0 ) },
	["css_sg552"] = { font = "CSS", id = "A", color = Color( 255, 80, 0 ) },
	["css_tmp"] = { font = "CSS", id = "d", color = Color( 255, 80, 0 ) },
	["css_ump45"] = { font = "CSS", id = "q", color = Color( 255, 80, 0 ) },
	["css_usp"] = { font = "CSS", id = "y", color = Color( 255, 80, 0 ) },
	["css_xm1014"] = { font = "CSS", id = "B", color = Color( 255, 80, 0 ) },
	
}

config.DamageModifications = { // hitgroup damage scale ---> damage = damage * value (https://wiki.facepunch.com/gmod/Enums/HITGROUP)

	[HITGROUP_HEAD] = math.huge, // lol
	[HITGROUP_CHEST] = 2,
	[HITGROUP_STOMACH] = 1,
	[HITGROUP_LEFTARM] = 1,
	[HITGROUP_RIGHTARM] = 1,
	[HITGROUP_LEFTLEG] = 1,
	[HITGROUP_RIGHTLEG] = 1,
	
	[HITGROUP_GEAR] = 0,
	[HITGROUP_GENERIC] = 1,

}

config.Killstreaks = { // killstreaks & sounds
	
	[3] = { sound = "multikill", str = "got a MULTIKILL" },
	[6] = { sound = "dominating", str = "is DOMINATING" },
	[10] = { sound = "killingspree", str = "is on a KILLING SPREE" },
	[15] = { sound = "rampage", str = "is on a RAMPAGE" },
	[20] = { sound = "godlike", str = "is GODLIKE" },
	[25] = { sound = "unstoppable", str = "is UNSTOPPABLE" },

}

config.QuakeSounds = { // quake sound paths
	
	male = {
		
		["headshot"] = "quake/male/headshot.mp3",
		["multikill"] = "quake/male/multikill.mp3",
		["dominating"] = "quake/male/dominating.mp3",
		["killingspree"] = "quake/male/killingspree.mp3",
		["rampage"] = "quake/male/rampage.mp3",
		["godlike"] = "quake/male/godlike.mp3",
		["holyshit"] = "quake/male/holyshit.mp3",
		["unstoppable"] = "quake/male/unstoppable.mp3",
		["humiliation"] = "quake/male/humiliation.mp3",
		
	},
	
	female = {
		
		["headshot"] = "quake/female/headshot.mp3",
		["multikill"] = "quake/female/multikill.mp3",
		["dominating"] = "quake/female/dominating.mp3",
		["killingspree"] = "quake/female/killingspree.mp3",
		["rampage"] = "quake/female/rampage.mp3",
		["godlike"] = "quake/female/godlike.mp3",
		["holyshit"] = "quake/female/holyshit.mp3",
		["unstoppable"] = "quake/female/unstoppable.mp3",
		["humiliation"] = "quake/female/humiliation.mp3",
		
	}
	
}

config.Maps = { // map name and their workshop id

	["hvh_ag_texture3"] = "2230836315",

}

config.Spawns = { // spawnpoints

	["hvh_ag_texture3"] = {

		Vector( -439, 1655, 1 ),
		Vector( -463, 1932, 1 ),
		Vector( 565, 1829, 1 ),
		Vector( 429, 1290, 1 ),
		Vector( 260, 968, 1 ),
		Vector( 257, 1799, 1 ),
		Vector( 255, 1510, 1 ),
		Vector( 516, 516, 1 ),
		Vector( 539, 133, 128 ),
		Vector( -204, 443, 1 ),
		Vector( -474, 453, 1 ),
		Vector( -760, 187, 1 ),
		Vector( -1252, 188, 1 ),
		Vector( -1261, 684, 1 ),
		Vector( -788, 714, 1 ),
		Vector( -814, 1038, 1 ),
		Vector( -866, 1381, 1 ),
		Vector( -745, 1789, 128 ),
		Vector( 272, 1781, 192 ),
		Vector( 257, 818, 192 ),
		Vector( -961, 401, 129 ),
		Vector( 260, 1928, 1 ),
		Vector( 257, 987, 1 ),
		Vector( 257, 1459, 1 ),
		Vector( -100, 1734, 1 ),
		Vector( -861, 1112, 1 ),
		Vector( -237, 545, 1 ),
		Vector( -248, 358, 1 ),
		Vector( -463, 355, 1 ),
		Vector( -461, 523, 1 ),
		Vector( -1090, 261, 1 ),
		Vector( -906, 773, 1 ),
		Vector( -860, 1280, 1 ),
		Vector( -902, 1468, 1 ),
		Vector( -922, 1797, 1 ),
		Vector( -659, 1937, 1 ),
		Vector( -669, 1679, 1 ),
		Vector( -604, 1927, 128 ),
		Vector( 513, 686, 1 ),
		Vector( 527, 1328, 1 ),
		Vector( 423, 1788, 1 ),

	},

}

config.Colors = { // just some colors for convenience

	main = Color( 255, 171, 0 ),
	main_dark = Color( 205, 125, 0 )

}

HVH_CONFIG = config