#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	//global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "STEEL WOOL";
#define skill_text    return "KILLS WITH @wENERGY WEAPONS@s#@yPARALYZE@s ENEMIES";
#define skill_tip     return "KINETIC ENERGY";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_avail     return (mod_exists("mod", "varia_tools") and (instance_exists(Menu) or instance_exists(LevCont) or skill_get(mod_current) > 0));
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		//sound_play(global.sndSkillSlct);
	}
    
   	
#macro  scr																						mod_variable_get("mod", "metamorphosis", "scr")
#macro  call																					script_ref_call