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

function perform_action_on_all_factions()
    -- Get the faction list
    local faction_list = scripting.game_interface:model():world():faction_list()
    
    -- Randomize seed
    math.randomseed(os.time() + os.clock() * 1000);
    
    -- Store the factions in a table
    local factions_table = {}
    for i = 0, faction_list:num_items() - 1 do
        local faction = faction_list:item_at(i)
        table.insert(factions_table, faction)
    end

    -- Shuffle the factions table to randomize the order
    for i = #factions_table, 2, -1 do
        local j = math.random(i) -- Random index from 1 to i
        factions_table[i], factions_table[j] = factions_table[j], factions_table[i]
    end

    -- Iterate over the shuffled factions
    for _, faction in ipairs(factions_table) do
        -- Log the faction being processed
        LogBukowa("Processing faction: " .. tostring(faction:name()))

        -- Get the region list for the faction
        local region_list = faction:region_list()

        -- Shuffle the region list within the faction
        local regions_table = {}
        for j = 0, region_list:num_items() - 1 do
            local region = region_list:item_at(j)
            table.insert(regions_table, region)
        end

        -- Randomize seed
        math.randomseed(os.time() + os.clock() * 1000);
    
        -- Shuffle the regions table for random order
        for i = #regions_table, 2, -1 do
            local j = math.random(i)
            regions_table[i], regions_table[j] = regions_table[j], regions_table[i]
        end

        -- Iterate over the shuffled regions
        for _, region in ipairs(regions_table) do
            -- Check if the region has 3 or more buildings
            if region:num_buildings() >= 3 then
                LogBukowa("Region " .. region:name() .. " has " .. region:num_buildings() .. " buildings, performing action X on adjacent regions.")
                -- Perform action on adjacent regions
                perform_action_on_adjacent_regions(region)
                break
            else
                LogBukowa("Region " .. region:name() .. " has less than 3 buildings, skipping.")
            end
        end
    end
end

-- Define a local function within the current scope
function perform_action_on_adjacent_regions(region)
    -- Your action code here, e.g., logging and performing operations on adjacent regions
    LogBukowa("Performing action on adjacent regions for: " .. region:name())

    -- Get adjacent regions (you can add your logic here)
    local adjacent_region_list = region:adjacent_region_list()
    for i = 0, adjacent_region_list:num_items() - 1 do
        local adjacent_region = adjacent_region_list:item_at(i)
        LogBukowa("Adjacent region: " .. adjacent_region:name())
        -- Perform action on the adjacent region
        -- Action logic here
        handle_region_slots(adjacent_region)
    end
end

function handle_region_slots(region)
    -- Iterate over all slots in the region
    for slots = 0, region:slot_list():num_items() - 1 do
        local slot = region:slot_list():item_at(slots)

        -- Check if the slot has a building
        if slot:has_building() then
            -- Skip if it's a primary building
            if slot:type() == "primary" then
                -- Do nothing, continue to the next slot
            -- Skip if it's a port building
            elseif slot:type() == "port" then
                -- Do nothing, continue to the next slot
            -- Skip if it's a wonder building
            elseif slot:building():superchain() == "dei_wonder_superchain" then
                -- Do nothing, continue to the next slot
            else
                -- Perform the dismantle action if none of the conditions are met
                LogBukowa("Deleting building in" .. tostring(region:name()))
                scripting.game_interface:instantly_dismantle_building(tostring(region:name()) .. ":" .. tostring(slots))
            end
        end
    end
end


local function pcall_run()
	local success, message = pcall(perform_action_on_all_factions)
	if not success then
		LogBukowa("Error in perform_action_on_all_factions: "..message)
	end
end

scripting.AddEventCallBack("NewCampaignStarted", pcall_run)

LogBukowa("Started rrregions.lua");
