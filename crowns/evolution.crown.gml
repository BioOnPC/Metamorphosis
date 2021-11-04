#define init
	 // Sprites:
	global.sprCrownIcon    = sprite_add("../sprites/crowns/Evolution/sprCrownIcon.png",     1, 12, 16);
	global.sprCrownIdle    = sprite_add("../sprites/crowns/Evolution/sprCrownIdle.png",    1,  8,  8);
	global.sprCrownWalk    = sprite_add("../sprites/crowns/Evolution/sprCrownWalk.png",     6,  8,  8);
	global.sndCrownSlct    = sound_add("../sounds/sndCrown" + string_upper(string(mod_current)) + ".ogg");
	global.last_took = []; 
	global.last_race = [];
	global.level_start = false;
	global.areas_visited = 0;
	
#define crown_name        return "CROWN OF EVOLUTION";
#define crown_text        return "GET AN ADDITIONAL @gULTRA MUTATION#@wRANDOMIZE@s MUTATIONS EACH AREA";
#define crown_tip         return "A HIGHER BEING";
#define crown_avail		  return (instance_exists(GameCont) and GameCont.loops > 0 and GameCont.level >= 10);
	
#define crown_button
	sprite_index = global.sprCrownIcon;
	
#define crown_object
	 // Visual:
	spr_idle = global.sprCrownIdle;
	spr_walk = global.sprCrownWalk;
	sprite_index = spr_idle;
	
	 // Sound:
	if(instance_is(other, CrownIcon)){
		sound_play(sndCrownRandom);
	}

#define crown_take
	 // Gives randomized mutations:
	randomize_muts();
	
	global.areas_visited = 1;
	
	var a = option_get("distance_evolved");
	if(a < global.areas_visited) option_set("distance_evolved", a = undefined ? 1 : (a + 1));
	
	 // Obtain Ultra:
	GameCont.endpoints++;
	
	if(array_length(instances_matching(mutbutton, "crown", mod_current)) > 0) {
		sound_play(sndMenuCrown);
		sound_play(global.sndCrownSlct);
	}
	
#define crown_lose
	for(i = 0; i < array_length(global.last_took); i++) {
		ultra_set(global.last_race[i], global.last_took[i], 0);
		skill_set(global.last_took[i], 0);
	}
	
	global.last_race = [];
	global.last_took = [];
	
#define step
	with(instances_matching(mutbutton, "object_index", SkillIcon, EGSkillIcon)) {
		if((object_index = EGSkillIcon) or (is_string(skill) and mod_script_exists("skill", skill, "skill_ultra"))) {
			if((!is_string(skill) and ultra_get(race, skill)) or (object_index != EGSkillIcon and is_string(skill) and (skill_get(skill) or !option_get("custom_ultras")))) {
				 // Check to see what ultra this chump took:
				if(instance_exists(self)) {
					if(fork()) {
						var _skill = skill;
						
						if(object_index = EGSkillIcon) var _race = race; 
						else var _race = -1;
						
						wait 1;
						
						if(!instance_exists(self) and ((!is_string(_skill) and ultra_get(_race, _skill)) or skill_get(_skill))) {
							array_push(global.last_race, _race);
							array_push(global.last_took, _skill);
						}
						
						exit;
					}
				}
			}
		}
	}

	 // Level Start:
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	else if(global.level_start){
		global.level_start = false;
		if(GameCont.subarea = 1) {
			randomize_muts();
			
			global.areas_visited++;
			
			var a = option_get("distance_evolved");
			if(a < global.areas_visited) option_set("distance_evolved", a);
		}
	}
	
#define randomize_muts
	//this is gonna be the list of mutations to reroll
	var mutList = [];
	
	//going down the list of mutations the player has
	var mutNum = 0;
	while(skill_get_at(mutNum) != null){
		//check to make sure it's not a modded ultra
		if(is_real(skill_get_at(mutNum)) || (is_string(skill_get_at(mutNum)) && mod_exists("skill", skill_get_at(mutNum)) && !mod_script_exists("skill", skill_get_at(mutNum), "skill_ultra"))){
			array_push(mutList, skill_get_at(mutNum));
		}
		mutNum++;
	}
	
	//go through the list and set those mutations to 0!
	for(var i = 0; i < array_length(mutList); i++){
		skill_set(mutList[i], 0);
	}
	
	repeat(mutNum) {
		skill_set(skill_decide(0), 1);
	}
	
#define skill_decide(_category)
	return mod_script_call("mod", "metamorphosis", "skill_decide", _category);
	
#define skill_get_avail(_skill)
	return mod_script_call("mod", "metamorphosis", "skill_get_avail", _skill);
	
#define array_shuffle(_array)
	var	_size = array_length(_array),
		j, t;
		
	for(var i = 0; i < _size; i++){
		j = irandom_range(i, _size - 1);
		if(i != j){
			t = _array[i];
			_array[@i] = _array[j];
			_array[@j] = t;
		}
	}
	
	return _array;
	
#define option_get(opt)
	return mod_script_call("mod", "metamorphosis", "option_get", opt);
	
#define option_set(opt, val)
	return mod_script_call("mod", "metamorphosis", "option_set", opt, val);