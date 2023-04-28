#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sndSkillSlct = sound_add("../sounds/Cursed/sndCurse" + string_upper(string(mod_current)) + ".ogg");

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "IMPATIENCE";
#define skill_text    return "INSTANTLY @gMUTATE@s A @pCURSED MUTATION@s";
#define skill_tip     return "DEAL WITH THE DEVIL";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_type    return "cursed";
#define skill_take(_num)
	if(_num > 0) {
		if(instance_exists(LevCont)){
			sound_play(sndMut);
			sound_play_pitch(sndCursedChest, 1.2);
			sound_play(sndBigCursedChest);
			sound_play(global.sndSkillSlct);
		
			 // Increase important GameCont variables to account for a new selection of mutations
			GameCont.skillpoints++;
			GameCont.endpoints++;
			
			if(fork()){
			    wait(0); // Very miniscule pause so the game can catch up
			    GameCont.endpoints--; // Fix what we did before
			    with(SkillIcon) instance_destroy(); // Obliterate all leftover skill icons
			    LevCont.maxselect = 7; // This is how many skills we're going to make +1.
			    
			    for(var i = 1; i <= 4 + (array_length(instances_matching(Player, "race", "horror")) > 0 ? 1 : 0); i++) { // Iterate through all votes
			        var _mod = mod_get_names("skill"),
				        _scrt = "skill_cursed",
				        _cursed = [];
				    
				     // Go through and find all cursed mutations you have
				    for(var c = 0; c < array_length(_mod); c++){ 
				    	if(!skill_get(_mod[c]) and array_length(instances_matching(SkillIcon, "skill", _mod[c])) = 0 and _mod[c] != mod_current and mod_script_exists("skill", _mod[c], _scrt)) array_push(_cursed, _mod[c]);
				    }
				    
			        if(array_length(_cursed) > 0) with(instance_create(0, 0, SkillIcon)){ // Make the skill icons
			            creator = LevCont;
			            num = instance_number(mutbutton) + 1;
			            alarm0 = num + 3;
			            skill = _cursed[irandom_range(0, array_length(_cursed) - 1)];
			            
			             // Apply relevant scripts
			            mod_script_call("skill", skill, "skill_button");
			            name = mod_script_call("skill", skill, "skill_name");
		                text = mod_script_call("skill", skill, "skill_text");
			        }
			    }
			    
			    with(SkillIcon) num -= (instance_number(mutbutton) - 4)/2
			    
			    exit;
			}
			
			//skill_set(mod_current, 0);
		}
		
		 // If it's selected anywhere that isn't the mutation selection screen
		else {
			 var _mod = mod_get_names("skill"),
		        _scrt = "skill_cursed",
		        _cursed = [];
		    
		     // Go through and find all cursed mutations you have
		    for(var i = 0; i < array_length(_mod); i++){ 
		    	if(!skill_get(_mod[i]) and mod_script_exists("skill", _mod[i], _scrt)) array_push(_cursed, _mod[i]);
		    }
			 
			 // Give a random cursed mut
			skill_set(_cursed[irandom_range(0, array_length(_cursed) - 1)], skill_get(string(mod_current)));
			 // Remove this blank skill
			//skill_set(mod_current, 0);
		}
	}

#define skill_avail   return false;
#define skill_cursed  
	var _mod = mod_get_names("skill"),
        _scrt = "skill_cursed",
        _cursed = [];
    
     // Go through and find all cursed mutations you have
    for(var i = 0; i < array_length(_mod); i++){ 
    	if(_mod[i] != mod_current and !skill_get(_mod[i]) and mod_script_exists("skill", _mod[i], _scrt) and mod_script_call("skill", _mod[i], _scrt) > 0) array_push(_cursed, _mod[i]);
    }
    
	return array_length(_cursed) > 1; // for metamorphosis