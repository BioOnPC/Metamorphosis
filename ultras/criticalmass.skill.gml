#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "CRITICAL MASS";
#define skill_text    return "@gRESELECT YOUR MUTATIONS@s#RESELECT AGAIN @wLATER";
#define skill_tip     return "ENTROPY UNDONE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	sound_play(sndStatueCharge);
	
	 // The following is a bunch of stupid bullshit to make sure you don't lose your custom ultras
	var _mod = mod_get_names("skill"),
        _scrt = "skill_ultra",
        _ultras = {};
    
     // Go through and find all custom ultra skills
    for(var i = 0; i < array_length(_mod); i++){ 
    	if(skill_get(_mod[i]) and mod_script_exists("skill", _mod[i], _scrt)) lq_set(_ultras, _mod[i], skill_get(_mod[i]));
    }
    
	skill_clear(); // Remove all mutations
	skill_set_active(mut_patience, 0);
	GameCont.skillpoints += GameCont.mutindex + (skill_get("criticalmass") - 1); // Give you a buncha mutations! This actually gives you one more than normal, plus an additional one for how much skill_get(criticalmass) is over 1
	GameCont.mutindex = 0;
	mod_variable_set("mod", "metamorphosis", "criticalmass_diff", GameCont.hard);
	
	if(fork()) { // Basically, make sure the game has enough time to process between skill_clear and skill_set that the skills actually get set
		wait(0);
		 // Go through all of the skills found before and apply them
		for(i = 0; i < lq_size(_ultras); i++) {
			if(lq_get_key(_ultras, i) != "criticalmass") {
				skill_set(string(lq_get_key(_ultras, i)), lq_get_value(_ultras, i));
			}
		}
	}
	
	
	
#define skill_ultra   return "horror";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool