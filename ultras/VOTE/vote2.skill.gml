#define init
	global.sprSkillIcon = sprite_add("../../sprites/Icons/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../../sprites/HUD/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "ETHICAL CONSUMPTION";
#define skill_text    return "@wRELOADING@s A BULLET WEAPON#GIVES @yBULLET AMMO#@wAUTO-POP POP BULLET WEAPONS";
#define skill_tip     return "TEAR APART THIS ESTABLISHMENT";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(Player) {
		if(weapon_get_type(wep) = 1 and variable_instance_get(self, "consume_lstload") != reload) {
			if(reload <= reloadspeed and ammo[1] + ceil(weapon_get_cost(wep)/3) <= typ_amax[1]) {
				ammo[1] += ceil(weapon_get_cost(wep)/3);
				sound_play_pitchvol(sndImpWristKill, 1.4, 0.6);
				sound_play_pitchvol(sndRecGlandProc, 0.7, 0.6);
			}
			consume_lstload = reload;
		}
		
		if(race = "steroids" and weapon_get_type(bwep) = 1 and variable_instance_get(self, "consume_lstbload") != reload) {
			if(reload <= reloadspeed and ammo[1] + ceil(weapon_get_cost(bwep)/3) <= typ_amax[1]) {
				ammo[1] += ceil(weapon_get_cost(bwep)/3);
				sound_play_pitchvol(sndImpWristKill, 1.4, 0.6);
				sound_play_pitchvol(sndRecGlandProc, 0.7, 0.6);
			}
			consume_lstload = reload;
		}
	}

