#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	global.level_start = false;
	global.pouchenemies = [];

#define skill_name    return "CHEEK POUCHES";
#define skill_text    return "@wWEAK ENEMIES@s DROP @bSPECIAL PICKUPS@s";
#define skill_tip     return "HOARD CREATURE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}
#define skill_avail   return mod_exists("mod", "telib");
#define step
	if(!mod_exists("mod", "telib")) {
		skill_set(mod_current, 0);
		if(instance_exists(GameCont)) GameCont.skillpoints++;
		exit;
	}
	
	 // Level Start:
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	else if(global.level_start){
		global.level_start = false;
		
		global.pouchenemies = [];
		
		var hpamt = ((8 * skill_get(mod_current)) + ((GameCont.loops * 8) * (skill_get("insurgency") + 1))),
			availenemies = instances_matching_le(enemy, "my_health", 10 + GameCont.hard);
		
		while(hpamt > 0) {
			if(array_length(availenemies) = 0) exit;
			else {
				with(availenemies[irandom(array_length(availenemies) - 1)]) {
					array_push(global.pouchenemies, id);
					hpamt -= my_health;
					
					
					with(mod_script_call_nc('mod', 'metamorphosis', 'obj_create', x, y, "CheekPouch")) {
						creator = other.id;
					}
				}
			}
		}
	}

    with(instances_matching_le(global.pouchenemies, "my_health", 0)) {
    	var pickupchoose = [];
    	
    	repeat(10) {
    		array_push(pickupchoose, "BonusAmmoPickup");
    	}
    	
    	array_push(pickupchoose, "BonusHealthPickup");
    	array_push(pickupchoose, "HammerHeadPickup");
    	if(my_health > 20) {
    		array_push(pickupchoose, "OrchidBall");
    		array_push(pickupchoose, "SpiritPickup");
    	}
    	
    	call(scr.obj_create, x, y, pickupchoose[irandom(array_length(pickupchoose) - 1)]);
    	
    	sound_play_pitch(sndHammerHeadEnd, 1.4 + random(0.3));
    	sound_play_pitch(sndEXPChest, 1.7 + random(0.2));
    	sound_play_pitch(sndHPPickupBig, 1.4 + random(0.2));
    }
    
    
#macro  scr																						mod_variable_get("mod", "metamorphosis", "scr")
#macro  call																					script_ref_call