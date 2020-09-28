#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "HUGE GAINS";
#define skill_text    return "WEAPONS THAT @ySHARE AMMO TYPES@s#SHARE THE @wFASTEST COOLDOWN";
#define skill_tip     return "INCORRECT CALCULATIONS";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndBasicUltra);
#define skill_ultra   return "steroids";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(Player) {
		if(wep != wep_none and bwep != wep_none and weapon_get_type(wep) = weapon_get_type(bwep)) {
			if(weapon_get_load(wep) > weapon_get_load(bwep) and reload > 0) 	  reload -= (floor(weapon_get_load(wep)/weapon_get_load(bwep)) - reloadspeed) * current_time_scale;
			else if(weapon_get_load(bwep) > weapon_get_load(wep) and breload > 0) breload -= (floor(weapon_get_load(bwep)/weapon_get_load(wep)) - reloadspeed) * current_time_scale;
		}
	}