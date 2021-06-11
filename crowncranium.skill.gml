#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	global.newLevel = false;
	global.draw = noone;

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
			case "horror":   t += "EXTRA @gMUTATION@s CHOICE"; break;
			case "rogue":    t += "@wENEMIES@s AND @bIDPD@s#DROP @bPORTAL STRIKES"; break;
			case "skeleton": t += "KILLING CAN CREATE#FRIENDLY @pNECRO@s CIRCLES"; break;
			case "frog":     t += "@wHASTENED@s BOUNCES"; break;
			case "parrot":   t += "@wPETS MOVE FASTER@s"; break;
		}
		
		if(race_id > 16 and mod_script_exists("race", race, "race_cc_text")) t += mod_script_call("race", race, "race_cc_text");
		
		t += "#";
	}
	
	if(t = "") t += "UPGRADES YOUR PASSIVE ABILITY";
	
	return t;

#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}
	var raceList = [];
	with(Player) {
		if(array_find_index(raceList, race) == -1){
			array_push(raceList, race);
		}
	}

	for(var i = 0; i < array_length(raceList); i++){
		switch(raceList[i]){
			default:
				with(instances_matching_gt(instances_matching(Player, "race", raceList[i]), "race_id", 16)) {
					if(mod_script_exists("race", raceList[i], "race_cc_take")) mod_script_call("race", raceList[i], "race_cc_take");
				}
			break;
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
	
#define cleanup
	//unbind the draw script
	with(global.draw){
		instance_destroy();
	}
    
#define step
    // I'll make my own draw event! With blackjack and hookers!
    if(!instance_exists(global.draw)){
        global.draw = script_bind_draw(draw, -8);
    }
	
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
												instance_create(x, y, BulletHit).sprite_index = sprDiscDisappear;
												sound_play_pitchvol(sndPickupDisappear, 1.4 + random(0.3), 0.7);
												sound_play_pitchvol(sndCrystalShield, 0.8 + random(0.2), 0.5);
												sound_play_pitchvol(sndShielderDeflect, 1.6 + random(0.1), 0.4);
											}
										}
										with(instance_rectangle_bbox(x-50,y-50,x+50,y+50, enemy)){
											motion_add(point_direction(other.x,other.y,x,y), 4);
											instance_create(x - hspeed, y - vspeed, Dust);
										}
										
										sound_play_pitchvol(sndWallBreakCrystal, 1.7 + random(0.3), 0.6);
										sound_play_pitch(sndCrystalPropBreak, 1.4 + random(0.2));
										sound_play_pitch(sndCrystalRicochet, 1.2 + random(0.4));
										
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
							if(irandom(4/current_time_scale) == 0) {
								instance_create(x, y, Dust).depth = depth + 1;
								sound_play_pitchvol(sndPortalFlyby1, 1.4 + random(0.2), 0.4);
								sound_play_pitchvol(sndPortalFlyby2, 2.4 + random(0.2), 0.4);
							}
						}
					}
					break;
				case "plant":
					if(instance_exists(enemy)){
						with(Player) {
							if("craniumplant" not in self){
								craniumplant = 0;		//how much plant has moved for charging
								craniumplantcharge = 0;	//how much plant has killed for charging
								craniumplantvisual = 0;	//how long the visual indicator for charge should show
							}
							
							//create charge when enemies die
							with(instances_matching_le(enemy, "my_health", 0)){
								other.craniumplantcharge += maxhealth;
								if(ceil(other.craniumplantcharge*6/50) > ceil((other.craniumplantcharge - maxhealth)*6/50)){
									other.craniumplantvisual = 30;
								}
							}
							
							//only charge up the next plant when you have enough charge to spawn it
							if(craniumplantcharge > 50 && fork()){
								var _x = x;
								var _y = y;
								wait(0);
								if(instance_exists(self)) craniumplant += point_distance(x,y,_x,_y);
								exit;
							}
							
							//if they've moved the equivalent of 40 tiles (wall width) and have enough charge spawn a sapling
							if(craniumplantcharge > 50 && craniumplant > 40 * 12){
								craniumplantcharge -= 50;
								craniumplant -= 40 * 12;
								other.craniumplantvisual = 30;
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
								with(instance_copy(false)) {
									wep = weapon_decide(weapon_get_area(wep), weapon_get_area(wep) + 3, false);
								}
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
					with(instances_matching(instances_matching(Corpse, "speed", 0), "skelenecro", null)){
						skelenecro = true;
						if(irandom(8) == 0){
							with(obj_create(x, y, "FriendlyNecro")){
								creator = instance_nearest(x, y, Player);
								team = creator.team;
							}
							
							sound_play_pitch(sndFreakPopoRevive, 1.4 + random(0.2));
							sound_play_pitch(sndCorpseExploDead, 1.6 + random(0.2));
							sound_play_pitch(sndMeatExplo, 0.7 + random(0.3));
							sound_play_pitch(sndBloodLauncherExplo, 1.6 + random(0.3));
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

#define draw
//plant crown cranium
with(instances_matching_ge(Player, "craniumplantvisual", 1)){
	draw_set_alpha(min(craniumplantvisual/10, 1));

	var bubble1 = ceil(6-max(min(craniumplantcharge*6/50, 6), 0));
	draw_set_color(make_color_rgb(255,150,150));
	draw_rectangle(x - 5, y - 18, x - 2, y - 15, 0);
	draw_sprite_part_ext(sprBubble, 2, 0, 0, sprite_get_width(sprBubble), sprite_get_height(sprBubble), x - 7, y - 20, 1, 1, make_color_rgb(255,150,175), min(craniumplantvisual/10, 1));
	if(bubble1 < 6){
		draw_set_color(make_color_rgb(225,0,0));
		draw_rectangle(x - 5, y - 18 + ceil(bubble1/2), x - 2, y - 15, 0);
		draw_sprite_part_ext(sprBubble, 2, 0, bubble1, sprite_get_width(sprBubble), sprite_get_height(sprBubble)-bubble1, x - 7, y - 20 + bubble1, 1, 1, c_red, min(craniumplantvisual/10, 1));
	}
	
	var bubble2 = ceil(6-max(min((craniumplantcharge-50)*6/50, 6), 0));
	draw_set_color(make_color_rgb(255,150,150));
	draw_rectangle(x + 3, y - 18, x + 6, y - 15, 0);
	draw_sprite_part_ext(sprBubble, 2, 0, 0, sprite_get_width(sprBubble), sprite_get_height(sprBubble), x + 1, y - 20, 1, 1, make_color_rgb(255,150,175), min(craniumplantvisual/10, 1));
	if(bubble2 < 6){
		draw_set_color(make_color_rgb(225,0,0));
		draw_rectangle(x + 3, y - 18 + ceil(bubble2/2), x + 6, y - 15, 0);
		draw_sprite_part_ext(sprBubble, 2, 0, bubble2, sprite_get_width(sprBubble), sprite_get_height(sprBubble)-bubble2, x + 1, y - 20 + bubble2, 1, 1, c_red, min(craniumplantvisual/10, 1));
	}
	
	draw_set_alpha(1);
	
	craniumplantvisual--;
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
	
#define weapon_decide // hardMin=0, hardMax=GameCont.hard, gold=false, ?noWep
	/*
		Returns a random weapon that spawns within the given difficulties
		Takes standard weapon chest spawning conditions into account
		
		Args:
			hardMin - The minimum weapon spawning difficulty, defaults to 0
			hardMax - The maximum weapon spawning difficulty, defaults to GameCont.hard
			gold    - Spawn golden weapons like a mansion chest (true), or not (false, default)
			          Use -1 to completely exclude golden weapons
			noWep   - Optional, a weapon or array of weapons to exclude from spawning
			
		Ex:
			wep = weapon_decide();
			wep = weapon_decide(0, 1 + (2 * curse) + GameCont.hard);
			wep = weapon_decide(2, GameCont.hard, false, [p.wep, p.bwep]);
	*/
	
	var	_hardMin = ((argument_count > 0) ? argument[0] : 0),
		_hardMax = ((argument_count > 1) ? argument[1] : GameCont.hard),
		_gold    = ((argument_count > 2) ? argument[2] : false),
		_noWep   = ((argument_count > 3) ? argument[3] : undefined);
		
	 // Hardmode:
	_hardMax += ceil((GameCont.hard - (UberCont.hardmode * 13)) / (1 + (UberCont.hardmode * 2))) - GameCont.hard;
	
	 // Robot:
	for(var i = 0; i < maxp; i++){
		if(player_get_race(i) == "robot"){
			_hardMax++;
		}
	}
	_hardMin += 5 * ultra_get("robot", 1);
	
	 // Just in Case:
	_hardMax = max(0, _hardMax);
	_hardMin = min(_hardMin, _hardMax);
	
	 // Default:
	var _wepDecide = wep_screwdriver;
	if("wep" in self && wep != wep_none){
		_wepDecide = wep;
	}
	else if(_gold > 0){
		_wepDecide = choose(wep_golden_wrench, wep_golden_machinegun, wep_golden_shotgun, wep_golden_crossbow, wep_golden_grenade_launcher, wep_golden_laser_pistol);
		if(GameCont.loops > 0 && random(2) < 1){
			_wepDecide = choose(wep_golden_screwdriver, wep_golden_assault_rifle, wep_golden_slugger, wep_golden_splinter_gun, wep_golden_bazooka, wep_golden_plasma_gun);
		}
	}
	
	 // Decide:
	var	_list    = ds_list_create(),
		_listMax = weapon_get_list(_list, _hardMin, _hardMax);
		
	ds_list_shuffle(_list);
	
	for(var i = 0; i < _listMax; i++){
		var	_wep    = ds_list_find_value(_list, i),
			_canWep = true;
			
		 // Weapon Exceptions:
		if(_wep == _noWep || (is_array(_noWep) && array_find_index(_noWep, _wep) >= 0)){
			_canWep = false;
		}
		
		 // Gold Check:
		else if((_gold > 0 && !weapon_get_gold(_wep)) || (_gold < 0 && weapon_get_gold(_wep) == 0)){
			_canWep = false;
		}
		
		 // Specific Spawn Conditions:
		else switch(_wep){
			case wep_super_disc_gun       : if("curse" not in self || curse <= 0) _canWep = false; break;
			case wep_golden_nuke_launcher : if(!UberCont.hardmode)                _canWep = false; break;
			case wep_golden_disc_gun      : if(!UberCont.hardmode)                _canWep = false; break;
			case wep_gun_gun              : if(crown_current != crwn_guns)        _canWep = false; break;
		}
		
		 // Success:
		if(_canWep){
			_wepDecide = _wep;
			break;
		}
	}
	
	ds_list_destroy(_list);
	
	return _wepDecide;
	
#define obj_create(_x, _y, _obj)                                            	return	mod_script_call_nc('mod', 'metamorphosis', 'obj_create', _x, _y, _obj);
#define haste(amt, pow)                                            	    		return mod_script_call('mod', 'metamorphosis', 'haste', amt, pow);
#define option_set(opt, val)													return mod_script_call("mod", "metamorphosis", "option_set", opt, val);