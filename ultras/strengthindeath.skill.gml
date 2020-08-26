#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "STRENGTH IN DEATH";
#define skill_text    return "@wHASTENED@S WHILE HEADLESS#AND AFTER EXITING A @pPORTAL";
#define skill_tip     return "THE HERO ALWAYS WINS";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define skill_ultra   return "chicken";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(Player) {
		if(!variable_instance_exists(self, "strengthtimer")) strengthtimer = 0;
		
		 // For when u are headless
		if(my_health = 0) {
			if(strengthtimer = 0) sleep(100);
			strengthtimer = 30;
		}
		
		 // While strength is active...
		if(strengthtimer > 0) {
			if(!variable_instance_exists(self, "strength_cur")) strength_cur = 0;
			if(strength_cur = 0) {
				reloadspeed += 0.6;
				maxspeed += 0.8;
				
				strength_cur++;
			}
			
			 // FAST EFFECTS
			if(speed > 0 and (current_frame mod (current_time_scale * 2)) = 0) { 
				with(instance_create(x - (hspeed * 2) + orandom(3), y - (vspeed * 2) + orandom(3), BoltTrail)) {
					creator = other; 
					image_angle = other.direction;
				    image_yscale = 1.4;
				    image_xscale = other.speed * 4;
				}
			}
			
			
			strengthtimer -= current_time_scale;
			
			 // Reset speeds
			if(strengthtimer <= 0) {
				strength_cur = 0;
				reloadspeed -= 0.6;
				maxspeed -= 0.8;
				
				sound_play_pitch(sndFishWarrantEnd, 1.4);
				sound_play_pitch(sndChickenThrow, 0.8);
			}
		}
		
		 // Just a safety measure
		if(strengthtimer < 0) strengthtimer = 0;
	}

#define orandom(_num)                                            	    		return	mod_script_call_nc('mod', 'metamorphosis', 'orandom', _num);