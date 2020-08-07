#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkillAtomicPoresIcon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkillAtomicPoresHUD.png",  1,  8,  8);
	global.level_start = false;

#define skill_name    return "CANCEROUS GROWTHS";
#define skill_text    return "@yAMMO DROPS@s SOMETIMES SPAWN @rHEALTH@s#ADDITIONAL @rHEALTH CHESTS@s";
#define skill_tip     return "IT NEVER STOPS";
//#define skill_icon    return global.sprSkillHUD;
//#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define step
    with(instances_matching(AmmoPickup, "cancergrowth", null)) {
    	cancergrowth = 1;
    	if(random(3) < 1) {
    		with(instance_create(x, y, HPPickup)) num *= 0.5;
    	}
    }

	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	else if(global.level_start){
		global.level_start = false;
		
		with(RadChest) {
			if(random(10) < 1) {
				var nfloor = instance_nearest(x + (32 * random_range(3, 3)), y + (32 * random_range(3, 3)), Floor);
				instance_create(nfloor.x + 16, nfloor.y + 16, HealthChest);
			}
		}
	}