 //				--- BASE NTT SCRIPTS ---			//
#define init
	 // MUTATION EFFECTS //
	global.sprMedpack = sprite_add("sprites/VFX/sprFatHP.png",  7,  6,  6);
	
	 // SHOP SPRITES //
	global.sprWallMerchantBot   = sprite_add("sprites/Shop/sprWallMerchantBot.png",  6,  0,  0);
	global.sprWallMerchantOut   = sprite_add("sprites/Shop/sprWallMerchantOut.png",  1,  4,  4);
	global.sprWallMerchantTop   = sprite_add("sprites/Shop/sprWallMerchantTop.png",  9,  0,  0);
	global.sprWallMerchantTrans = sprite_add("sprites/Shop/sprWallMerchantTrans.png",  6,  0,  0);
	global.sprMerchantFloor     = sprite_add("sprites/Shop/sprMerchantFloor.png",  4,  0,  0);
	global.sprMerchantCarpet    = sprite_add("sprites/Shop/sprMerchantCarpet.png",  1,  83,  34);
	
#macro mod_current_type script_ref_create(0)[0]
#macro infinity 1/0

 // Custom Instance Macros:
#macro CrystallineEffect instances_matching(CustomObject, "name", "CrystallineEffect")
#macro CrystallinePickup instances_matching(CustomObject, "name", "CrystallinePickup")
	
#define step
    if(skill_get(mut_second_stomach)) { // Make Second Stomach medkits bigger
        with(instances_matching_ne(HPPickup, "sprite_index", global.sprMedpack)) {
            sprite_index = global.sprMedpack;
        }
    }
    
     // LEVEL GEN BULLSHIT
    if(instance_exists(GenCont) and GenCont.alarm0 > 0 and GenCont.alarm0 <= ceil(current_time_scale)) { // this checks to make sure the level is *mostly* generated, save for *most* props. for example, this will find the Crown Pedestal in the Vaults, but won't find any torches.
    	
    	 // place the shop area in the crown vault
    	with(CrownPed) {
    		 // Find the furthest floor in the crown vault and find the direction its in, rounded to 90 degrees
    		var ffloor = instance_furthest(x, y, Floor),
    			shop_dir = grid_lock(point_direction(x, y, ffloor.x, ffloor.y), 90);
			
			 // Place down floors.
			floor_fill(ffloor.x + lengthdir_x(128, shop_dir), ffloor.y + lengthdir_y(128, shop_dir), 5, 5);
			instance_create(ffloor.x + lengthdir_x(32, shop_dir), ffloor.y + lengthdir_y(32, shop_dir), Floor);
			
			 // Make the cool carpet!
			instance_create(ffloor.x + lengthdir_x(128, shop_dir) + 16, ffloor.y + lengthdir_y(128, shop_dir) + 16, VenuzCarpet).sprite_index = global.sprMerchantCarpet;
			
			if(fork()) {
				wait 3; // Wait to make sure that everything generates
				
				with(Floor) { // Resprite floors
					if(point_distance(x, y, ffloor.x + lengthdir_x(128, shop_dir), ffloor.y + lengthdir_y(128, shop_dir)) < 96) {
						sprite_index = global.sprMerchantFloor;
					}
				}
				
				with(Wall) { // Resprite walls
					if(point_distance(x, y, ffloor.x + lengthdir_x(128, shop_dir), ffloor.y + lengthdir_y(128, shop_dir)) < 144) {
						topspr       = global.sprWallMerchantTop;
						topindex     = irandom(9);
						outspr       = global.sprWallMerchantOut;
						sprite_index = global.sprWallMerchantBot;
						image_index  = irandom(6);
					}
				}
				
				with(TopSmall) { // Resprite outside walls
					if(point_distance(x, y, ffloor.x + lengthdir_x(128, shop_dir), ffloor.y + lengthdir_y(128, shop_dir)) < 160) {
						sprite_index = global.sprWallMerchantTrans;
						image_index  = irandom(6);
					}
				}
				
				with(prop) { // Remove props
					if(point_distance(x, y, ffloor.x + lengthdir_x(128, shop_dir), ffloor.y + lengthdir_y(128, shop_dir)) < 96) {
						instance_delete(self);
					}
				}
			}
    	}
    }

#define draw
	if(skill_get("musclememory") > 0 and instance_exists(Player)) { // Color projectiles being dodged while Muscle Memory is active
		with(instances_matching_ne(projectile, "musclememory", null)) {
			var nplayer = instance_nearest(x, y, Player);
			if(team != nplayer.team) {
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_red, 1 - point_distance(x, y, nplayer.x, nplayer.y)/32);
			}
		}
	}
	
	
 //				--- OBJECT SCRIPTS ---			//
#define obj_create(_x, _y, _name)
	 // this is all yokin. he is a powerful mans
	
	 // Vanilla Objects:
	if(is_real(_name) && object_exists(_name)){
		return instance_create(_x, _y, _name);
	}
	
	 // Create Object:
	var o = noone;
	switch(_name){
		case "CrystallineEffect":
			o = instance_create(_x, _y, CustomObject);
			with(o){
				 // Vars:
				scale	= 2;
				blink   = true;
				colors  = [make_color_rgb(173, 80, 185), make_color_rgb(250, 138, 0)];
				creator = noone;
				
			}
			break;
		
		case "CrystallinePickup":
			o = instance_create(_x, _y, CustomObject);
			with(o){
				
				 // Vars:
				mask_index = mskPickup;
				creator    = noone;
				num		   = 1;
				
			}
			break;
		
		default: // Called with undefined - for use with Yokin's cheats mod
			return ["CrystallineEffect", "CrystallinePickup"];
	}
	
	 // Instance Stuff:
	with(o){
		name = _name;
	
		 // Auto Script Binding:
		with([
			
			 // General:
			"_begin_step",
			"_step",
			"_end_step",
			"_draw",
			"_destroy",
			"_cleanup",
			
			 // Hitme/Enemy:
			"_hurt",
			"_death",
			
			 // Projectile:
			"_anim",
			"_wall",
			"_hit",
			
			 // Slash:
			"_grenade",
			"_projectile"
		]){
			var _var =  "on" + self,
				_scr = _name + self;
				
			if(mod_script_exists(mod_current_type, mod_current, _scr)){
				var _ref = script_ref_create_ext(mod_current_type, mod_current, _scr);
				variable_instance_set(o, _var, _ref);
			}
		}
	}
	
	 // Important:
	return o;
	
#define CrystallineEffect_step
	if(instance_exists(creator) && creator.nexthurt > current_frame){
		var _time = creator.nexthurt - current_frame;
		
		blink = (_time < 20 && (_time % 2) == 0);
		scale = lerp(scale, 1, current_time_scale / 3);
		depth = creator.depth;
		
		 // Effects:
		if(random(3) < current_time_scale){
			with(
				instance_create(
					random_range(creator.bbox_left, creator.bbox_right), 
					random_range(creator.bbox_top,  creator.bbox_bottom), 
					CrystTrail
				)
			){
				sprite_index = (
					other.blink 
					? sprCrystTrailB 
					: sprCrystTrail
				);
				
				speed *= 2/3;
			}
		}
	}
	else{
		instance_destroy();
	}
	
#define CrystallineEffect_draw
	var _scale = scale;
	with(creator){
		if(visible){
			
			 // Store:
			var _xOff = orandom(2),
				_yOff = orandom(2);
				
			 // Set:
			draw_set_fog(true, other.colors[other.blink], 0, 0);
			x += _xOff;
			y += _yOff;
			image_xscale *= _scale;
			image_yscale *= _scale;
			
			 // The Magic:
			with(self) event_perform(ev_draw, 0);
			
			 // Reset:
			draw_set_fog(false, c_white, 0, 0);
			x -= _xOff;
			y -= _yOff;
			image_xscale /= _scale;
			image_yscale /= _scale;
		}
	}
	
#define CrystallinePickup_step
	if(!instance_exists(creator)){
		instance_destroy();
	}
	else{
		x = creator.x;
		y = creator.y;
	}
	
#define CrystallinePickup_destroy
	var _player = instance_nearest(x, y, Player);
	if(instance_exists(_player) && place_meeting(x, y, _player)){
		with(_player){
			var _duration = (
				other.num
				* (45 * current_time_scale)
				* skill_get("crystallinegrowths")
				+ (15 * skill_get("tougherstuff"))
			);
			nexthurt = current_frame + _duration;
			
			 // Effects:
			sleep(30);
			
			 // Player Effect:
			with(instances_matching(CrystallineEffect, "creator", id)){
				instance_destroy(); // prevent overlapping effects
			}
			with(obj_create(x, y, "CrystallineEffect")){
				creator = other;
				time	= _duration;
			}
		}
	}
	
  //				--- OTHER SCRIPTS ---			//
#define orandom(_num) return irandom_range(-_num, _num);

#define instance_near(_x, _y, _obj, _dis)
	/*
		Returns the nearest instance of the given object that is within the given distance of the given position
		
		Args:
			x/y - The position to check
			obj - An object, instance, or array of instances
			dis - The distance to check, can be a single number for max distance or a 2-element array for [min, max]
			
		Ex:
			instance_near(x, y, Player, 96)
			instance_near(x, y, instances_matching(hitme, "team", 2), [32, 64])
	*/
	
	var	_inst   = noone,
		_disMin = (is_array(_dis) ? _dis[0] : 0),
		_disMax = (is_array(_dis) ? _dis[1] : _dis);
		
	with(
		(is_real(_obj) && object_exists(_obj) && _disMin <= 0)
		? instance_nearest(_x, _y, _obj)
		: _obj
	){
		var _d = point_distance(_x, _y, x, y);
		if(_d <= _disMax && _d >= _disMin){
			_disMax = _d;
			_inst = id;
		}
	}
	
	return _inst;

#define instance_seen(_x, _y, _obj)
	/*
		Returns the nearest instance of the given object that is seen by the given position (no walls between)
		
		Args:
			x/y - The position to check
			obj - An object, instance, or array of instances
	*/
	
	var	_inst   = noone,
		_disMax = infinity;
		
	with(_obj){
		if(!collision_line(_x, _y, x, y, Wall, false, false)){
			var _dis = point_distance(_x, _y, x, y);
			if(_dis < _disMax){
				_disMax = _dis;
				_inst = id;
			}
		}
	}
	
	return _inst;

#define floor_fill(_x, _y, w, h)
	for(ix = -floor(w/2); ix < ceil(w/2); ix++) {
		for(iy = -floor(h/2); iy < ceil(h/2); iy++) {
			instance_create(grid_lock(_x, 32) + (ix * 32) + 16, grid_lock(_y, 32) + (iy * 32) + 16, Floor);
		}
	}

#define grid_lock(value, grid)
	return round(value/grid) * grid; // Returns the given value locked to the given grid size