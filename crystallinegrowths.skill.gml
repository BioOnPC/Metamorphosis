#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkillCrystallineGrowthsIcon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkillCrystallineGrowthsHUD.png",  1,  8,  8);
	global.level_start = false;

#define skill_name    return "CRYSTALLINE GROWTHS";
#define skill_text    return "@yAMMO DROPS@s SOMETIMES SPAWN @rMEDKITS@s#@rMEDKITS@s GIVE TEMPORARY PROTECTION";
#define skill_tip     return "IT NEVER STOPS";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define step
    with(instances_matching(AmmoPickup, "cancergrowth", null)) {
    	cancergrowth = 1;
    	if(random(3) < 1) {
    		instance_create(x, y, HPPickup);
    	}
    }
    
    with(instances_matching(HPPickup, "crystallinepickup", null)) {
    	crystallinepickup = 1;
    	with(obj_create(x, y, "CrystallinePickup")) {
    		creator = other.id;
    	}
    }

#define obj_create(_x, _y, _obj)                                                        return  mod_script_call_nc('mod', 'metamorphosis', 'obj_create', _x, _y, _obj);
