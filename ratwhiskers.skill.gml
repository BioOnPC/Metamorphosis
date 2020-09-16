#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "RAT WHISKERS";
#define skill_text    return "MORE @bSPECIAL PICKUPS";
#define skill_tip     return "HOARD CREATURE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut);
#define skill_avail   return mod_exists("mod", "telib");
#define step
	if(!mod_exists("mod", "telib")) {
		skill_set(mod_current, 0);
		if(instance_exists(GameCont)) GameCont.skillpoints++;
		exit;
	}

    with(instances_matching([AmmoPickup, HPPickup], "whiskerpickup", null)) {
    	 // fun fact! you can just put whatever the fuck you want in here
    	whiskerpickup = ":)";
    	var pickupchoose = [];
    	pickupchoose[0] = "BonusAmmoPickup";
    	pickupchoose[1] = "BonusHealthPickup";
    	//if(random(5) < 1 and array_find_index(obj_create(x, y, ""), "HammerHeadPickup")) array_push(pickupchoose, "HammerHeadPickup");
    	//if(random(10) < 1 and array_find_index(obj_create(x, y, ""), "OrchidBall")) array_push(pickupchoose, "OrchidBall");
    	if(random(20) < 1) array_push(pickupchoose, "SpiritPickup");
    	
    	if(random(6) < skill_get("ratwhiskers")) {
    		obj_create(x, y, pickupchoose[irandom(array_length(pickupchoose) - 1)]);
    	}
    }
    
    
#define obj_create(_x, _y, _obj)                                            	return	mod_script_call_nc('mod', 'telib', 'obj_create', _x, _y, _obj);