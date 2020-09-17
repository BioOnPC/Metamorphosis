#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "CAMOFLAUGE";
#define skill_text    return "@wENEMIES ACT SLOWER@s";
#define skill_tip     return "HARD TO PIN DOWN";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut);
#define step
    if((floor(current_frame) mod (2 * (room_speed/30))) = 0) {
    	with(instances_matching_gt(enemy, "alarm1", current_time_scale)) {
    		alarm1++;
    	}
    }
    