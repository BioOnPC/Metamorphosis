#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkillDividedElbowsIcon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkillDividedElbowsHUD.png",  1,  8,  8);

#define skill_name    return "DIVIDED ELBOWS";
#define skill_text    return "@wREFLECTED PROJECTILES@s#ARE DUPLICATED";
#define skill_tip     return "GET OUTTA HERE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define step
    with(projectile) {
    	if(!variable_instance_exists(self, "lstteam")) lstteam = team;
	    if(lstteam != team) {
	    	direction += 20;
	    	image_angle += 20;
	    	lstteam = team;
	    	
	    	 // Stolen from NTTE's "instance_clone". Yokin is epic, give the NTTE money, etc. etc
	    	with(instance_copy(false)){
				with(variable_instance_get_names(self)){
					var	_value = variable_instance_get(other, self),
						_clone = data_clone(_value);
						
					if(_value != _clone){
						variable_instance_set(other, self, _clone);
					}
				}
				
				direction += -40;
		    	image_angle += -40;
			}
			
			with(instance_create(x, y, GuardianDeflect)) mask_index = mskNone;
			sound_play(sndCocoonBreak);
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