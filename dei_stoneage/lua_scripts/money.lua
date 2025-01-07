-- ************************************************************************
-- ************************************************************************
-- ************************************************************************
-- DIVIDE ET IMPERA
-- money script test
-- Author: Litharion
--
-- to use the script for any campaign add :   local money  = require "lua_scripts.money";
-- at the bottom to the respective scripting.lua
-- "--" are used to comment lines with "--" are not part of the script
-- ************************************************************************
-- ************************************************************************

-- ***************************************
-- General
--  a must have setup for all scripts
-- ***************************************

-- Make the script a module one
module(..., package.seeall);

-- Used to have the object library able to see the variables in this new environment
_G.main_env = getfenv(1);

-- Load libraries
scripting = require "lua_scripts.EpisodicScripting";

-- add factions which should get more money here
major_faction_list = {
			"emp_antony",
                                                "emp_octavian",
                                                "emp_lepidus",
                                                "emp_pompey",
                                                "dei_mith_pontus",
                                                "dei_mith_sulla",
                                                "dei_mith_marian",
					};
-- ************************************************************************
--
-- GENERAL FUNCTION
--
-- ************************************************************************

-- this function returns the current turn number, best way use it in a local (event) function by
-- local current_turn = Turn()
-- if current_turn ">=", "==", "<=", "<", ">" "~=" then do......
-- all functions actually need a call in a local function to return anything

function Turn()
	return scripting.game_interface:model():turn_number()
end

-- returns if an element is in a given list

 function contains( element, list )
	for _, v in ipairs(list) do
		if element == v then
		             return true;
		end
	end
	return false;
end
-- ************************************************************************
--
-- EVENTS FUNCTIONS
--
-- These are the functions that control the events in the game
-- there are different ways on how to add starting money to the AI
-- both can be combined so you can give all faction + 5k
-- and selected factions additional money
-- ************************************************************************

-- Example 1
-- simple solution for selected factions
local function AIMoneyScript_Rome(context)
 turn_num = Turn();
     if context:faction():name() == "rom_rome"
        and context:faction():is_human() == false
            then
                if turn_num == 1
                    then scripting.game_interface:treasury_mod("rom_rome", 10000)
-- This section shows how turn based money income is possible after starting money
          --     elseif turn_num > 1
         --          then scripting.game_interface:treasury_mod("rom_rome", 2000)
                end
        end
end

-- Example 2
-- simple solution for every faction at the start of their first turn
local function AIMoneyScript(context)
turn_num = Turn();
	if context:faction():name() == "pun_rome"
        and context:faction():is_human() == false
            then
                if turn_num == 1
                    then  scripting.game_interface:treasury_mod("pun_rome", 10000)
                elseif turn_num > 1
                    then scripting.game_interface:treasury_mod("pun_rome", 2000)
                end

    elseif context:faction():name() == "pun_carthage"
        and context:faction():is_human() == false
            then
                if turn_num == 1
                    then  scripting.game_interface:treasury_mod("pun_carthage", 10000)
                elseif turn_num > 1
                    then scripting.game_interface:treasury_mod("pun_carthage", 2000)
                end

    elseif context:faction():name() == "pel_korkyra"
        and context:faction():is_human() == false
            then
                if turn_num == 1
                    then  scripting.game_interface:treasury_mod("pel_korkyra", 10000)
                elseif turn_num > 1
                    then scripting.game_interface:treasury_mod("pel_korkyra", 3000)
                end

    elseif context:faction():name() == "pel_makedon"
        and context:faction():is_human() == false
            then
                if turn_num == 1
                    then  scripting.game_interface:treasury_mod("pel_makedon", 10000)
                elseif turn_num > 1
                    then scripting.game_interface:treasury_mod("pel_makedon", 3000)
                end

	 elseif context:faction():name() == "rom_rome"
		and context:faction():is_human() == false
            then
                if turn_num == 1
                    then  scripting.game_interface:treasury_mod("rom_rome", 12000)
                elseif turn_num > 1
                    then scripting.game_interface:treasury_mod("rom_rome", 2500)
                end

    elseif context:faction():name() == "rom_carthage"
		and context:faction():is_human() == false
            then
                if turn_num == 1
                    then  scripting.game_interface:treasury_mod("rom_carthage", 8000)
                elseif turn_num > 1
                    then scripting.game_interface:treasury_mod("rom_carthage", 2000)
                end

    elseif context:faction():name() == "rom_parthia"
		and context:faction():is_human() == false
            then
                if turn_num == 1
                   then  scripting.game_interface:treasury_mod("rom_parthia", 1000)
                elseif turn_num > 1
                   then scripting.game_interface:treasury_mod("rom_parthia", 500)
                end

    elseif context:faction():name() == "rom_epirus"
		and context:faction():is_human() == false
            then
                if turn_num == 1
                    then  scripting.game_interface:treasury_mod("rom_epirus", 2000)
                elseif turn_num > 1
                    then scripting.game_interface:treasury_mod("rom_epirus", 500)
                end

    elseif context:faction():name() == "rom_macedon"
		and context:faction():is_human() == false
            then
                if turn_num == 1
                    then  scripting.game_interface:treasury_mod("rom_macedon", 1000)
                elseif turn_num > 1
                    then scripting.game_interface:treasury_mod("rom_macedon", 500)
                end

    elseif context:faction():name() == "rom_seleucid"
		and context:faction():is_human() == false
            then
                if turn_num == 1
                    then  scripting.game_interface:treasury_mod("rom_seleucid", 2000)
                elseif turn_num > 1
                    then scripting.game_interface:treasury_mod("rom_seleucid", 500)
                end


    elseif context:faction():name() == "rom_ptolemaics"
		and context:faction():is_human() == false
            then
                if turn_num == 1
                    then  scripting.game_interface:treasury_mod("rom_ptolemaics", 2000)
                elseif turn_num > 1
                    then scripting.game_interface:treasury_mod("rom_ptolemaics", 500)
                end

    end
end

-- Example 3
-- using the major faction list above, simply add major faction names to the list with "Faction_name", they will recieve different income.
-- it is of course possible to further split the factions starting money by creating new lists and expanding the function
local function AIMoneyScript_full(context)
  local faction = context:faction():name()
  turn_num = Turn();
   if turn_num == 1
    and context:faction():is_human() == false
       then scripting.game_interface:treasury_mod(faction, 20000)
       elseif turn_num > 1
      and context:faction():is_human() == false
    and contains(faction,  major_faction_list)
        then scripting.game_interface:treasury_mod(faction, 1000)
    end
end
-- ************************************************************************
--
-- CALLBACKS
--
-- Fires the callbacks that controls when a certain event takes place
-- callbacks/events determine when the script triggers
-- OnFactionTurnStart triggers on every factions turn start
-- ************************************************************************
-- Example 1 is inactive
scripting.AddEventCallBack("FactionTurnStart", AIMoneyScript);
--scripting.AddEventCallBack("FactionTurnStart", AIMoneyScript_Rome);
scripting.AddEventCallBack("FactionTurnStart", AIMoneyScript_full);

-----------------------------------------
--------------------------AI BONUSES based on Imperium-------------------
------------------------------------------

function AIBonuses_Imperium(context)
  local faction = context:faction();
  local factionName = faction:name();
	if faction:is_human() == false and faction:region_list():num_items() > 0 then

scripting.game_interface:remove_effect_bundle("AI_Imperium_Bonus_6", factionName);
    scripting.game_interface:remove_effect_bundle("AI_Imperium_Bonus_5", factionName);
    scripting.game_interface:remove_effect_bundle("AI_Imperium_Bonus_4", factionName);
    scripting.game_interface:remove_effect_bundle("AI_Imperium_Bonus_3", factionName);
    scripting.game_interface:remove_effect_bundle("AI_Imperium_Bonus_2", factionName);
    scripting.game_interface:remove_effect_bundle("AI_Imperium_Bonus_1", factionName);


		-- check for faction emergency first
		if faction:treasury() < 1000 then
		  scripting.game_interface:treasury_mod(factionName, 20000);
		end;

		if context:faction():imperium_level() > 5 then
		  scripting.game_interface:treasury_mod(factionName, 15000);
		  scripting.game_interface:apply_effect_bundle("AI_Imperium_Bonus_6", factionName, 0);
		elseif context:faction():imperium_level() > 4 then
		  scripting.game_interface:treasury_mod(factionName, 10000);
		  scripting.game_interface:apply_effect_bundle("AI_Imperium_Bonus_5", factionName, 0);
		elseif context:faction():imperium_level() > 3 then
		  scripting.game_interface:treasury_mod(factionName, 8000);
		  scripting.game_interface:apply_effect_bundle("AI_Imperium_Bonus_4", factionName, 0);
		elseif context:faction():imperium_level() > 2 then
		  scripting.game_interface:treasury_mod(factionName, 6000);
		  scripting.game_interface:apply_effect_bundle("AI_Imperium_Bonus_3", factionName, 0);
		elseif context:faction():imperium_level() > 1 then
		  scripting.game_interface:treasury_mod(factionName, 3000);
		  scripting.game_interface:apply_effect_bundle("AI_Imperium_Bonus_2", factionName, 0);
		elseif context:faction():imperium_level() > 0 then
		  scripting.game_interface:treasury_mod(factionName, 1000);
		  scripting.game_interface:apply_effect_bundle("AI_Imperium_Bonus_1", factionName, 0);
		end;
	end;
end;

scripting.AddEventCallBack("FactionTurnStart", AIBonuses_Imperium);