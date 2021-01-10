#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "UNDER THE WINGS";
#define skill_text    return "DOUBLED @wPET@s SLOTS#A @wFEW FREE FRIENDS!";
#define skill_tip     return "SUCH A SWEETHEART";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take(_num)    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) sound_play(sndBasicUltra);
	if(_num > 0) {
		mod_variable_set("mod", "ntte", "pet_max", mod_variable_get("mod", "ntte", "pet_max") * (_num + 1));
		with(instances_matching_ne(Player, "ntte_pet_max", null)){
			ntte_pet_max *= _num + 1;
			if(race = "parrot") {
				repeat(2) {
					pet_spawn(x, y, choose("Parrot", "Scorpion", "Slaughter", "CoolGuy"));
				}
			}
		}
	}
	

#define skill_ultra   return "parrot";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool
	
#define skill_lose
	mod_variable_set("mod", "ntte", "pet_max", mod_variable_get("mod", "ntte", "pet_max") / (skill_get(mod_current) + 1));
	with(instances_matching_ne(Player, "ntte_pet_max", null)){
		ntte_pet_max = round(ntte_pet_max/(skill_get(mod_current) + 1));
	}

#define orandom(_num)                                            	    		return	mod_script_call_nc('mod', 'metamorphosis', 'orandom', _num);
#define pet_spawn(_x, _y, _name)                                            		return	mod_script_call_nc('mod', 'telib', 'pet_spawn', _x, _y, _name);