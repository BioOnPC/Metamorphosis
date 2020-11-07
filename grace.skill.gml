#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "GRACE";
#define skill_text    return "DODGING @wBULLETS@s REDUCES @wRELOAD TIME";
#define skill_tip     return "SOLID PLAY";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut);
#define step
	if(instance_exists(Player)) {
	    with(projectile) {
	    	if(!variable_instance_exists(self, "grace")) grace = 0;
	    	
	    	var nplayer = instance_nearest(x, y, Player);
	    	if(!(nplayer.race = "frog" and object_index = ToxicGas) and object_index != Flame and object_index != TrapFire and team != nplayer.team) {
		    	if(point_distance(x, y, nplayer.x, nplayer.y) < (12 + (sprite_get_width(mask_index) * 0.75)) && grace = 0) {
		    		grace = 1;
		    		
		    		 // Stolen from defpack snipers. thank u karm and jsburg
		    		sound_play_pitch(sndSnowTankCooldown, 8);
					sound_play_pitchvol(sndShielderDeflect, 4, .5);
					sound_play_pitchvol(sndBigCursedChest, 20, .1);
					sound_play_pitchvol(sndCursedChest, 12, .2);
		    		with(instance_create(x + hspeed, y + vspeed, ChickenB)) image_speed = 0.8;
		    	}
		    	
		    	if(grace and nplayer.reload >= current_time_scale) {
		    		nplayer.reload -= current_time_scale * max(1 - (point_distance(x, y, nplayer.x, nplayer.y)/(12 + sprite_get_width(mask_index))), 0);
		    	}
		    	
		    	/*if(nplayer.reload > -(weapon_get_load(nplayer.wep)/2) and point_distance(x, y, nplayer.x, nplayer.y) > (12 + (sprite_get_width(mask_index) * 1.2)) && grace = 1 && nplayer.lsthealth = nplayer.my_health) {
		    		sound_play_pitch(sndMenuLoadout, 0.8 + random(0.4));
		    		nplayer.reload -= damage * 2;
		    		grace = 0;
		    	}*/
	    	}
	    }
	}