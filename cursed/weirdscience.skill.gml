#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.level_start = false;
	global.sndSkillSlct = sound_add("../sounds/Cursed/sndCurse" + string_upper(string(mod_current)) + ".ogg");

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "WEIRD SCIENCE";
#define skill_text    return "KILLS ARE SOMETIMES @gVIOLENTLY DOUBLED@s";
#define skill_tip     return "IT'S ALIVE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_type    return "cursed";
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play_pitch(sndCursedChest, 1.2);
		sound_play(sndBigCursedChest);
		sound_play(global.sndSkillSlct);
	}

#define skill_avail   return false;
#define skill_cursed  return true; // for metamorphosis

#define step
	with(instances_matching_le(enemy, "my_health", 0)) {
		if(call(scr.chance, 1, min(max(maxhealth * 0.25, 3), 15))) {
			with(instance_copy(false)){
				with(variable_instance_get_names(self)){
					var	_value = variable_instance_get(other, self),
						_clone = data_clone(_value);
						
					if(_value != _clone){
						variable_instance_set(other, self, _clone);
					}
				}
				
				motion_add(direction - 30, speed);
			}
			
			sleep(maxhealth);
			
			repeat(2 + irandom(2)) with(call(scr.projectile_create, self, x + call(scr.orandom, sprite_width/3), y + call(scr.orandom, sprite_height/3), SmallExplosion)) {
				sprite_index = sprExploderExplo;
				mask_index   = mskSmallExplosion;
				team = -1;
			}
			
			repeat(3 + irandom(2)) with(call(scr.projectile_create, self, x + call(scr.orandom, sprite_width/3), y + call(scr.orandom, sprite_height/3), ThroneBeam, random(360), 2 + random(2))) {
				sprite_index = sprExploGuardianBullet;
				team = -1;
			}
			
			motion_add(direction + 30, speed);
			
			sound_play_pitch(sndWheelPileBreak, 1.5 + random(0.3));
			sound_play_pitch(sndToxicBoltGas, 1.8 + random(0.4));
			sound_play_pitch(sndFreakPopoRevive, 1.2 + random(0.4));
			sound_play_pitch(sndBloodLauncher, 0.6 + random(0.2));
		}
	}

#define data_clone(_value)
	/*
		Returns an exact copy of the given value
	*/
	
	if(is_array(_value)){
		return array_clone(_value);
	}
	if(is_object(_value)){
		return lq_clone(_value);
	}
	if(ds_list_valid(_value)){
		return ds_list_clone(_value);
	}
	if(ds_map_valid(_value)){
		return ds_map_clone(_value);
	}
	if(ds_grid_valid(_value)){
		return ds_grid_clone(_value);
	}
	if(surface_exists(_value)){
		return surface_clone(_value);
	}
	
	return _value;
	
#define ds_list_clone(_list)
	/*
		Returns an exact copy of the given ds_list
	*/
	
	var _new = ds_list_create();
	
	ds_list_add_array(_new, ds_list_to_array(_list));
	
	return _new;
	
#define ds_map_clone(_map)
	/*
		Returns an exact copy of the given ds_map
	*/
	
	var _new = ds_map_create();
	
	with(ds_map_keys(_map)){
		_new[? self] = _map[? self];
	}
	
	return _new;
	
#define ds_grid_clone(_grid)
	/*
		Returns an exact copy of the given ds_grid
	*/
	
	var	_w   = ds_grid_width(_grid),
		_h   = ds_grid_height(_grid),
		_new = ds_grid_create(_w, _h);
		
	for(var _x = 0; _x < _w; _x++){
		for(var _y = 0; _y < _h; _y++){
			_new[# _x, _y] = _grid[# _x, _y];
		}
	}
	
	return _new;
	
#define surface_clone(_surf)
	/*
		Returns an exact copy of the given surface
	*/
	
	var _new = surface_create(surface_get_width(_surf), surface_get_height(_surf));
	
	surface_set_target(_new);
	draw_clear_alpha(0, 0);
	draw_surface(_surf, 0, 0);
	surface_reset_target();
	
	return _new;

#macro  scr																						mod_variable_get("mod", "metamorphosis", "scr")
#macro  call																					script_ref_call