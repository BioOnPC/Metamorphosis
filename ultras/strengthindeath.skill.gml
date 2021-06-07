#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sndSkillSlct = sound_add("../sounds/Ultras/sndUlt" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "STRENGTH IN DEATH";
#define skill_text    return "@wHASTENED@S WHILE HEADLESS#AND AFTER EXITING A @pPORTAL";
#define skill_tip     return "THE HERO ALWAYS WINS";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndBasicUltra);
		sound_play(global.sndSkillSlct);
	}
#define skill_ultra   return "chicken";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(Player) {
		 // For when u are headless
		if(my_health = 0) {
			if(hastened = 0) sleep(100);
			haste(30, 0.8);
		}
	}

#define orandom(_num)                                            	    		return mod_script_call_nc('mod', 'metamorphosis', 'orandom', _num);
#define haste(amt, pow)                                            	    		return mod_script_call('mod', 'metamorphosis', 'haste', amt, pow);