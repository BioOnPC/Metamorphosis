#define init
	global.sprSkillIcon = sprite_add("../../sprites/Icons/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../../sprites/HUD/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "GRAZZROOT ACTIVSM";
#define skill_text    return "@wSHELLS@s DUPLICATE ON#THE FIRST BOUNCE";
#define skill_tip     return "RESIST";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take    
	sound_play(sndBasicUltra);
	skill_set("vote2bcool", 0);
#define skill_avail   return 0; // Disable from appearing in normal mutation pool
#define skill_ultra   return -1; // Doesn't show up
#define step
	with(instances_matching(instances_matching(instances_matching_ne(projectile, "wallbounce", null), "creator", Player), "grassroots", null)) {
		var hbox_w = sprite_get_width(mask_index)/2,
			hbox_h = sprite_get_height(mask_index)/2;
		if(array_length(instance_rectangle_bbox(x + hspeed - hbox_w, y + vspeed - hbox_h, x + hspeed + hbox_w, y + vspeed + hbox_h, Wall)) > 0 or
		   array_length(instance_rectangle_bbox(x - hspeed - hbox_w, y - vspeed - hbox_h, x - hspeed + hbox_w, y - vspeed + hbox_h, Wall)) > 0) {
			grassroots = "yeah!";
			sound_play_pitch(sndPillarBreak, 1.4 + random(0.3) + (damage/10));
			sound_play_pitch(sndPlantSnare, 0.8 + random(0.3)  + (damage/10));
			sound_play_pitch(sndGuitar, 1.2 + random(0.3)  + (damage/10));
			sleep(1);
			
			direction += 20;
			image_angle += 20;
			
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
		}
	}

#define instance_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their bounding box touching a given rectangle
		Much better performance than manually performing 'place_meeting()' on every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x1), "bbox_left", _x2), "bbox_bottom", _y1), "bbox_top", _y2);	

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