#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#macro cursecolor `@(color:${make_color_rgb(255, 202, 56)})`

#define skill_name    return cursecolor + "REPENTANCE";
#define skill_text    return "@wCLEANSE YOURSELF@s OF @pCURSE@s#TREAD THE @wSAFER PATH@s";
#define skill_tip     return "CLEANSE THYSELF";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	sound_play(sndMut); //sound_mutation_play();
	sound_play_pitch(sndUncurse, 0.8);
	
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

#define skill_avail   
	var _mod = mod_get_names("skill"),
        _scrt = "skill_cursed",
        _cursed = [];
    
     // Go through and find all cursed mutations you have
    for(var i = 0; i < array_length(_mod); i++){ 
    	if(skill_get(_mod[i]) and mod_script_exists("skill", _mod[i], _scrt)) array_push(_cursed, _mod[i]);
    }

	return array_length(_cursed) >= 2 ? 1 : 0; // for metamorphosis

#define step
	with(Player) {
		if((curse > 0 or bcurse > 0) and instance_exists(GameCont) and GameCont.subarea = 1) {
			curse--;
			bcurse--;
			sound_play_pitch(sndUncurse, 1.4 + random(0.4))
		}
	}