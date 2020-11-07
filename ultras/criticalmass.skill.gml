#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	
	global.diff = 0;

#define skill_name    return "CRITICAL MASS";
#define skill_text    return "@gRESELECT YOUR MUTATIONS@s#RESELECT AGAIN @wLATER";
#define skill_tip     return "ENTROPY UNDONE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take(_num)
	if(_num > 0 and array_length(instances_matching(SkillIcon, "skill", mod_current)) > 0) {
		sound_play(sndStatueCharge);
		skill_set_active(mut_patience, 0);
		with(GameCont) global.diff = hard;
		
		skill_reset(skill_get(mod_current));
	}
	
#define skill_ultra   return "horror";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool
#define skill_lose    skill_set_active(mut_patience, 1);

#define skill_reset(_addMuts)
	 // The following is a bunch of stupid bullshit to make sure you don't lose your custom ultras
	var _mod = mod_get_names("skill"),
        _scrt = "skill_ultra",
        _ultras = {};
    
     // Go through and find all custom ultra skills
    for(var i = 0; i < array_length(_mod); i++){ 
    	if(skill_get(_mod[i]) and mod_script_exists("skill", _mod[i], _scrt)) lq_set(_ultras, _mod[i], skill_get(_mod[i]));
    }
    
	GameCont.skillpoints += GameCont.mutindex + (_addMuts); // Give you a buncha mutations! This actually gives you one more than normal, plus an additional one for how much skill_get(criticalmass) is over 1
	GameCont.mutindex = 0;
	skill_clear(); // Remove all mutations
	
	//mod_variable_set("mod", "metamorphosis", "criticalmass_diff", GameCont.hard);
	
	if(fork()) { // Basically, make sure the game has enough time to process between skill_clear and skill_set that the skills actually get set
		wait(1);
		 // Go through all of the skills found before and apply them
		for(i = 0; i < lq_size(_ultras); i++) {
			skill_set(string(lq_get_key(_ultras, i)), lq_get_value(_ultras, i));
		}
		exit;
	}