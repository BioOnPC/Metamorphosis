#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "DIVIDED ELBOWS";
#define skill_text    return "@wALL PROJECTILES@s CAN BE @wREFLECTED@s#DUPLICATE @wREFLECTED PROJECTILES@s";
#define skill_tip     return "GET OUTTA HERE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_type    return "offensive";
#define skill_wepspec return 1;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}
	
#define step
    with(projectile) {
    	if(("creator" not in self or (!instance_exists(creator) or creator.object_index != Player)) and speed != 0 and typ > 1) typ = 1;
    	
    	if(!variable_instance_exists(self, "lstteam")) lstteam = team;
	    if(instance_exists(Player) and lstteam != team and instance_nearest(x, y, Player).team = team) {
	    	direction += 10 * skill_get(mod_current);
	    	image_angle += 10 * skill_get(mod_current);
	    	lstteam = team;
	    	
	    	 // Stolen from NTTE's "instance_clone". Yokin is epic, give the NTTE money, etc. etc
			var dir = -10 * skill_get(mod_current);
			repeat(skill_get(mod_current)){
				with(instance_copy(false)){
					with(variable_instance_get_names(self)){
						var	_value = variable_instance_get(other, self),
							_clone = data_clone(_value);
							
						if(_value != _clone){
							variable_instance_set(other, self, _clone);
						}
					}
					
					direction += dir;
					image_angle += dir;
					dir += 10;
				}
			}
			
			with(instance_create(x, y, GuardianDeflect)) mask_index = mskNone;
			sound_play(sndCocoonBreak);
			
			view_shake_max_at(x, y, 5 * damage);
			sleep(2 * damage);
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