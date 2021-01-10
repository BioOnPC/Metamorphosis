#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "CHEEK POUCHES";
#define skill_text    return "MORE @bSPECIAL PICKUPS";
#define skill_tip     return "HOARD CREATURE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) sound_play(sndMut);
#define skill_avail   return mod_exists("mod", "telib");
#define step
	if(!mod_exists("mod", "telib")) {
		skill_set(mod_current, 0);
		if(instance_exists(GameCont)) GameCont.skillpoints++;
		exit;
	}

    with(instances_matching([AmmoPickup, HPPickup], "cheekpouch", null)) {
    	 // fun fact! you can just put whatever the fuck you want in here
    	cheekpouch = ":)";
    	var pickupchoose = [];
    	
    	array_push(pickupchoose, "BonusAmmoPickup"  );
    	array_push(pickupchoose, "BonusHealthPickup");
    	
    	 // add the hammerhead pickup, if available
    	if(random(5) < 1 and mod_exists("skill", "reroll")) array_push(pickupchoose, "HammerHeadPickup" );
    	 // even more secret, if available
    	if(random(10) < 1 and mod_exists("skill", "reroll")) array_push(pickupchoose, "OrchidBall"      );
    	 // add the strong spirit pickup, if available
    	if(random(20) < 1)								   array_push(pickupchoose, "SpiritPickup"		);
    	
    	if(random(12) < skill_get(mod_current)) {
    		obj_create(x, y, pickupchoose[irandom(array_length(pickupchoose) - 1)]);
    	}
    }
    
    
#define obj_create(_x, _y, _obj)                                            	return	mod_script_call_nc('mod', 'telib', 'obj_create', _x, _y, _obj);