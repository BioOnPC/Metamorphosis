#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.newLevel = false;

#define skill_name    return "CROWN CRANIUM";
#define skill_text    return desc_decide();
#define skill_tip     return "HAIL TO THE KING";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_avail   
	with(instances_matching_gt(Player, "race_id", 16)) {
		if(race != "parrot" and !mod_script_exists("race", race, "race_cc_text")) {
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
			case "melting":  t += "@rMEAT@s BLOBS SPAWN IN EACH LEVEL"; break;
			case "plant":    t += "OCCASIONALLY SPAWN @wSAPLINGS@s#BASED ON @wSPEED@s"; break;
			case "venuz":    t += "THE HIGHER YOUR @wRELOAD TIME@s,#THE FASTER YOUR @wRELOAD SPEED@s"; break;
			case "steroids": t += "PORTALS GIVE @yAMMO@s"; break;
			case "robot":    t += "@wWEAPON DROPS@s ARE#SOMETIMES @wDOUBLED@s"; break;
			case "chicken":  t += "REGAIN LOST MAX @rHP@s FROM @wALL CHESTS@s"; break;
			case "rebel":    t += "@rHEAL@s WHEN @wALLIES@s DIE"; break;
			case "horror":   t += "@wREROLL@s TWO MUTATIONS"; break;
			case "rogue":    t += "@wENEMIES@s AND @bIDPD@s#DROP @bPORTAL STRIKES"; break;
			case "skeleton": t += "KILLING CAN CREATE#FRIENDLY @pNECRO@s CIRCLES"; break;
			case "frog":     t += "@wHASTENED@s BOUNCES"; break;
			case "parrot":   t += "@wPETS MOVE FASTER@s"; break;
			default: t += ""; break;
		}
		
		if(race_id > 16 and mod_script_exists("race", race, "race_cc_text")) t += mod_script_call("race", race, "race_cc_text");
		
		t += "#";
	}
	
	return t;

#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) sound_play(sndMut);
	var raceList = [];
	with(Player) {
		if(array_find_index(raceList, race) == -1){
			array_push(raceList, race);
		}
	}
	repeat(skill_get(mod_current)){
		for(var i = 0; i < array_length(raceList); i++){
			switch(raceList[i]){
				case "horror":
					var mutList = [];
					var mutNum = 0;
					while(skill_get_at(mutNum + 1) != null){
						if(is_real(skill_get_at(mutNum)) || (is_string(skill_get_at(mutNum)) && mod_exists("skill", skill_get_at(mutNum)) && !mod_script_exists("skill", skill_get_at(mutNum), "skill_ultra"))){
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
	}


#define level_start
	var raceList = [];
	with(Player) {
		if(array_find_index(raceList, race) == -1){
			array_push(raceList, race);
		}
	}
	repeat(skill_get(mod_current)){
		for(var i = 0; i < array_length(raceList); i++){
			switch(raceList[i]){
				case "melting":
					repeat(5 * (GameCont.loops+1)){
						with(instance_random(Floor)){
							obj_create(x, y, "MeatBlob");
						}
					}
				break;
					
				case "steroids":
					with(Player){
						for(var i2 = 1; i2 < array_length(ammo); i2++){
							ammo[i2] += typ_ammo[i2]*2;
							ammo[i2] = min(ammo[i2], typ_amax[i2]);
						}
					}
				break;
			}
		}
	}
	
	
#define step
	if(instance_exists(GenCont)) global.newLevel = true;
	else if(global.newLevel){
		global.newLevel = false;
		level_start();
	}
	var raceList = [];
	with(Player) {
		if(array_find_index(raceList, race) == -1){
			array_push(raceList, race);
		}
	}
	repeat(skill_get(mod_current)){
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
						var hp = my_health;
						if(fork()){
							wait(0);
							if(!instance_exists(self)){exit;}
							if(my_health < hp){
								if(fork()){
									repeat(10){
										if(!instance_exists(self)){exit;}
										for(var i = (current_frame * 10) % 360; i < 360 + ((current_frame * 10) % 360); i += 45){
											with(instance_create(x,y,CrystTrail)){
												switch(other.bskin){
													case 0:
														image_blend = c_white;
														break;
													case 1:
														image_blend = c_yellow;
														break;
													case "red crystal":
														image_blend = c_red;
														break;
													case "tree":
														image_blend = c_green;
														break;
													case "shielder":
														image_blend = c_blue;
														break;
													default:
														image_blend = c_silver;
												}
												direction = i;
												speed = 8;
											}
										}
										with(instance_rectangle_bbox(x-50,y-50,x+50,y+50, projectile)){
											if(team != other.team){
												team = other.team;
												direction = direction + 180;
												image_angle = image_angle + 180;
												instance_create(x,y,Deflect);
											}
										}
										with(instance_rectangle_bbox(x-50,y-50,x+50,y+50, enemy)){
											motion_add(point_direction(other.x,other.y,x,y), 4);
											instance_create(x - hspeed, y - vspeed, Dust);
										}
										wait(1);
									}
									exit;
								}
							}
							exit;
						}
					}
					break;
				case "eyes":
					with(Pickup){
						if(object_index != WepPickup){
							var p = instance_nearest(x,y,Player);
							move_contact_solid(point_direction(x,y,p.x,p.y), 1);
							if(irandom(4/current_time_scale) == 0) instance_create(x, y, Dust).depth = depth + 1;
						}
					}
					break;
				case "plant":
					if(instance_exists(enemy)){
						with(Player) {
							if("craniumplant" not in self){
								craniumplant = 0;
							}
							
							var _x = x;
							var _y = y;
							if(fork()){
								wait(0);
								if(instance_exists(self)) craniumplant += point_distance(x,y,_x,_y);
								exit;
							}
							//if they've moved the equivalent of 40 tiles (wall width) spawn a sapling
							if(craniumplant > 75 * 12){
								craniumplant -= 75 * 12;
								repeat(3) {
									with(instance_create(x, y, Sapling)) {
										team = other.team;
										creator = other;
										raddrop = 0;
									}
								}
								
								with(instance_create(x, y, MeatExplosion)) {
									team = other.team;
									damage = 0;
								}
							}
						}
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
				case "robot":
						with(instances_matching_ne(instances_matching_ge(WepPickup, "ammo", 1), "craniumrobot", 1)){
							craniumrobot = 1;
							
							if(irandom(2) == 0){
								sound_play_pitch(sndGunGun, 1.4 + random(0.4));
								sound_play_pitch(sndBigWeaponChest, 1.6 + random(0.2));
								instance_create(x, y, GunGun);
								instance_copy(false);
							}
						}
					break;
				case "chicken":
					with(Player) {
						with(instances_matching_ne(ChestOpen, "craniumchicken", 1)){
							craniumchicken = 1;
							if(other.chickendeaths > 0 && sprite_index != sprHealthChestOpen && distance_to_point(other.x,other.y) < 16){
								other.chickendeaths--;
								other.maxhealth++;
								
								with(instance_create(x, y, Corpse)) {
									motion_add(random(360), 6 + random(2));
									sprite_index = sprMutant9HeadIdle;
									depth = other.depth - 1;
								}
								
								sound_play(sndChickenRegenHead);
							}
						}
					}
					break;
				case "rebel":
					with(Ally) {
						var _c = creator,
							_x = x,
							_y = y;
						if(fork()){
							wait(0);
							if(!instance_exists(self) && !instance_exists(Portal) && irandom(2) == 0){
								with(_c) {
									if(my_health < maxhealth) my_health++;
									instance_create(x, y, BloodStreak).image_angle = point_direction(x, y, _x, _y);
								}
								sound_play_pitch(asset_get_index("sndPortalFlyby" + string(irandom_range(1, 8))), 1.4 + random(0.4));
								sound_play_pitch(sndHealthChest, 1.8 + random(0.4));
								sound_play_pitch(sndBloodlustProc, 0.6 + random(0.2));
							}
							exit;
						}
					}
					break;
				case "rogue":
					with(instances_matching_le(enemy, "my_health", 0)) { // Find all dead enemies
						var strikechance = 0;
						switch(object_index) {
							case Grunt: 
							case PopoFreak: strikechance = 12; break;
							case Inspector: 
							case Shielder: strikechance = 8; break;
							case EliteGrunt: 
							case EliteShielder: 
							case EliteInspector: strikechance = 6; break;
							case Van: strikechance = 1; break;
							default: strikechance = 72;
						}
						
						if(variable_instance_exists(self, "resourcefulchance")) strikechance = resourcefulchance;
						
						if(random(strikechance) < skill_get(mod_current)) { 
							with(instance_create(x, y, RoguePickup)) alarm0 -= 120;
							with(instance_create(x, y, SmallExplosion)) {
								damage = 0;
								sprite_index = sprPopoExplo;
								mask_index = mskNone;
								image_xscale = 0.2;
								image_yscale = 0.2;
								sound_play_pitch(sndRogueAim, 1.8);
								sound_play_pitch(sndRogueCanister, 1.4);
							}
						}
					}
					break;
				case "skeleton":
					with(instances_matching_le(enemy, "my_health", 0)){
						if(irandom(4) == 0){
							with(obj_create(x, y, "FriendlyNecro")){
								creator = instance_nearest(x, y, Player);
								team = creator.team;
							}
						}
					}
					break;
				case "frog":
					with(instances_matching(Player, "race", "frog")) {
						if(("hastened" not in self or hastened = 0) and place_meeting(x + hspeed, y + vspeed, Wall)){
							if(fork()){
								wait(0);
								
								if(!instance_exists(self)){ exit; }
								
								var prevdir = direction;
								
								sound_play_pitch(sndFrogEndButt, 1 + random(0.2));
								sound_play_pitch(sndRoll, 1.4 + random(0.3));
								sound_play_pitch(sndRocket, 1.6 + random(0.4));
								sound_play_pitch(sndWrench, 1.4 + random(0.2));
								
								with(instance_create(x, y, ImpactWrists)) {
									depth = other.depth - 1;
									image_speed += 0.2;
								}
								
								haste(20, 0.4);	
								
								repeat(15) {
									if(!instance_exists(self)){ exit; }
									
									if(speed < 5){
										move_contact_solid(prevdir, speed/3);
										direction = prevdir;
									}
									wait(1);
								}
								
								exit;
							}
						}
					}
					break;
					
				case "parrot":
					with(instances_matching_ne(instances_matching(CustomHitme, "name", "Pet"), "craniumparrot", 1)){
						if(instance_exists(leader)){
							craniumparrot = 1;
							maxspeed*=1.25;
						}
					}
					break;
			}
		}
	}

#define instance_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their bounding box touching a given rectangle
		Much better performance than manually performing 'place_meeting()' on every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x1), "bbox_left", _x2), "bbox_bottom", _y1), "bbox_top", _y2);
	
#define instance_random(_obj)
	/*
		Returns a random instance of the given object
		Also accepts an array of instances
	*/
	
	var	_inst = instances_matching(_obj, "", null),
		_size = array_length(_inst);
		
	return (
		(_size > 0)
		? _inst[irandom(_size - 1)]
		: noone
	);
	
#define obj_create(_x, _y, _obj)                                            	return	mod_script_call_nc('mod', 'metamorphosis', 'obj_create', _x, _y, _obj);
#define haste(amt, pow)                                            	    		return mod_script_call('mod', 'metamorphosis', 'haste', amt, pow);