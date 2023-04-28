#define init
	global.sprSkillIcon 	= sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillIconHolo = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Holo.png", 1, 12, 16);
	global.sprSkillHUD  	= sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sndSkillSlct 	= sound_add("../sounds/Cursed/sndCurse" + string_upper(string(mod_current)) + ".ogg");

#macro cursecolor `@(color:${make_color_rgb(255, 202, 56)})`

#define skill_name    return cursecolor + "REPENTANCE";
#define skill_text    return "@wCLEANSE YOURSELF@s OF @pCURSE@s#TREAD THE @wSAFER PATH@s";
#define skill_tip     return "CLEANSE THYSELF";
#define skill_icon    return global.sprSkillHUD;
#define skill_type    return "cursed";
#define skill_button  
	sprite_index = global.sprSkillIcon;
	rephover = 0;
	curhover = 0;
	
	if(fork()) {
		while(instance_exists(self)) {
			wait 0;
			
			if(!instance_exists(self)) exit;
			
			curhover = 0;
			
			for(var r = 0; r < maxp; r++) {
				if(player_find(r) and point_in_rectangle(mouse_x[r], mouse_y[r], x - ceil(sprite_width/2), y - ceil(sprite_height/2), x + ceil(sprite_width/2), y + ceil(sprite_height/2))) {
					curhover = 1;
				}
			}
			
			if(curhover) rephover = lerp(rephover, 1, 0.40 * current_time_scale);
			else rephover = lerp(rephover, 0, 0.20 * current_time_scale);
			
			if(array_length(instances_matching(CustomDraw, "name", "REPDRAW")) = 0) with(script_bind_draw(rep_draw, depth - 1)) name = "REPDRAW";
		}
		
		exit;
	}

#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play_pitch(sndUncurse, 1.1);
		sound_play(sndBigCursedChest);
		sound_play(global.sndSkillSlct);
	}
	
	var _mod = mod_get_names("skill"),
        _scrt = "skill_cursed",
        _total = 0;
    
     // Go through and find all cursed mutations you have
    for(var i = 0; i < array_length(_mod); i++){ 
    	if(skill_get(_mod[i]) and mod_script_exists("skill", _mod[i], _scrt)) {
    		skill_set(_mod[i], 0);
    		_total++;
    	}
    }
    
    with(GameCont) {
    	level -= _total + (level = 10 ? 1 : 0);
    }
    
    with(Player) {
    	curse = 0;
    	bcurse = 1;
    }

#define skill_avail   return false;

#define step
	with(Player) {
		if((curse > 0 or bcurse > 0) and instance_exists(GameCont) and GameCont.subarea = 1) {
			curse--;
			bcurse--;
			sound_play_pitch(sndUncurse, 1.4 + random(0.4))
		}
	}
	
#define rep_draw
	with(instances_matching(SkillIcon, "skill", "repentance")) {
		draw_sprite_part(global.sprSkillIconHolo, 0, 0, sprite_height - (sprite_height * rephover), sprite_width, sprite_height, x - ceil(sprite_width/2), y - ceil(sprite_height/2));
	}
