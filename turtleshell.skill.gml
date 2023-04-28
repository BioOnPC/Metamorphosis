#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "TURTLE SHELL";
#define skill_text    return "ENEMIES DEAL LESS DAMAGE";
#define skill_tip     return "DON'T GET FLIPPED OVER";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_type    return "defensive";
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}
	
#define step
    with(enemy) {
    	if(variable_instance_exists(self, "meleedamage") and meleedamage > 1 and 
    	 ((variable_instance_exists(self, "turtledamage") and turtledamage > meleedamage) or !variable_instance_exists(self, "turtledamage"))) {
    		meleedamage -= min(meleedamage - 1, skill_get(mod_current));
    		turtledamage = meleedamage;
    	}
    }
    
    with(projectile) {
    	if(instance_exists(creator) and creator.object_index != Player and variable_instance_exists(self, "damage") and damage > 1 and 
    	 ((variable_instance_exists(self, "turtledamage") and turtledamage > damage) or !variable_instance_exists(self, "turtledamage"))) {
    		damage -= min(damage - 1, skill_get(mod_current));
    		turtledamage = damage;
    	}
    }