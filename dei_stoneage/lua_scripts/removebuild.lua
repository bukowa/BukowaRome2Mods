module(..., package.seeall);
_G.main_env = getfenv(1);

local scripting = require "lua_scripts.EpisodicScripting"

function LogBukowa(text, isTitle, isNew)
    -- log function is taken from DEI mod
    local isLogAllowed = true;
	if not isLogAllowed then return end

	local logfile;
	text = tostring(text);
	if isNew then
		logfile = io.open("bukowa.txt","w");
		local curr_date = os.date("%A, %m %B %Y");
		local text = tostring("- Bukowa Log\n".."- "..curr_date);
		logfile:write(text.."\n\n");
	else
		logfile = io.open("bukowa.txt","a");
		if not logfile then logfile = io.open("bukowa.txt","w") end
	end

	if isTitle then
		local title_text = "*************************************************************************\n";
		text = "\n"..title_text..text.."\n"..title_text;
	end

	logfile:write(text.."\n");
	logfile:close();
end

function remove_all_military_buildings_for_all_factions()
    local faction_list = scripting.game_interface:model():world():faction_list()
    for i = 0, faction_list:num_items() - 1 do

        local faction = faction_list:item_at(i)
        local region_list = faction:region_list()
        for j = 0, region_list:num_items() - 1 do
            local region = region_list:item_at(j)  -- Added missing assignment for region
            for slots = 0, region:slot_list():num_items() - 1 do
                local slot = region:slot_list():item_at(slots)
                if slot:has_building() then
					scripting.game_interface:instantly_dismantle_building(tostring(region:name())..":"..tostring(slots))
                end
            end
        end
    end
end

function pcall_remove_all_military_buildings_for_all_factions()
	local success, message = pcall(remove_all_military_buildings_for_all_factions)
	if not success then
		LogBukowa("Error in remove_all_military_buildings_for_all_factions: "..message)
	end
end

scripting.AddEventCallBack("NewCampaignStarted", pcall_remove_all_military_buildings_for_all_factions)

LogBukowa("Starting...");
