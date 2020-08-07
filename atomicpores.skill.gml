#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkillAtomicPoresIcon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkillAtomicPoresHUD.png",  1,  8,  8);

#define skill_name    return "ATOMIC PORES";
#define skill_text    return "@wENEMIES@s DROP MORE @gRADS";
#define skill_tip     return "PUS FILLED";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMutTriggerFingers);
#define step
    with(instances_matching(enemy, "atomicrads", null)) { // Find all unaffected enemies
        atomicrads = 1;
        raddrop += ceil(raddrop * 0.10); // Increase rads
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