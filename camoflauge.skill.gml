#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "CAMOUFLAGE";
#define skill_text    return "@wENEMIES@s ACT @wSLOWER";
#define skill_tip     return "HARD TO PIN DOWN";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) sound_play(sndMut);
#define step
    if((current_frame % 2) < current_time_scale) {
    	with(instances_matching_gt(enemy, "alarm1", current_time_scale)) {
    		if(object_index != Van) alarm1++;
    	}
    	
    	with(instances_matching_gt(enemy, "alrm0", current_time_scale)) {
    		alrm0++;
    	}
    	
    	with(instances_matching_gt(enemy, "alrm1", current_time_scale)) {
    		alrm1++;
    	}
    }
    
    with(instances_matching(Player, "image_alpha", 1)) {
    	image_alpha -= 0.2;
    }
    
#define skill_lose
	with(Player) { image_alpha += 0.2; }