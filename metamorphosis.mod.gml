 //				--- BASE NTT SCRIPTS ---			//
#define init
	 // MUTATION EFFECTS //
	global.sprMedpack = sprite_add("sprites/VFX/sprFatHP.png",  7,  6,  6);
	global.sprSleep   = sprite_add("sprites/VFX/sprSleep.png",  1,  4,  4);
	
	 // SHOP SPRITES //
	global.sprWallMerchantBot   = sprite_add("sprites/Shop/sprWallMerchantBot.png",  6,  0,  0);
	global.sprWallMerchantOut   = sprite_add("sprites/Shop/sprWallMerchantOut.png",  1,  4,  4);
	global.sprWallMerchantTop   = sprite_add("sprites/Shop/sprWallMerchantTop.png",  9,  0,  0);
	global.sprWallMerchantTrans = sprite_add("sprites/Shop/sprWallMerchantTrans.png",  6,  0,  0);
	global.sprMerchantFloor     = sprite_add("sprites/Shop/sprMerchantFloor.png",  4,  0,  0);
	global.sprMerchantCarpet    = sprite_add("sprites/Shop/sprMerchantCarpet.png",  1,  83,  34);
	
	 // SHOPKEEP //
	global.sprMerchantIdle     = sprite_add("sprites/Shop/sprMerchantIdle.png", 15, 32, 32);
	global.sprMerchantPuff     = sprite_add("sprites/Shop/sprMerchantPuff.png", 12, 32, 32);

 // General Use Macros:
#macro mod_current_type script_ref_create(0)[0]
#macro bbox_center_x (bbox_left + bbox_right + 1) / 2
#macro bbox_center_y (bbox_top + bbox_bottom + 1) / 2
#macro infinity 1/0

 // Mod Macros:
#macro metacolor `@(color:${make_color_rgb(110, 140, 110)})`;
#macro minicolor `@(color:${make_color_rgb(183, 195, 204)})`;

 // Custom Instance Macros:
#macro CrystallineEffect instances_matching(CustomObject, "name", "CrystallineEffect")
#macro CrystallinePickup instances_matching(CustomObject, "name", "CrystallinePickup")
	
#define step
    if(skill_get(mut_second_stomach)) { // Make Second Stomach medkits bigger
        with(instances_matching_ne(HPPickup, "sprite_index", global.sprMedpack)) {
            sprite_index = global.sprMedpack;
        }
    }
    
    with(instances_matching_gt(GameCont, "loops", 1)) {
		if(!variable_instance_exists(self, "lstloop") or lstloop != loops) {
			lstloop = loops;
			skillpoints++;
			sound_play(sndLevelUp);
		}
    }
    
     // Some funky stuff to make sure the prompt acts on step. props to yokin for helping a ton and also letting me steal NTTE code
    if(array_length(instances_matching(CustomObject, "name", "Prompt")) > 0) script_bind_step(prompt_collision, 0);
    
     // LEVEL GEN BULLSHIT
    if(instance_exists(GenCont) and GenCont.alarm0 > 0 and GenCont.alarm0 <= room_speed) { // this checks to make sure the level is *mostly* generated, save for *most* props. for example, this will find the Crown Pedestal in the Vaults, but won't find any torches.
    	
    	 // for horror's ultra
    	if(skill_get("criticalmass") > 0) {
			 // Place down the mutation reselector
			if((GameCont.hard - mod_variable_get("skill", "criticalmass", "diff")) mod 3 = 0 and array_length(instances_matching(CustomProp, "name", "MutRefresher")) <= 0) {
				var ffloor = instance_furthest(0, 0, Floor);
				with(ffloor) obj_create(bbox_center_x, bbox_center_y, "MutRefresher");
			}
		}
    	
    	 // place the shop area in the crown vault
    	with(instances_matching(CrownPed, "shopping", null)) {
    		shopping = "i be";
    		
    		 // Find the furthest floor in the crown vault and find the direction its in, rounded to 90 degrees
    		var ffloor = instance_furthest(10016, 10016, Floor),
    			shop_dir = grid_lock(point_direction(x, y, ffloor.x, ffloor.y), 90);
			
			 // Place down floors.
			floor_fill(ffloor.x + lengthdir_x(128, shop_dir) - 64, ffloor.y + lengthdir_y(128, shop_dir) - 64, 5, 5);
			instance_create(ffloor.x + lengthdir_x(32, shop_dir), ffloor.y + lengthdir_y(32, shop_dir), Floor);
			
			 // Make the cool carpet!
			instance_create(ffloor.x + lengthdir_x(128, shop_dir) + 16, ffloor.y + lengthdir_y(128, shop_dir) + 16, VenuzCarpet).sprite_index = global.sprMerchantCarpet;
			
			if(fork()) {
				wait 3; // Wait to make sure that everything generates
				
				with(Floor) { // Resprite floors
					if(point_distance(x, y, ffloor.x + lengthdir_x(128, shop_dir), ffloor.y + lengthdir_y(128, shop_dir)) < 128) {
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
				
				 // Spawn da boys
				obj_create(ffloor.x + lengthdir_x(128, shop_dir) - 4, ffloor.y + lengthdir_y(128, shop_dir), "Shopkeep");
				obj_create(ffloor.x + lengthdir_x(128, shop_dir) + 36, ffloor.y + lengthdir_y(128, shop_dir), "Mutator");
			}
    	}
    	
    	with(instances_matching_ne(Player, "strengthtimer", null)) { // Chicken ultra
    		strengthtimer = 210 * skill_get("strengthindeath");
    	}
    }
    
     // tip moment
    with(instances_matching(GenCont, "metamorphosistip", null)) {
    	metamorphosistip = random(10);
    	
    	if(metamorphosistip < 1) {
    		tip = tip_generate();
    	}
    }

#define draw
	if(skill_get("grace") > 0 and instance_exists(Player)) { // Color projectiles being dodged while Muscle Memory is active
		with(instances_matching_ne(projectile, "grace", null)) {
			var nplayer = instance_nearest(x, y, Player);
			if(!(nplayer.race = "frog" and object_index = ToxicGas) and object_index != Flame and object_index != TrapFire and team != nplayer.team) {
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_red, 1 - point_distance(x, y, nplayer.x, nplayer.y)/32);
			}
		}
	}
	
	with(instance_rectangle_bbox(view_xview_nonsync - (game_width), 
								 view_yview_nonsync - (game_height), 
								 view_xview_nonsync + (game_width), 
								 view_yview_nonsync + (game_height), 
								 instances_matching_gt(instances_matching_ne(enemy, "leadsleep", null), "leadsleep", 0))) {
		var vis = 1;
		if(leadsleep <= room_speed) vis = leadsleep mod (4 * leadsleep);
		
		draw_sprite_ext(global.sprSleep, 1, x + 6, y - 8 - (sprite_get_height(sprite_index)/2) + sin((leadsleep + 20) * 0.1), 1, 1, sin((leadsleep + 20) * 0.1) * 10, c_white, vis);
		
		draw_sprite_ext(global.sprSleep, 1, x, y - 4 - (sprite_get_height(sprite_index)/2) + sin((leadsleep + 10) * 0.1), 1, 1, sin((leadsleep + 10) * 0.1) * 10, c_white, vis);
		
		draw_sprite_ext(global.sprSleep, 1, x - 6, y - (sprite_get_height(sprite_index)/2) + sin(leadsleep * 0.1), 1, 1, sin(leadsleep * 0.1) * 10, c_white, vis);
	}

#define draw_dark
	draw_set_color($808080);
	with(instances_matching(CustomProp, "name", "Shopkeep")) draw_circle(x, y, 30 + random(2), false);
	with(instances_matching(CustomProp, "name", "Mutator")) draw_circle(x, y, 60 + random(2), false);
	

#define draw_dark_end
	draw_set_color($000000);
	with(instances_matching(CustomProp, "name", "Shopkeep")) draw_circle(x, y, 20 + random(2), false);	
	with(instances_matching(CustomProp, "name", "Mutator")) draw_circle(x, y, 40 + random(2), false);

	
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
		
		case "Mutator":
			o = instance_create(_x, _y, CustomProp);
			with(o){
				 // Visual:
				spr_idle = sprProtoStatueIdle;
				spr_hurt = sprProtoStatueHurt;
				spr_dead = sprProtoStatueDoneDie;
				spr_shadow = shd64B;
				spr_shadow_y = 6;
				
				 // Sounds:
				snd_hurt = sndStatueHurt;
				snd_dead = sndStatueDead;
				
				 // Vars:
				mask_index = mskBanditBoss;
				maxhealth  = 60;
				my_health  = maxhealth;
				size       = 2;
				
				prompt = prompt_create("@gMODIFY");
				with(prompt){
					mask_index = mskReviveArea;
					yoff = -4;
				}
			}
			break;
		
		case "MutRefresher":
			o = instance_create(_x, _y, CustomProp);
			with(o){
				 // Visual:
				spr_idle = sprHorrorMenu;
				spr_hurt = sprMutant11Dead;
				
				 // Sounds:
				snd_hurt = sndGuardianHurt;
				snd_dead = sndGuardianDead;
				
				 // Vars:
				mask_index = mskNone;
				maxhealth  = 999;
				size       = 3;
				
				prompt = prompt_create("RESELECT");
				with(prompt){
					mask_index = mskBandit;
					yoff       = -2;
				}
			}
			break;
		
		case "Prompt":
			o = instance_create(_x, _y, CustomObject);
			with(o){
				 // Vars:
				mask_index = mskWepPickup;
				persistent = true;
				creator = noone;
				nearwep = noone;
				depth = 0; // Priority (0==WepPickup)
				pick = -1;
				xoff = 0;
				yoff = 0;
				
				 // Events:
				on_meet = null;
			}
			break;
		
		case "Shopkeep":
			o = instance_create(_x, _y, CustomProp);
			with(o){
				 // Visual:
				spr_idle = global.sprMerchantIdle;
				spr_hurt = sprBonePileHurt;
				spr_dead = sprBonePileDead;
				spr_shadow = shd24;
				
				 // Sounds:
				snd_hurt = sndHitRock;
				snd_dead = sndPillarBreak;
				
				 // Vars:
				mask_index = mskBandit;
				maxhealth  = 20;
				my_health  = maxhealth;
				size       = 1;
			}
			break;
		
		default: // Called with undefined - for use with Yokin's cheats mod
			return ["CrystallineEffect", "CrystallinePickup", "MutRefresher", "Prompt", "Shopkeep", "Mutator"];
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

#define Mutator_step
	x = xstart;
	y = ystart;
	
	if(sprite_index = sprProtoStatueDone and image_index >= sprite_get_number(sprite_index) - 1) {
		spr_idle = sprProtoStatueDoneIdle;
	}
	
	if(instance_exists(prompt) && player_is_active(prompt.pick)){
		with(prompt.pick) {
			if(my_health >= 3) {
				with(other) {
					spr_idle = sprProtoStatueDone;
					image_index = 0;
					spr_hurt = sprProtoStatueDoneHurt;
					with(prompt) instance_destroy();
				}
				
				with(GameCont) {
					skillpoints++;
				}
				
				projectile_hit_raw(self, 2, 3);
				maxhealth -= 2;
				
				 // EFFECTS
				instance_create(x, y, LevelUp);
				
				sound_play(sndLevelUp);
				sound_play_pitch(sndUncurse, 1.4);
				sound_play_pitch(sndBloodLauncherExplo, 0.7);
				
				with(instances_matching(CustomProp, "name", "Shopkeep")) {
					spr_idle = global.sprMerchantPuff;
					image_index = 0;
				}
			}
			
			else {
				sound_play(sndCursedReminder);
			}
		}
	}

#define MutRefresher_step
	if(instance_exists(Nothing) or instance_exists(Nothing2)) instance_delete(self);
	x = xstart;
	y = ystart;
	my_health = maxhealth;
	
	if(instance_exists(prompt) && player_is_active(prompt.pick)){
		my_health = 0;
	}

#define MutRefresher_death
	sound_play(sndStatueCharge);
	
	mod_script_call_nc('skill', 'criticalmass', 'skill_reset', 0);
	
#define Prompt_begin_step
	with(nearwep) instance_delete(id);
	
#define Prompt_end_step
	 // Follow Creator:
	var c = creator;
	if(c != noone){
		if(instance_exists(c)){
			if(instance_exists(nearwep)) with(nearwep){
				x += c.x - other.x;
				y += c.y - other.y;
				visible = true;
			}
			x = c.x;
			y = c.y;
			//image_angle = c.image_angle;
			//image_xscale = c.image_xscale;
			//image_yscale = c.image_yscale;
		}
		else instance_destroy();
	}
	
#define Prompt_cleanup
	with(nearwep) instance_delete(id);

#define Shopkeep_step
	if(sprite_index = global.sprMerchantPuff and image_index >= sprite_get_number(sprite_index) - 1) {
		spr_idle = global.sprMerchantIdle;
	}

#define prompt_create(_text)
	/*
		Creates an E key prompt with the given text that targets the current instance
	*/
	
	with(obj_create(x, y, "Prompt")){
		text    = _text;
		creator = other;
		depth   = other.depth;
		
		return id;
	}
	
	return noone;

#define prompt_collision
	 // Prompt Collision:
	var _inst = instances_matching(CustomObject, "name", "Prompt");
	with(_inst) pick = -1;
	_inst = instances_matching(_inst, "visible", true);
	if(array_length(_inst) > 0){
		with(Player) if(visible || variable_instance_get(id, "wading", 0) > 0){
			if(place_meeting(x, y, CustomObject) && !place_meeting(x, y, IceFlower) && !place_meeting(x, y, CarVenusFixed)){
				var _noVan = true;
				
				 // Van Check:
				if(place_meeting(x, y, Van)){
					with(instances_meeting(x, y, instances_matching(Van, "drawspr", sprVanOpenIdle))){
						if(place_meeting(x, y, other)){
							_noVan = false;
							break;
						}
					}
				}
				
				if(_noVan){
					// Find Nearest Touching Indicator:
					var	_nearest  = noone,
						_maxDis   = null,
						_maxDepth = null;
						
					if(instance_exists(nearwep)){
						_maxDis   = point_distance(x, y, nearwep.x, nearwep.y);
						_maxDepth = nearwep.depth;
					}
					
					with(instances_meeting(x, y, _inst)){
						if(place_meeting(x, y, other) && (!instance_exists(creator) || creator.visible || variable_instance_get(creator, "wading", 0) > 0)){
							var e = on_meet;
							if(!is_array(e) || mod_script_call(e[0], e[1], e[2])){
								if(_maxDepth == null || depth < _maxDepth){
									_maxDepth = depth;
									_maxDis   = null;
								}
								if(depth == _maxDepth){
									var _dis = point_distance(x, y, other.x, other.y);
									if(_maxDis == null || _dis < _maxDis){
										_maxDis  = _dis;
										_nearest = id;
									}
								}
							}
						}
					}
					
					 // Secret IceFlower:
					with(_nearest){
						nearwep = instance_create(x + xoff, y + yoff, IceFlower);
						with(nearwep){
							name         = other.text;
							x            = xstart;
							y            = ystart;
							xprevious    = x;
							yprevious    = y;
							visible      = false;
							mask_index   = mskNone;
							sprite_index = mskNone;
							spr_idle     = mskNone;
							spr_walk     = mskNone;
							spr_hurt     = mskNone;
							spr_dead     = mskNone;
							spr_shadow   = -1;
							snd_hurt     = -1;
							snd_dead     = -1;
							size         = 0;
							team         = 0;
							my_health    = 99999;
							nexthurt     = current_frame + 99999;
						}
						with(other){
							nearwep = other.nearwep;
							if(button_pressed(index, "pick")){
								other.pick = index;
							}
						}
					}
				}
			}
		}
	}
	
	instance_destroy();
	

  //				--- OTHER SCRIPTS ---			//
#define tip_generate
	var t = [];
	array_push(t, "SYNERGY");
	array_push(t, "THIS IS THE RUN");
	array_push(t, "TRY SOMETHING NEW");
	array_push(t, "@sTHE VAULTS HAVE " + metacolor + "VISITORS");
	array_push(t, "FIND NEW COMBINATIONS");
	array_push(t, "THE META ISN'T EVERYTHING");
	array_push(t, "TRY WITH @w" + choose("NT:TE", minicolor + "MINIMOD", "DEFPACK", "VAGABONDS") + "!");
	array_push(t, "THE AMMO ECONOMY IS IN SHAMBLES");
	array_push(t, "@sEVERY MUTANT HAS A NEW " + metacolor + "ULTRA");
	array_push(t, "SPECIALIZE");
	
	return metacolor + t[irandom(array_length(t) - 1)];

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

#define instance_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their bounding box touching a given rectangle
		Much better performance than manually performing 'place_meeting()' on every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x1), "bbox_left", _x2), "bbox_bottom", _y1), "bbox_top", _y2);

#define floor_fill(_x, _y, w, h)
	for(ix = 0; ix < abs(w); ix++) {
		for(iy = 0; iy < abs(h); iy++) {
			instance_create(grid_lock(_x, 32) + (ix * (32 * sign(w))) + 16, grid_lock(_y, 32) + (iy * (32 * sign(h))) + 16, Floor);
		}
	}

#define grid_lock(value, grid)
	return floor(value/grid) * grid; // Returns the given value locked to the given grid size