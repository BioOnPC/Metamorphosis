#define init
	global.sprSkillIcon     		= sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD      		= sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sprGoldAmmo              = sprite_add("sprites/VFX/sprGoldAmmo.png",     		 7, 5,  5);
	global.sprGoldFatAmmo           = sprite_add("sprites/VFX/sprGoldFatAmmo.png",  		 7, 6,  6);
	global.sprGoldAmmoChest         = sprite_add("sprites/VFX/sprGoldAmmoChest.png",		 7, 12, 8);
	global.sprGoldAmmoChestSteroids = sprite_add("sprites/VFX/sprGoldAmmoChestSteroids.png", 7, 12, 8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "RICH TASTES";
#define skill_text    return "@yAMMO@s SOMETIMES @wHASTENS@s YOU#@wHASTENED @yGOLDEN WEAPONS";
#define skill_tip     return "GOLDEN GRILL";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}

#define step
	with(Player) {
		if(weapon_get_gold(wep) or (race = "steroids" and weapon_get_gold(bwep))) {
			mod_script_call("mod", "metamorphosis", "haste", 10, 0.6);
		}
	}
	
	with(instances_matching(instances_matching([AmmoChest, AmmoPickup], "richtastes", null), "sprite_index", sprAmmo, sprAmmoChest, sprAmmoChestMystery, sprAmmoChestSteroids)) {
		richtastes = "might be";
		if(random(8) < skill_get(mod_current)) {
			if(sprite_index = sprAmmo) sprite_index = (skill_get("magfingers") ? global.sprGoldFatAmmo : global.sprGoldAmmo);
			else if(object_index = AmmoChest) sprite_index = (sprite_index = sprAmmoChestSteroids ? global.sprGoldAmmoChestSteroids : global.sprGoldAmmoChest);
			
			with(obj_create(x, y, "RichPickup")) {
				creator = other.id;
				mask_index = other.mask_index;
			}
		}
	}
	
	with(instances_matching([WeaponChest, WepPickup], "richtastes", null)) {
		richtastes = ":)";
		
		if(object_index != BigWeaponChest) {
			if(object_index = WeaponChest) {
				if(random(50) < skill_get(mod_current)) {
					instance_create(x, y, GoldChest);
					instance_delete(self);
				}
			} 
			
			else if(random(30) < (0.5+0.5*skill_get(mod_current)) and (weapon_get_area(wep) > -1 and weapon_get_area(wep) <= 4)) {
				var p = instance_nearest(x, y, Player);
				if(instance_exists(p)) wep = weapon_decide(0, 10, true, [p.wep, p.bwep]);
			}
		}
	}
	
#define obj_create(_x, _y, _obj)                                            	return	mod_script_call_nc('mod', 'metamorphosis', 'obj_create', _x, _y, _obj);

#define weapon_decide(_hardMin, _hardMax, _gold, _noWep)
	/*
		Returns a random weapon that spawns within the given difficulties
		Takes standard weapon chest spawning conditions into account
		
		Ex:
			wep = weapon_decide(0, GameCont.hard, false, [wep, bwep]);
	*/
	
	 // Robot:
	for(var i = 0; i < maxp; i++) if(player_get_race(i) == "robot") _hardMax++;
	_hardMin += (5 * ultra_get("robot", 1));
	
	 // Just in Case:
	_hardMax = max(0, _hardMax);
	_hardMin = min(_hardMin, _hardMax);
	
	 // Default:
	var _wepDecide = wep_screwdriver;
	if(_gold != 0){
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
