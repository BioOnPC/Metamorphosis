#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra"   + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	
#define skill_name    return "VOTE 2 B COOL";
#define skill_text    return (random(200) > 1 ? "@yDECIDE YOUR FUTURE@s" : "@y¿QUIERES?");
#define skill_tip     return "U DA BEST";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_ultra   return "venuz";
#define skill_avail   return false;

#define skill_take(_num)
	var _last = variable_instance_get(GameCont, `skill_last_${mod_current}`, 0);
	variable_instance_set(GameCont, `skill_last_${mod_current}`, _num);
	
	 // Ultra Point:
	GameCont.endpoints += (_num - _last);
	
	 // Sound:
	if(_num > 0 && instance_exists(LevCont)){
		sound_play(sndBasicUltra);
	}
	
#define skill_lose
	skill_take(0);
	
#define step
	 // Voting Booth:
	if(instance_exists(LevCont)){
		var _inst = instances_matching(LevCont, "vote2bcool", null);
		if(array_length(_inst)){
			with(_inst){
				vote2bcool = (
					GameCont.endpoints > 0
					&& GameCont.skillpoints <= 0
					&& GameCont.crownpoints <= 0
				);
				if(vote2bcool){
					 // Delete Mutation Icons:
					with(instances_matching(mutbutton, "creator", self)){
						instance_destroy();
					}
					
					 // Spawn Vote Ultras:
					GameCont.endcount--;
					maxselect = -1;
					repeat(6){
						maxselect++;
						mod_script_call("mod", "cultra", "custom_ultra_icon_create", "venuz", `vote${maxselect + 1}`, maxselect);
					}
					
					 // Vacation:
					if(GameCont.area == 0){
						GameCont.loops--;
					}
					GameCont.area    = 107;
					GameCont.subarea = 0;
					with(MusCont){
						alarm_set(11, 1);
					}
					with(SpiralCont){
						type = 4;
					}
				}
			}
		}
	}