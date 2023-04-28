#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	global.level_start = (instance_exists(GenCont) || instance_exists(Menu));

#define skill_name    return "PYROMANIA";
#define skill_text    return "FIRE AND EXPLOSIONS @rIGNITE@s CORPSES";
#define skill_tip     return "HELL WORLD";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_type    return "offensive";
#define skill_wepspec return 1;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}

#define step
	with(instances_matching(CustomProjectile, "name", "Fire Bullet")) pyroflammable = true;

	with(Corpse) {
		 // Ignite corpse if they're not ignited!
		if(("metamorphosis_ignited" not in self or metamorphosis_ignited <= 0) and ((place_meeting(x, y, CustomProjectile) && variable_instance_exists(instance_nearest(x, y, CustomProjectile), "pyroflammable")) || place_meeting(x, y, Flame) || place_meeting(x, y, FlameShell) || place_meeting(x, y, TrapFire) || place_meeting(x, y, Explosion) || place_meeting(x, y, GreenExplosion) || place_meeting(x, y, SmallExplosion))) {
			mod_script_call("mod", "metamorphosis", "alight", (30 + irandom(15)) * skill_get(mod_current));
		}
	}
	
#macro  scr																						mod_variable_get("mod", "metamorphosis", "scr")
#macro  call																					script_ref_call
