#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.level_start = false;

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "WEIRD SCIENCE";
#define skill_text    return "@pSPLIT DEAD ENEMIES IN TWO@s#ENEMIES @rHEAL@s OVER TIME";
#define skill_tip     return "IT'S ALIVE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut); //sound_mutation_play();
#define skill_avail   return false;
#define skill_cursed  return true; // for metamorphosis

#define step
	with(instances_matching_le(enemy, "my_health", 0)) {
		if(random(min(20, maxhealth + 1)) < 1) {
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
			
			motion_add(direction + 30, speed);
			
			instance_create(x, y, ExploderExplo);
			sound_play_pitch(sndWheelPileBreak, 1.5 + random(0.3));
			sound_play_pitch(sndToxicBoltGas, 1.8 + random(0.4));
		}
	}
	
    if((current_frame % (40 + (skill_get(mod_current) * 10))) < current_time_scale) {
    	var amt = 0;
    	with(enemy) {
    		if(my_health < maxhealth) {
    			my_health += min(maxhealth - my_health, 5 + (instance_exists(GameCont) ? GameCont.loops : 0));
    			amt++;
    			instance_create(x, y, BloodLust);
    		}
    	}
    	
    	if(amt > 0) {
    		sound_play_pitch(sndHitFlesh, 2.4 + random(0.4));
    		sound_play_pitch(sndBoltHitWall, 1.7 + random(0.3));
    		sound_play_pitch(sndMeatExplo, 2.4 + random(0.4));
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