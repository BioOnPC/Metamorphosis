#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "RESURRECTION";
#define skill_text    return "@rREVIVE@s AT THE COST OF @gLEVELS";
#define skill_tip     return "FOUL NECROMANCY";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take    if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) sound_play(sndBasicUltra);
#define skill_ultra   return "skeleton";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(instances_matching_le(Player, "my_health", 0)) {
		if(race = "skeleton" or array_length(instances_matching(Player, "race", "skeleton")) = 0) {
			if(!skill_get(mut_strong_spirit) or canspirit = false) {
				with(instances_matching_gt(GameCont, "level", 1)) {
					other.my_health = 1; // Make sure the player is still alive
					
					mutindex--;
					level--; // Decrease level
					if(rad > (level * 20)) rad = level * 20; // Reduce rads appropriately
					
					 // EFFECTS
					sleep(300);
					view_shake_at(x, y, 30);
					instance_create(other.x, other.y, TangleKill);
					sound_play_pitch(sndHorrorPortal, 0.4);
					sound_play(sndUncurse);
					sound_play(sndMutant14Chst);
					
					var _mod = mod_get_names("skill"),
				        _scrt = "skill_ultra",
				        _ultras = [];
				    
				     // Go through and find all custom ultra skills
				    for(var i = 0; i < array_length(_mod); i++){ 
				    	if(skill_get(_mod[i]) and mod_script_exists("skill", _mod[i], _scrt)) array_push(_ultras, _mod[i]);
				    }
				    
					var cur_mut = "";
					var rev_mut = "";
					for(var m = mutindex; m > -array_length(_ultras); m--) {
						 // it only goes as low as -4 to account for weird cases where u have all custom ultras, which dont increment mutindex
						cur_mut = string(skill_get_at(m));
						if(rev_mut = "" and cur_mut != "undefined" and (!mod_exists("skill", cur_mut) or !mod_script_exists("skill", cur_mut, "skill_ultra"))) {
							rev_mut = cur_mut;
							skill_set(skill_get_at(m), 0);
						}
					}
				}
			}
		}
	}

