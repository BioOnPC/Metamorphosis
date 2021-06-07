#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "ATOMIC PORES";
#define skill_text    return "@wENEMIES@s DROP MORE @gRADS#HIGHER @gRAD CAPACITY";
#define skill_tip     return "PUS FILLED";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}

#define step
    with(instances_matching(enemy, "atomicrads", null)) { // Find all unaffected enemies
        atomicrads = 1;
        raddrop += ceil(raddrop * (0.5 * skill_get(mod_current))); // Increase rads
    }

    with(instances_matching(instances_matching(GameCont, "level", 10), "atomicrads", null)) { // Check to see if the rad capacity was increased
    	atomicrads = 1;
    	radmaxextra += 200;
    }

     // VFX
    with(instances_matching(instances_matching_le(instances_matching_gt(enemy, "raddrop", 0), "my_health", 0), "atomicpores", null)) {
    	atomicpores = true;
    	
    	repeat(sprite_get_width(sprite_index)/12) {
	    	with(instance_create(x + random_range(-sprite_get_width(sprite_index)/2, sprite_get_width(sprite_index)/2),
	    					     y + random_range(-sprite_get_width(sprite_index)/2, sprite_get_width(sprite_index)/2),
	    					     ScorpionBulletHit)) { // I KNOW THIS LOOKS WEIRD BUT ITS EASIER TO READ
	    		image_speed = 0.3;
			}
    	}
    }
