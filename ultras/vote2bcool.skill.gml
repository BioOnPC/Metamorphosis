#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "VOTE 2 B COOL";
#define skill_text    return (random(200) > 1 ? "@yDECIDE YOUR FUTURE@s" : "@y¿QUIERES?");
#define skill_tip     return "U DA BEST";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_ultra   return "venuz";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool
#define skill_take(_num)
	if(_num > 0) {
		if(instance_exists(LevCont)){
			sound_play(sndBasicUltra);
		
			 // Increase important GameCont variables to account for a new selection of mutations
			GameCont.skillpoints++;
			GameCont.endpoints++;
			if(GameCont.area = 0) GameCont.loops--;
			GameCont.area = 107;
			GameCont.subarea = 0;
			with(MusCont) event_perform(ev_alarm, 11);
			
			if(fork()){
			    wait(0); // Very miniscule pause so the game can catch up
			    GameCont.endpoints--; // Fix what we did before
			    with(SkillIcon) instance_destroy(); // Obliterate all leftover skill icons
			    LevCont.maxselect = 7; // This is how many skills we're going to make +1.
			    
			    for(var i = 1; i <= 6; i++) { // Iterate through all votes
			        var _skill = `vote${i}`; // Find all vote skills
			        with(instance_create(0, 0, SkillIcon)){ // Make the skill icons
			            creator = LevCont;
			            num = instance_number(mutbutton);
			            alarm0 = num + 3;
			            skill = _skill;
			            
			             // Apply relevant scripts
			            mod_script_call("skill", _skill, "skill_button");
			            name = mod_script_call("skill", _skill, "skill_name");
		                text = mod_script_call("skill", _skill, "skill_text");
			        }
			    }
			    exit;
			}
		}
		
		 // If it's selected anywhere that isn't the mutation selection screen
		else {
			 // Give a random vote
			skill_set("vote" + string(random_range(1, 6)), skill_get(string(mod_current)));
			 // Remove this blank skill
			skill_set(string(mod_current), 0);
		}
	}