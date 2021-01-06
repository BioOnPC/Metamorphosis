#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	//global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "CROWN CRANIUM";
#define skill_text    return desc_decide();
#define skill_tip     return "HAIL TO THE KING";
//#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_avail   
	with(instances_matching_gt(Player, "race_id", 16)) {
		if(race != "parrot" and !mod_script_exists("race", race, "race_ch_text")) {
			return 0;
		}
	}
	
	return 1;

#define desc_decide
	var t = ""; // base blank text
	
	with(Player) {
		if(instance_number(Player) > 1) t += string_upper(race_get_alias(race_id)) + " - ";
		switch(race) {
			case "fish":	 t += "@wCHESTS@s GIVE @wINFINITE AMMO@s"; break;
			case "crystal":  t += "@wPUSH ENEMIES AWAY@s AND#@wREFLECT PROJECTILES@s WHEN @rHURT@s"; break;
			case "eyes":     t += "CONSTANTLY ATTRACT @wDROPS@s"; break;
			case "melting":  t += "@wENEMIES@s EXPLODE INTO @gRADS@s"; break;
			case "plant":    t += "OCCASIONALLY SPAWN @wSAPLINGS@s#BASED ON @wSPEED@s"; break;
			case "venuz":    t += "THE HIGHER YOUR @wRELOAD TIME@s,#THE FASTER YOUR @wRELOAD SPEED@s"; break;
			case "steroids": t += "PORTALS GIVE @yAMMO@s"; break;
			case "robot":    t += "@wWEAPON DROPS@s ARE SOMETIMES @wDOUBLED@s"; break;
			case "chicken":  t += "REGAIN LOST MAX @rHP@s FROM @wALL CHESTS@s"; break;
			case "rebel":    t += "@rHEAL@s WHEN @wALLIES@s DIE"; break;
			case "horror":   t += "@wREROLL@s TWO MUTATIONS"; break;
			case "rogue":    t += "LOSING @rHEALTH@s#GIVES @bSTRIKE AMMO@s"; break;
			case "skeleton": t += "KILLING CAN CREATE#FRIENDLY @pNECRO@s CIRCLES"; break;
			case "frog":     t += "BOUNCING @wRELOADS@s"; break;
			case "parrot":   t += "@wPETS MOVE FASTER@s"; break;
			default: t += ""; break;
		}
		
		if(race_id > 16 and mod_script_exists("race", race, "race_ch_text")) t += mod_script_call("race", race, "race_ch_text");
		
		t += "#";
	}
	
	return t;

#define skill_take    
	sound_play(sndMut);
	var raceList = [];
	with(Player) {
		if(array_find_index(raceList, race) == -1){
			array_push(raceList, race);
		}
	}
	for(var i = 0; i < array_length(raceList); i++){
		switch(raceList[i]){
			case "horror":
				var mutList = [];
				var mutNum = 0;
				while(skill_get_at(mutNum + 1) != null){
					if(is_real(skill_get_at(mutNum)) || is_string(skill_get_at(mutNum)) && !mod_script_exists("skill", skill_get_at(mutNum), "skill_ultra")){
						array_push(mutList, skill_get_at(mutNum));
					}
					mutNum++;
				}
				repeat(2){
					var check = true;
					for(var i = 0; i < array_length(mutList); i++){
						if(skill_get(mutList[i]) > 0){
							check = false;
						}
					}
					if(check){
						break;
					}
					var skill = mutList[irandom(array_length(mutList)-1)];
					while(skill_get(skill) <= 0){
						skill = mutList[irandom(array_length(mutList)-1)];
					}
					skill_set(skill, 0);
					if(skill != mut_patience){
						GameCont.skillpoints += 1;
					}
				}
				break;
		}
	}
	
#define step
	var raceList = [];
	with(Player) {
		if(array_find_index(raceList, race) == -1){
			array_push(raceList, race);
		}
	}
	for(var i = 0; i < array_length(raceList); i++){
		switch(raceList[i]){
			case "fish":
				with(Player) {
					with(instances_matching_ne(ChestOpen, "craniumfish", 1)){
						craniumfish = 1;
						if(distance_to_point(other.x,other.y) < 16){
							if(other.infammo <= 0) { // funny effects (yoinked from busybody)
								sound_play_pitch(sndShotReload, 0.8 + random(0.4));
								sound_play_pitchvol(sndNadeReload, 0.5 + random(0.2), 1.2);
								sound_play_pitch(sndShotgunHitWall, 0.7 + random(0.2));
								sound_play_pitchvol(sndRobotEat, 1.5 + random(0.3), 1.4);
							}
							//and apply the infinite ammo. (extends infinite ammo time, as well!)
							other.infammo += 120;
						}
					}
				}
				break;
			case "crystal":
				with(Player) {
				
				}
				break;
			case "eyes":
				with(Player) {
				
				}
				break;
			case "melting":
			
				break;
			case "plant":
				with(Player) {
				
				}
				break;
			case "venuz":
				with(Player) {
					var modifier = reloadspeed/max(weapon_get_load(wep)/10,1)-reloadspeed;
					reloadspeed -= modifier;
					if(fork()){
						wait(0);
						if(!instance_exists(self)){exit;}
						reloadspeed += modifier;
						exit;
					}
				}
				break;
			case "steroids":
			
				break;
			case "robot":
					with(instances_matching_ne(instances_matching_ge(WepPickup, "ammo", 1), "craniumrobot", 1)){
						craniumrobot = 1;
						if(irandom(5) == 0){
							instance_copy(true);
						}
					}
				break;
			case "chicken":
				with(Player) {
					with(instances_matching_ne(ChestOpen, "craniumchicken", 1)){
						craniumchicken = 1;
						if(sprite_index != sprHealthChestOpen && distance_to_point(other.x,other.y) < 16){
							other.chickendeaths--;
							other.maxhealth++;
						}
					}
				}
				break;
			case "rebel":
			
				break;
			case "rogue":
				with(Player) {
					var hp = my_health;
					if(fork()){
						wait(0);
						if(!instance_exists(self)){exit;}
						if(my_health < hp){
							rogueammo = min(rogueammo + 1, ultra_get(char_rogue,1) > 0 ? 6 : 3)
						}
						exit;
					}
				}
				break;
			case "skeleton":
			
				break;
			case "frog":
				with(Player) {
					if(!(button_check(index, "nort") || button_check(index, "sout") || button_check(index, "east") || button_check(index, "west")) && ("craniumfrog" not in self ||craniumfrog <= 0)){
						if(fork()){
							var prevdir = direction;
							wait(0);
							if(!instance_exists(self)){exit;}
							if(direction != prevdir && !(button_check(index, "nort") || button_check(index, "sout") || button_check(index, "east") || button_check(index, "west"))){
								reload = max(reload-4,0);
								craniumfrog = 5;
							}
							exit;
						}
					}else{
						if("craniumfrog" not in self){
							craniumfrog = 0;
						}
						craniumfrog--;
					}
				}
				break;
			case "parrot":
			
				break;
		}
	}