
-- this line needs to be present - due to the way this script file is loaded by the main script it
-- does not have access to the global script environment. This line gives it access.
setfenv(1, _G.script_env);


-------------------------------------------------------
--	Intro cutscene construction
--	This function declares and configures the cutscene 
--	and loads it with actions.
--	Customise it to suit.
-------------------------------------------------------

function cutscene_intro_construct()

	cutscene_intro = campaign_cutscene:new(
		local_faction .. "_intro",							-- string name for this cutscene
		24,													-- length of cutscene in seconds
		function() start_faction() end						-- end callback
	);

	--cutscene_intro:set_debug();
	cutscene_intro:set_skip_camera(cam_start_x, cam_start_y, cam_start_h, cam_start_r);

	cutscene_intro:action(
		function() 
			cm:scroll_camera_with_direction(
				3, 
				{cam_start_x, cam_start_y, 1, cam_start_r}, 
				{cam_start_x, cam_start_y, cam_start_h, cam_start_r}
			) 
		end, 
		0
	);
	
	cutscene_intro:action(function() show_advice("8001_TWRII_Emperor_Faction_Intro_Alexander_1_Thread") end, 0.5);

                cutscene_intro:action(function() cm:make_region_visible_in_shroud("rom_macedon_alex", "emp_mesopotamia_ctesiphon") end, 3);
	
	cutscene_intro:action(
		function() 
			cm:scroll_camera_with_direction(
				3,  
				{cam_start_x, cam_start_y, cam_start_h, cam_start_r},
				{444.534454, 237.354965, cam_start_h, cam_start_r}
			) 
		end, 
		3
	);
	
	
	cutscene_intro:action(
		function() 
			cm:scroll_camera_with_direction(
				2,  
				{444.534454, 237.354965, cam_start_h, cam_start_r},
				{444.534454, 237.354965, cam_start_h, 0.15}
			) 
		end, 
		6
	);
	
	cutscene_intro:action(
		function() 
			cm:scroll_camera_with_direction(
				8.5,  
				{444.534454, 237.354965, cam_start_h, 0.15},
				{445.87146, 264.370972, cam_start_h, cam_start_r},
				{468.599487, 253.56456, cam_start_h, cam_start_r},
				{489.990662, 193.357452, cam_start_h, cam_start_r}
			) 
		end, 
		8
	);
	
	
	cutscene_intro:action(
		function() 
			cm:scroll_camera_with_direction(
				3,  
				{489.990662, 193.357452, cam_start_h, cam_start_r},
				{489.990662, 193.357452, cam_start_h, 0.15}
			) 
		end, 
		16.5
	);
	
	
	cutscene_intro:action(
		function() 
			cm:scroll_camera_with_direction(
				2.5,  
				{489.990662, 193.357452, cam_start_h, 0.15},
				{321.535461, 301.421509, cam_start_h, cam_start_r}
			) 
		end, 
		19.5
	);
	
	
	
	cutscene_intro:action(
		function() 
			cm:scroll_camera_with_direction(
				2,  
				{321.535461, 301.421509, cam_start_h, cam_start_r},
				{321.535461, 301.421509, cam_start_h, 0.15}
			) 
		end, 
		22
	);
	
	cutscene_intro:action(function() cm:make_region_visible_in_shroud("rom_macedon_alex", "emp_thracia_pulpudeva") end, 3);
	cutscene_intro:action(function() cm:make_region_visible_in_shroud("rom_macedon_alex", "emp_thracia_odessos") end, 3);
	cutscene_intro:action(function() cm:make_region_visible_in_shroud("rom_macedon_alex", "emp_thracia_antheia") end, 3);

	
	cutscene_intro:action(
		function() 
			cm:scroll_camera_with_direction(
				5,  
				{321.535461, 301.421509, cam_start_h, 0.15},
				{cam_start_x, cam_start_y, cam_start_h, cam_start_r}
			) 
		end, 
		24
	);
	
	
	
		
end;


-------------------------------------------------------
--	Construct and then start the cutscene
-------------------------------------------------------

function cutscene_intro_play()
	cutscene_intro_construct();
	cutscene_intro:start();
end;

