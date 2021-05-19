#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra"   + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sndSkillSlct = sound_add("../sounds/Ultras/sndUlt" + string_upper(string(mod_current)) + ".ogg");
	
	global.diff = 0;
	
#define skill_name    return "CRITICAL MASS";
#define skill_text    return "@gRESELECT YOUR MUTATIONS@s#RESELECT AGAIN @wLATER";
#define skill_tip     return "ENTROPY UNDONE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_ultra   return "horror";
#define skill_avail   return false;

#define skill_take(_num)
	var _last = variable_instance_get(GameCont, `skill_last_${mod_current}`, 0);
	variable_instance_set(GameCont, `skill_last_${mod_current}`, _num);
	
	 // Out of Patience:
	skill_set_active(mut_patience, (_num == 0));
	
	 // Reroll Mutations:
	skill_reset(_num - _last);
	
	 // Sound:
	if(_num > 0 && instance_exists(LevCont)){
		sound_play(sndBasicUltra);
		sound_play(global.sndSkillSlct);
	}
	
	 // unknown:
	with(GameCont) global.diff = hard;
	
#define skill_lose
	skill_take(0);
	
#define skill_reset(_addMuts)
	/*
		Rerolls all non-special mutations, plus adds a given number of mutation points
	*/
	
	 // Clear Non-Special Mutations:
	for(var i = 0; !is_undefined(skill_get_at(i)); i++){
		var _skill = skill_get_at(i);
		if(skill_get_active(_skill)){
			if(
				!is_string(_skill)
				|| !mod_script_exists("skill", _skill, "skill_avail")
				|| mod_script_call("skill", _skill, "skill_avail")
			){
				skill_set(_skill, false);
				GameCont.skillpoints++;
				i--;
			}
		}
	}
	GameCont.mutindex = 0;
	
	 // +Mutation+:
	GameCont.skillpoints += _addMuts;
	
	//mod_variable_set("mod", "metamorphosis", "criticalmass_diff", GameCont.hard);