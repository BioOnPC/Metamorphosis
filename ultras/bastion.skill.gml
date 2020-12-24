#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "BASTION";
#define skill_text    return "@wSHIELD STORES REFLECTED BULLETS@s#@wUNSHIELDING@s FIRES STORED BULLETS";
#define skill_tip     return "SHRUG IT OFF";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take    sound_play(sndBasicUltra);
#define skill_ultra   return "crystal";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	var _skill = skill_get(mod_current);

	 // Store Projectiles:
	with(CrystalShield){
		var c = creator;
		
		 // Slower Shield Decay:
		time -= current_time_scale / 2;
		
		if(instance_exists(c)){ // If the player exists
			if("bastion_projectiles" not in c){ // Create the array to store projectiles in
				c.bastion_projectiles = [];
			}
			with(instances_matching(instances_matching(projectile, "team", team), "deflected", 1)){ // Locate projectiles that have been reflected
				if(("bastion_deflected" not in self or bastion_deflected = false) and point_distance(x, y, other.x, other.y) < 48){ // Double check to make sure they're close to the shield
					array_push(c.bastion_projectiles, variable_instance_get_list(id)); // Add them to the list
					
					 // Effects:
					sleep(4);
					sound_play_pitch(sndDiscDie, 1 + (array_length(c.bastion_projectiles)/10));
					
					 // Goodbye:
					mod_script_call("skill", "selectivefocus", "selectivefocus_destroy");
				}
			}
		}
	}
	
	 // Release Projectiles:
	with(CrystalShieldDisappear){
		with(creator){
			var _num = array_length(bastion_projectiles),
				_dir = gunangle,
				_cx = x,
				_cy = y;
				
			if(_num > 0){ // Make sure you actually got projectiles to fire
				with(bastion_projectiles){
					repeat(1 + irandom((2 * _skill) / _num)){ // Sometimes double the projectiles released
						var o = instance_create(x, y, object_index);
						variable_instance_set_list(o, self);
						
						 // Manually Set Specific Variables:
						with(o){
							bastion_deflected = true;
							
							var n = 8 + (_num / 3),
								r = lerp((n * _skill), n, 2/3);
								
							x = _cx + orandom(r);
							y = _cy + orandom(r);
							
							var _dirOff  = _dir - direction;
							direction	+= _dirOff;
							image_angle += _dirOff;
							
							speed	 *= random_range(0.8, 1.2);
							friction *= random_range(0.8, 1.2);
						}
						
						 // Effects:
						sleep(12);
					}
					
					 // SFX
					sound_play_pitch(sndWallBreakCrystal, 1.8 + orandom(0.4));
					sound_play_pitch(sndShielderDeflect, 2.2 + orandom(0.4));
					sound_play_pitch(sndSpiderMelee, 1.4 + orandom(0.4));
				}
				bastion_projectiles = [];
			}
		}
	}

#define orandom(_num)
	return irandom_range(-_num, _num);

#define variable_instance_get_list(_inst)
    /*
        Returns all of a given instance's variable names and values as a LWO
    */
    
    var _list = {};
    
    with(variable_instance_get_names(_inst)){
        lq_set(_list, self, variable_instance_get(_inst, self));
    }
    
    return _list;
    
#define variable_instance_set_list(_inst, _list)
    /*
        Sets all of a given LWO's variable names and values on a given instance
    */
    
    if(instance_exists(_inst)){
        var    _listMax  = lq_size(_list),
            _isCustom = (string_pos("Custom", object_get_name(_inst.object_index)) == 1);
            
        for(var i = 0; i < _listMax; i++){
            var _name = lq_get_key(_list, i);
            if(!variable_is_readonly(_inst, _name)){
                if(_isCustom && string_pos("on_", _name) == 1){
                    if(variable_instance_get(_inst, _name) != lq_get_value(_list, i)){
                        try variable_instance_set(_inst, _name, lq_get_value(_list, i));
                        catch(_error){}
                    }
                }
                else variable_instance_set(_inst, _name, lq_get_value(_list, i));
            }
        }
    }
    
#define variable_is_readonly(_inst, _varName)
    /*
        Returns 'true' if the given variable on the given instance is read-only, 'false' otherwise
    */
    
    if(array_exists(["id", "object_index", "bbox_bottom", "bbox_top", "bbox_right", "bbox_left", "image_number", "sprite_yoffset", "sprite_xoffset", "sprite_height", "sprite_width"], _varName)){
        return true;
    }
    
    if(instance_is(_inst, Player)){
        if(array_exists(["p", "index", "alias"], _varName)){
            return true;
        }
    }
    
    return false;

#define array_exists(_array, _value)
    return (array_find_index(_array, _value) >= 0);