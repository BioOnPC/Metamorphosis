#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1,  12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",	 1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	
	global.sprHPCrystalline    = sprite_add("sprites/VFX/sprCrystalHP.png", 7, 6, 7);
	global.sprFatHPCrystalline = sprite_add("sprites/VFX/sprFatCrystalHP.png", 7, 9, 10);
	
#define skill_name    return "CRYSTALLINE GROWTHS";
#define skill_text    return "@wENEMIES@s DROP MORE @rMEDKITS@s#@rMEDKITS@s GIVE @wINVINCIBILITY";
#define skill_tip     return "IT NEVER STOPS";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}
#define step
	script_bind_end_step(end_step, 0);

    with(instances_matching(AmmoPickup, "cancergrowth", null)) {
    	cancergrowth = 1;
    	if(random(power(3, 1 / skill_get(mod_current))) < 1) {
    		instance_create(x, y, HPPickup);
    	}
    }
    
    with(instances_matching(HPPickup, "crystallinepickup", null)) {
    	crystallinepickup = 1;
    	with(call(scr.obj_create, x, y, "CrystallinePickup")) {
    		creator = other.id;
    	}
    }
    
#define end_step // using a script-bound end step is important for respriting instances because it circumvents the one-frame delay
	with(instances_matching(HPPickup, "sprite_index", sprHP)){
		sprite_index = (
			(skill_get(mut_second_stomach) > 0)
			? global.sprFatHPCrystalline
			: global.sprHPCrystalline
		);
	}
	
	instance_destroy();

#macro  scr																						mod_variable_get("mod", "metamorphosis", "scr")
#macro  call																					script_ref_call
