#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 4, 12, 16);
	//global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	//global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	global.category     = ["offensive", "defensive", "utility", "ammo"];
	global.cur_category = 0;

#macro scr																		mod_variable_get("mod", "metamorphosis", "scr")
#macro call																		script_ref_call

#define skill_name    return "REROLL";
#define skill_text    return `REROLL THESE @gMUTATIONS@s#INTO ${global.category[global.cur_category]} MUTATIONS`;
#define skill_tip     return "STOP";
//#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_avail   return false;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play_pitch(sndCrownGuardianAppear, 0.6 + random(0.2));
		sound_play_pitch(sndStatueCharge, 0.8 + random(0.2));
		
		with(GameCont) {
			skillpoints++;
			endpoints++;
		}
		if(fork()) {
			var c = global.cur_category, 
				n = instance_number(mutbutton) - 1;
			
			wait 0;
			
			GameCont.endpoints--;
			
			with(SkillIcon) {
				NoToken = true; //LOMuts compat so that you don't get free mutation tokens
				if(num < n) {
					if(call(scr.skill_get_avail, skill)) {
						skill = call(scr.skill_decide, 1, 1, c);
						
						if(skill = mut_none) { instance_destroy(); }
						else {
							name  = skill_get_name(skill);
							text  = skill_get_text(skill);
							if(is_string(skill)) mod_script_call("skill", skill, "skill_button");
							else {
								sprite_index = sprSkillIcon;
								image_index = skill;
							}
						}
					}
				}
				
				else if(skill != "effigyreroll") {
					instance_destroy();
				}
				
				else {
					num = n;
				}
				
				if(instance_exists(self)) alarm0 = num + 1;
				with(LevCont) maxselect = instance_number(mutbutton) - 1;
			}
			
			exit;
		}
		
		mod_variable_set("race", "effigy", "rerolls", mod_variable_get("race", "effigy", "rerolls") - 1);
	}
	
	skill_set(mod_current, 0);

#define array_delete(_array, _index)
	return mod_script_call("mod", "metamorphosis", "array_delete", _array, _index);