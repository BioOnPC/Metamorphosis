#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	//global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "CROWN CRANIUM";
#define skill_text    return desc_decide();
#define skill_tip     return "HAIL TO THE KING";
//#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut);
#define skill_avail   
	with(instances_matching_gt(Player, "race_id", 16)) {
		if(race != "parrot" and !mod_script_exists("race", race, "race_ch_text")) {
			return 0;
		}
	}
	
	return 1;
	
#define step

#define desc_decide
	var t = ""; // base blank text
	
	with(Player) {
		if(instance_number(Player) > 1) t += string_upper(race_get_alias(race_id)) + " - ";
		switch(race) {
			case "fish":	 t += "@wCHESTS@s GIVE @wINFINITE AMMO@s"; break;
			case "crystal":  t += "@wPUSH ENEMIES AWAY@s AND#@wREFLECT PROJECTILES@s WHEN @rHURT@s"; break;
			case "eyes":     t += "CONSTANTLY ATTRACT @wDROPS@s"; break;
			case "melting":  t += "@wENEMIES@s EXPLODE INTO @gRADS@s"; break;
			case "plant":    t += "OCCASIONALLY SPAWN @wSAPLINGS@s#BASED ON @wSPEED@s"; break;
			case "venuz":    t += "THE HIGHER YOUR @wRELOAD TIME@s,#THE FASTER YOUR @wRELOAD SPEED@s"; break;
			case "steroids": t += "PORTALS GIVE @yAMMO@s"; break;
			case "robot":    t += "@wWEAPON DROPS@s ARE SOMETIMES @wDOUBLED@s"; break;
			case "chicken":  t += "REGAIN LOST MAX @rHP@s FROM @wALL CHESTS@s"; break;
			case "rebel":    t += "@rHEAL@s WHEN @wALLIES@s DIE"; break;
			case "horror":   t += ""; break;
			case "rogue":    t += ""; break;
			case "skeleton": t += ""; break;
			case "frog":     t += ""; break;
			case "parrot":   t += "@wPETS MOVE FASTER@s"; break;
			default: t += ""; break;
		}
		
		if(race_id > 16 and mod_script_exists("race", race, "race_ch_text")) t += mod_script_call("race", race, "race_ch_text");
		
		t += "#";
	}
	
	return t;