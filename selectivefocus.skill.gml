#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkillAtomicPoresIcon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkillAtomicPoresHUD.png",  1,  8,  8);
	global.sprEDelete   = sprite_add("sprites/VFX/sprEDelete.png",  9,  12,  12);

#define skill_name    return "SELECTIVE FOCUS";
#define skill_text    return "KILLING AN @wENEMY@s#DESTROYS THEIR @wBULLETS";
#define skill_tip     return "CAN'T FOCUS";
//#define skill_icon    return global.sprSkillHUD;
//#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define step
    with(instances_matching_le(enemy, "my_health", 0)) {
    	with(instances_matching(projectile, "creator", id)) {
    		superiordelete = 5 + irandom(15);
    	}
    }
    
    with(instances_matching_gt(projectile, "superiordelete", 0)) {
    	superiordelete--;
    	if(superiordelete = 0) {
    		if(object_index = EnemyBullet1) {
    			with(instance_create(x, y, EatRad)) {
    				sprite_index = global.sprEDelete;
    				direction = other.direction;
    				image_angle = direction;
    			}
    			instance_delete(self);
    		}
    		
    		else {
    			instance_destroy();
    		}
    		
    		sound_play_pitch(sndClick, 1.5 + random(0.4));
    	}
    }