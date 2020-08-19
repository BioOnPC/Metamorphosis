#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "BREACH & CLEAR";
#define skill_text    return "@wFASTER RELOAD@s WHILE ROLLING";
#define skill_tip     return "IS THIS LEGAL?";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define skill_ultra   return "fish";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(instances_matching_gt(Player, "roll", 0)) { // just make you shoot faster when ur rolling idk
		if(reload > 0) reload -= (skill_get(mut_throne_butt) ? 0.4 * skill_get(mut_throne_butt) : 0.8); // you shoot faster without thronebutt to make up for the length of the roll
	}

