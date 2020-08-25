#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "MUSCLE MEMORY";
#define skill_text    return "DODGING @wBULLETS@s GIVES @gRADS@s";
#define skill_tip     return "SOLID PLAY";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define step
	if(instance_exists(Player)) {
	    with(projectile) {
	    	if(!variable_instance_exists(self, "musclememory")) musclememory = 0;
	    	
	    	var nplayer = instance_nearest(x, y, Player);
	    	if(!(nplayer.race = "frog" and object_index = ToxicGas) and object_index != Flame and object_index != TrapFire and team != nplayer.team) {
		    	if(point_distance(x, y, nplayer.x, nplayer.y) < (12 + (sprite_get_width(mask_index) * 0.5)) && musclememory = 0) {
		    		musclememory = 1;
		    		
		    		 // Stolen from defpack snipers. thank u karm and jsburg
		    		sound_play_pitch(sndSnowTankCooldown, 8);
					sound_play_pitchvol(sndShielderDeflect, 4, .5);
					sound_play_pitchvol(sndBigCursedChest, 20, .1);
					sound_play_pitchvol(sndCursedChest, 12, .2);
		    		with(instance_create(x + hspeed, y + vspeed, ChickenB)) image_speed = 0.8;
		    	}
		    	
		    	if(point_distance(x, y, nplayer.x, nplayer.y) > (12 + (sprite_get_width(mask_index) * 1.2)) && musclememory = 1 && nplayer.lsthealth = nplayer.my_health) {
		    		repeat((damage * (GameCont.level + GameCont.loops)) * skill_get("musclememory")) {
		    			instance_create(nplayer.x, nplayer.y, Rad);
		    			with(instance_create(nplayer.x + nplayer.hspeed, nplayer.y + nplayer.vspeed, ChickenB)) image_speed = 0.8;
		    		}
		    		
		    		sound_play_pitch(sndMenuLoadout, 0.8 + random(0.4));
		    		musclememory = 0;
		    	}
	    	}
	    }
	}