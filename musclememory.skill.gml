#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkillAtomicPoresIcon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkillAtomicPoresHUD.png",  1,  8,  8);

#define skill_name    return "MUSCLE MEMORY";
#define skill_text    return "DODGING @wBULLETS@s GIVES @gRADS@s";
#define skill_tip     return "SOLID PLAY";
//#define skill_icon    return global.sprSkillHUD;
//#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define step
    with(projectile) {
    	if(!variable_instance_exists(self, "musclememory")) musclememory = 0;
    	
    	var nplayer = instance_nearest(x, y, Player);
    	if(team != nplayer.team) {
	    	if(point_distance(x, y, nplayer.x, nplayer.y) < 20) {
	    		musclememory = 1;
	    	}
	    	
	    	if(point_distance(x, y, nplayer.x, nplayer.y) > 32 && musclememory = 1 && nplayer.lsthealth = nplayer.my_health) {
	    		repeat(damage * (1 + GameCont.loops)) {
	    			instance_create(nplayer.x, nplayer.y, Rad);
	    		}
	    		
	    		sound_play_pitch(sndMenuLoadout, 0.8 + random(0.4));
	    		musclememory = 0;
	    	}
    	}
    }