#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "RESURRECTION";
#define skill_text    return "@rREVIVE@s AT THE COST OF @gLEVELS";
#define skill_tip     return "FOUL NECROMANCY";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define skill_ultra   return "skeleton";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(instances_matching_le(instances_matching(Player, "race", "skeleton"), "my_health", 0)) {
		with(instances_matching_gt(GameCont, "level", 1)) {
			other.my_health = 1; // Make sure the player is still alive
			
			 // FOR NEW MODDERS: COMPLETELY FUCK OFF FROM THIS FILE. it is accursed and you will gain nothing but a headache from trying to glean how it works
			if(level < 10) { 
				for(findres = 1; findres <= mutindex; findres++) {
					if(skill_get_at(findres) = "resurrection") { 
						var last_mut = 0;
						for(findlast = findres; findlast >= 0; findlast--) {
							if((!mod_exists("skill", string(skill_get_at(findlast))) or !mod_script_exists("skill", string(skill_get_at(findlast)), "skill_ultra")) and !last_mut) {
								skill_set(skill_get_at(findlast), 0);
								last_mut = 1;
							}
						}
					}
				}
				mutindex--;
			}
			level--; // Decrease level
			if(rad > (level * 30)) rad = level * 30; // Reduce rads appropriately
			
			 // EFFECTS
			sleep(300);
			view_shake_at(x, y, 30);
			instance_create(other.x, other.y, TangleKill);
			sound_play_pitch(sndHorrorPortal, 0.4);
			sound_play(sndUncurse);
			sound_play(sndMutant14Chst);
		}
	}

