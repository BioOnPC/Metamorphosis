#define init
	global.sprSkillIcon = sprite_add("../../sprites/Icons/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../../sprites/HUD/Ultras/VOTE/sprVote"   + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	
	 // Don't Appear as an Ultra:
	skill_set_active(mod_current, false);

#define skill_name    return "TYRANY";
#define skill_text    return "@wSTUCK BOLTS@s INCREASE DAMAGE TAKEN#TO @wSTUCK ENEMIES";
#define skill_tip     return "WOODEN FIST";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_ultra   return "venuz";
#define skill_avail   return false;

#define skill_take(_num)
	var _mult = skill_get("vote2bcool");
	if(_mult != 0){
		skill_set("vote2bcool", 0);
		skill_set(mod_current, _num * _mult);
	}
	
	 // Sound:
	if(_num > 0 && instance_exists(LevCont)){
		sound_play(sndBasicUltra);
	}
	
#define step
	with(enemy) {
		if("my_health" in self and array_length(instances_matching(BoltStick, "target", self)) > 0) {
			if("tyranny_lsthealth" not in self) tyranny_lsthealth = my_health;
			
			if(tyranny_lsthealth > my_health) {
				sound_play_pitch(sndFlakExplode, 1.6 + random(0.3));
				sound_play_pitch(sndGuardianFire, 0.5 + random(0.3));
				my_health -= ceil((tyranny_lsthealth - my_health)/5);
				with(instance_create(x, y, TangleKill)) {
					depth = other.depth - 1;
				}
			}
			
			tyranny_lsthealth = my_health;
		}
	}
