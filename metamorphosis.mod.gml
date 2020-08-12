#define init
	global.sprMedpack = sprite_add("sprites/VFX/sprFatHP.png",  7,  6,  6);
	
#define step
    if(skill_get(mut_second_stomach)) {
        with(instances_matching_ne(HPPickup, "sprite_index", global.sprMedpack)) {
            sprite_index = global.sprMedpack;
        }
    }

#define draw
	if(skill_get("musclememory") > 0 and instance_exists(Player)) {
		with(instances_matching_ne(projectile, "musclememory", null)) {
			var nplayer = instance_nearest(x, y, Player);
			if(team != nplayer.team) {
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_red, 1 - point_distance(x, y, nplayer.x, nplayer.y)/32);
			}
		}
	}
	
#define obj_create(_x, _y, _name)
	 // this is all yokin. he is a powerful mans
	if(is_real(_name) && object_exists(_name)){
		return instance_create(_x, _y, _name);
	}
	
	switch(_name) {
		case "CrystallinePickup":
			with(instance_create(_x, _y, CustomObject)) {
				creator    = noone;
				
				on_step    = CrystallinePickup_step;
				on_destroy = CrystallinePickup_destroy;
			}
		
		break;
		
		default: // called with undefined
			return ["CrystallinePickup"];
	}
	
#define CrystallinePickup_step
	if(!instance_exists(creator)) {
		instance_destroy();
	}
	
	else {
		x = creator.x;
		y = creator.y;
	}
	
#define CrystallinePickup_destroy
	var nplayer = instance_nearest(x, y, Player);
	if(instance_exists(nplayer) and point_distance(x, y, nplayer.x, nplayer.y) < 40) {
		with(nplayer) {
			nexthurt = current_frame + (30 / current_time_scale);
			trace(nexthurt);
		}
	}