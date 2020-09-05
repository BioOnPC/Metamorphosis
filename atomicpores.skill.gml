#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "ATOMIC PORES";
#define skill_text    return "@wENEMIES@s DROP MORE @gRADS#HIGHER @gRAD CAPACITY";
#define skill_tip     return "PUS FILLED";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut);
#define step
    with(instances_matching(enemy, "atomicrads", null)) { // Find all unaffected enemies
        atomicrads = 1;
        raddrop += ceil(raddrop * (0.10 * skill_get("atomicpores"))); // Increase rads
    }
    
    with(instances_matching(instances_matching(GameCont, "level", 10), "atomicrads", null)) { // Check to see if the rad capacity was increased
    	atomicrads = 1;
    	radmaxextra += 200;
    }
    
     // VFX
    with(instances_matching_le(enemy, "my_health", 0)) {
    	repeat(sprite_get_width(sprite_index)/12) {
	    	with(instance_create(x + random_range(-sprite_get_width(sprite_index)/2, sprite_get_width(sprite_index)/2), 
	    					     y + random_range(-sprite_get_width(sprite_index)/2, sprite_get_width(sprite_index)/2),
	    					     ScorpionBulletHit)) { // I KNOW THIS LOOKS WEIRD BUT ITS EASIER TO READ
	    		image_speed = 0.3;
			}
    	}
    }