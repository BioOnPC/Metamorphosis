#define init
	 // Sprites:
	global.sprCrownIcon    = sprite_add("../sprites/crowns/Evolution/sprCrownIcon.png",     1, 12, 16);
	global.sprCrownIdle    = sprite_add("../sprites/crowns/Evolution/sprCrownIdle.png",    1,  8,  8);
	global.sprCrownWalk    = sprite_add("../sprites/crowns/Evolution/sprCrownWalk.png",     6,  8,  8);
	global.last_took = []; 
	global.last_race = [];
	
#define crown_name        return "CROWN OF EVOLUTION";
#define crown_text        return "GET AN ADDITIONAL @gULTRA MUTATION#@wRANDOMIZE@s MUTATIONS EACH AREA";
#define crown_tip         return "A HIGHER BEING";
#define crown_avail		  return (instance_exists(GameCont) and GameCont.loops > 0 and GameCont.level >= 10) ? 1 : 0;
	
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
	
	 // Obtain Ultra:
	GameCont.endpoints++;
	
#define crown_lose
	for(i = 0; i < array_length(global.last_took); i++) {
		ultra_set(global.last_race[i], global.last_took[i], 0);
		skill_set(global.last_took[i], 0);
	}
	
	global.last_race = [];
	global.last_took = [];
	
#define step
	with(instances_matching([EGSkillIcon, SkillIcon], "evolutioncheck", null)) { // Handler for the additional ultra stuff
		if((object_index = EGSkillIcon) or (is_string(skill) and mod_script_exists("skill", skill, "skill_ultra"))) {
			if(ultra_get(race, skill) or skill_get(skill)) {
				with(instances_matching_gt(mutbutton, "num", num)) {
					LevCont.maxselect--;
					num--;
				}
				
				if(instance_number(mutbutton) = 1) {
					with(GameCont){
						endpoints = 0;
						
						with(LevCont) instance_destroy();
						if(skillpoints > 0) instance_create(0, 0, LevCont);
						else instance_create(0, 0, GenCont);
					}
				}
				
				instance_destroy();
			}
			
			 // Check to see what ultra this chump took:
			if(instance_exists(self)) {
				if(fork()) {
					var _skill = skill;
					
					if(object_index = EGSkillIcon) var _race = race; 
					else var _race = -1;
					
					wait 1;
					
					if(!instance_exists(self) and (ultra_get(_race, _skill) or skill_get(_skill))) {
						array_push(global.last_race, _race);
						array_push(global.last_took, _skill);
					}
					
					exit;
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
		if(GameCont.subarea = 1) randomize_muts();
	}
	
#define randomize_muts
	//this is gonna be the list of mutations to reroll
	var mutList = [];
	
	//going down the list of mutations the player has, except for the last one
	var mutNum = 0;
	while(skill_get_at(mutNum + 1) != null){
		//check to make sure it's not a modded ultra
		if(is_real(skill_get_at(mutNum)) || (is_string(skill_get_at(mutNum)) && !mod_script_exists("skill", skill_get_at(mutNum), "skill_ultra"))){
			array_push(mutList, skill_get_at(mutNum));
		}
		mutNum++;
	}
	
	//go through the list and set those mutations to 0!
	for(var i = 0; i < array_length(mutList); i++){
		skill_set(mutList[i], 0);
	}
	
	repeat(mutNum) {
		skill_set(skill_decide(), 1);
	}
	
#define skill_decide
	 // Stolen from NTTE
	var _skillList = [],
		_skillMods = mod_get_names("skill"),
		_skillMax  = 30,
		_skillAll  = true; // Already have every available skill
		
	for(var i = 1; i < _skillMax + array_length(_skillMods); i++){
		var _skill = ((i < _skillMax) ? i : _skillMods[i - _skillMax]);
		
		if(
			(skill_get_avail(_skill) or (is_string(_skill) and mod_script_exists("skill", _skill, "skill_cursed") and mod_script_call("skill", _skill, "skill_cursed") = true)) // Made sure to modify this to work with cursed mutations
			&& _skill != mut_patience
			&& (_skill != mut_last_wish || skill_get(_skill) <= 0)
		){
			array_push(_skillList, _skill);
			if(skill_get(_skill) == 0) _skillAll = false;
		}
	}
	
	with(array_shuffle(_skillList)){
		var _skill = self;
		if(_skillAll || skill_get(_skill) == 0) return _skill;
	}
	
	return mut_none;
	
#define skill_get_avail(_skill)
	/*
		Returns 'true' if the given skill can appear on the mutation selection screen, 'false' otherwise
	*/
	
	if(skill_get_active(_skill)){
		if(
			_skill != mut_heavy_heart
			|| skill_get(mut_heavy_heart) != 0
			|| (GameCont.wepmuts >= 3 && GameCont.wepmuted == false)
		){
			if(
				!is_string(_skill)
				|| !mod_script_exists("skill", _skill, "skill_avail")
				|| mod_script_call("skill", _skill, "skill_avail")
			){
				return true;
			}
		}
	}
	
	return false;
	
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