#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	global.visits = 0;
	global.level_start = false;

#define skill_name    return "THINK TANK";
#define skill_text    return "AN EXTRA @wCHEST@s SPAWNS#FOR EVERY AREA YOU'VE VISITED";
#define skill_tip     return "AD HOMINEM";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_type    return "ammo";
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
		//global.visits = 1;
	}
	
	else {
		if(!instance_exists(GenCont) and !instance_exists(LevCont)) place_chests(global.visits);
	}

#define place_chests(amt)
	var c = choose(WeaponChest, AmmoChest, RadChest),
		f = instances_matching(Floor, "", null),
		rf = f[irandom_range(0, array_length(f) - 1)];
	
	repeat(amt) {
		c = choose(WeaponChest, AmmoChest, RadChest);
		rf = f[irandom_range(0, array_length(f) - 1)];
		with(instance_create(rf.x + (rf.sprite_width/2), rf.y + (rf.sprite_height/2), c)) {
			instance_budge([chestprop, RadChest, hitme]);
			with(instances_meeting(x, y, Wall)) {
				instance_create(x, y, FloorExplo);
				instance_destroy();
			}
		}
	}

#define instance_budge(_objAvoid)
	/*
		Moves the current instance to the nearest space within the given distance that isn't touching the given object
		Also avoids moving an instance outside of the level if they were touching a Floor
		Returns 'true' if the instance was moved to an open space, 'false' otherwise
		
		Args:
			objAvoid - The object(s) or instance(s) to avoid
			disMax   - The maximum distance that the current instance can be moved
			           Use -1 to automatically determine the distance using the bounding boxes of the current instance and objAvoid
	*/
	
	var	_isArray  = is_array(_objAvoid),
		_inLevel  = !place_meeting(xprevious, yprevious, Floor),
		_disAdd   = 4,
		_dirStart = 0,
		_disMax   = 0;
		
	var	_w = 0,
		_h = 0;
		
	with(_isArray ? _objAvoid : [_objAvoid]){
		if(object_exists(self)){
			var _mask = object_get_mask(self);
			if(_mask < 0){
				_mask = object_get_sprite(self);
			}
			_w = max(_w, (sprite_get_bbox_right(_mask)  + 1) - sprite_get_bbox_left(_mask));
			_h = max(_h, (sprite_get_bbox_bottom(_mask) + 1) - sprite_get_bbox_top(_mask));
		}
		else{
			_w = max(_w, sprite_width);
			_h = max(_h, sprite_height);
		}
	}
	
	_disMax = sqrt(sqr(sprite_width + _w) + sqr(sprite_height + _h)) + _disAdd;
	
	 // Starting Direction:
	if(x != xprevious || y != yprevious){
		_dirStart = point_direction(x, y, xprevious, yprevious);
	}
	else{
		_dirStart = point_direction(hspeed, vspeed, 0, 0);
	}
	
	 // Search for Open Space:
	var _dis = 0;
	while(_dis <= _disMax){
		 // Look Around:
		var _dirAdd = 360 / max(1, 4 * _dis);
		for(var _dir = _dirStart; _dir < _dirStart + 360; _dir += _dirAdd){
			var	_x = x + lengthdir_x(_dis, _dir),
				_y = y + lengthdir_y(_dis, _dir);
				
			if(_isArray ? !array_length(instances_meeting(_x, _y, _objAvoid)) : !place_meeting(_x, _y, _objAvoid)){
				if(_inLevel || (place_free(_x, _y) && (position_meeting(_x, _y, Floor) || place_meeting(_x, _y, Floor)))){
					x = _x;
					y = _y;
					xprevious = x;
					yprevious = y;
					
					return true;
				}
			}
		}
		
		 // Go Outward:
		if(_dis >= _disMax) break;
		_dis = min(_dis + clamp(_dis, 1, _disAdd), _disMax);
	}
	
	return false;

#define instances_meeting(_x, _y, _obj)
	/*
		Returns all instances whose bounding boxes overlap the calling instance's bounding box at the given position
		Much better performance than manually performing 'place_meeting(x, y, other)' on every instance
	*/
	
	var	_tx = x,
		_ty = y;
		
	x = _x;
	y = _y;
	
	var _inst = instances_matching_ne(instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", bbox_left), "bbox_left", bbox_right), "bbox_bottom", bbox_top), "bbox_top", bbox_bottom), "id", id);
	
	x = _tx;
	y = _ty;
	
	return _inst;