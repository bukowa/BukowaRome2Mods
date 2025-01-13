

-- this line needs to be present - due to the way this script file is loaded by the main script it
-- does not have access to the global script environment. This line gives it access.
setfenv(1, _G.script_env);


-------------------------------------------------------
--	Initial camera co-ords
--	Should ideally be used for the start/end points 
--	of the intro camera pan
-------------------------------------------------------

cam_start_x, cam_start_y = char_display_pos(get_faction_leader(scripting, local_faction));
cam_start_h = 0.8;
cam_start_r = 0;



-- include the intro cutscene script
local intro_script_file = local_faction .. "_intro";

require(intro_script_file)

if not pcall(function() require(intro_script_file) end) then
	script_error("WARNING: could not find intro script " .. tostring(intro_script_file));
end;


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--
--	FACTION SCRIPT
--
--	This script sets up the default start camera (for a multiplayer game) and
--	the intro cutscene/objective for a playable faction. The filename for this
--	script must match the name of the faction.
--
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

-------------------------------------------------------
--	Faction Start declaration/config
--	This object decides what to do when the faction
--	is initialised - do we play the cutscene, do we
--	position the camera at the start, or do we do
--	nothing, stuff like that.
-------------------------------------------------------

fs_player = faction_start:new(local_faction, cam_start_x, cam_start_y, cam_start_h, cam_start_r);

-- singleplayer initialisation
fs_player:register_intro_cutscene_callback(function() cutscene_intro_start() end);
fs_player:register_new_sp_game_callback(function() faction_new_sp_game_startup() end);
fs_player:register_each_sp_game_callback(function() faction_each_sp_game_startup() end);

-- multiplayer initialisation
fs_player:register_new_mp_game_callback(function() faction_new_mp_game_startup() end);
fs_player:register_each_mp_game_callback(function() faction_each_mp_game_startup() end);



-------------------------------------------------------
--	Intro Cutscene Playback
--	This function constructs and starts the
--	intro cutscene. The intro cutscene is generally
--	declared in the <faction_name>_intro.lua file
-------------------------------------------------------

function cutscene_intro_start()	
	if is_function(cutscene_intro_play) then
		output("Playing intro cutscene for " .. local_faction);
		cutscene_intro_play();
	else
		output("Didn't find an intro cutscene for " .. local_faction);
		start_faction();
	end;
end;



-------------------------------------------------------
--	This gets called each time the script restarts,
--	this could be at the start of a new game or
--	loading from a save-game (including coming back
--	from a campaign battle). Don't tamper with it.
-------------------------------------------------------

function start_game_for_faction(should_show_cutscene)
	output("start_game_for_faction() called");
	
	-- starts the playable faction script
	fs_player:start(should_show_cutscene);
end;



-------------------------------------------------------
--	This gets called only once - at the start of a 
--	new game. Initialise new game stuff for this 
--	faction here
-------------------------------------------------------

function faction_new_sp_game_startup()
	output("faction_new_sp_game_startup() called");
	
	-- put stuff here to be initialised on a new singleplayer game
end;


function faction_new_mp_game_startup()
	output("faction_new_mp_game_startup() called");
	
	-- put stuff here to be initialised on a new multiplayer game
end;



-------------------------------------------------------
--	This gets called any time the game loads in,
--	singleplayer including from a save game and 
--	from a campaign battle. Put stuff that needs
--	re-initialising each campaign load in here
-------------------------------------------------------

function faction_each_sp_game_startup()
	output("faction_each_sp_game_startup() called");
	
	-- put stuff here to be initialised each time a singleplayer game loads
end;


function faction_each_mp_game_startup()
	output("faction_each_mp_game_startup() called");
	
	-- put stuff here to be initialised each time a multiplayer game loads
end;


-------------------------------------------------------
--	This gets called after the intro cutscene ends,
--	Kick off any missions or similar scripts here
-------------------------------------------------------

function start_faction()
	output("start_faction() called");
	cm:trigger_custom_mission("rom_macedon_alex", "objective_emp_antony_1_primary1");
end;



