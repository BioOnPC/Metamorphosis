#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "BREACH & CLEAR";
#define skill_text    return "@wFASTER RELOAD@s WHILE ROLLING";
#define skill_tip     return "IS THIS LEGAL?";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take    if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) sound_play(sndBasicUltra);
#define skill_ultra   return "fish";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(instances_matching_gt(Player, "roll", 0)) { // just make you shoot faster when ur rolling idk
		if(reload > 0) reload -= (skill_get(mut_throne_butt) ? 0.6 * skill_get(mut_throne_butt) : 1); // you shoot faster without thronebutt to make up for the length of the roll
		
		 // FAST EFFECTS
		if(speed > 0 and (current_frame mod (current_time_scale * 2)) = 0) { 
			with(instance_create(x - (hspeed * 2) + orandom(3), y - (vspeed * 2) + orandom(3), BoltTrail)) {
				creator = other; 
				image_angle = other.direction;
			    image_yscale = 1.4;
			    image_xscale = other.speed * 4;
			    image_blend = c_lime;
			    depth = other.depth;
			}
		}
	}

#define orandom(_num)                                            	    		return	mod_script_call_nc('mod', 'metamorphosis', 'orandom', _num);