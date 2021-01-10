#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	
	global.diff = 0;

#define skill_name    return "CRITICAL MASS";
#define skill_text    return "@gRESELECT YOUR MUTATIONS@s#RESELECT AGAIN @wLATER";
#define skill_tip     return "ENTROPY UNDONE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take(_num)
	if(_num > 0 and array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndStatueCharge);
		skill_set_active(mut_patience, 0);
		with(GameCont) global.diff = hard;
		
		skill_reset(skill_get(mod_current));
	}
	
#define skill_ultra   return "horror";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool
#define skill_lose    skill_set_active(mut_patience, 1);

#define skill_reset(_addMuts)
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
		skill_set(skill, 0);
		GameCont.skillpoints += 1;
	}