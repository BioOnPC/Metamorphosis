#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 4, 12, 16);
	//global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	//global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	global.category     = irandom_range(1, 4);

#define skill_name    return "REROLL";
#define skill_text    return `REROLL THESE @gMUTATIONS@s#INTO ${category_names(global.category)} MUTATIONS`;
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
			var c = global.category;
			
			wait 0;
			
			GameCont.endpoints--;
			
			with(SkillIcon) {
				if(skill_get_avail(skill)) {
					skill = skill_decide(c);
					
					if(skill = mut_none) {
						with(instances_matching_gt(instances_matching(mutbutton, "creator", creator), "num", num)) {
							num--;
							alarm0--;
						}
						instance_destroy();
					}
					
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
			
			exit;
		}
		
		mod_variable_set("race", "effigy", "rerolls", mod_variable_get("race", "effigy", "rerolls") - 1);
	}
	
	skill_set(mod_current, 0);

#define category_names(_category)
	switch(_category) {
		case 1: return "@wOFFENSIVE@s"; break;
		case 2: return "@rDEFENSIVE@s"; break;
		case 3: return "@bUTILITY@s"; break;
		case 4: return "@yAMMO@s"; break;
		default: return "???"; break;
	}

#define skill_get_avail(_skill)
	return mod_script_call("mod", "metamorphosis", "skill_get_avail", _skill);

#define skill_decide(_category)
	return mod_script_call("mod", "metamorphosis", "skill_decide", _category);

#define skill_get_category(mut)
	return mod_script_call("mod", "metamorphosis", "skill_get_category", mut);

#define array_delete(_array, _index)
	return mod_script_call("mod", "metamorphosis", "array_delete", _array, _index);