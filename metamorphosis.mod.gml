#define init
	global.sprMedpack = sprite_add("sprites/VFX/sprFatHP.png",  7,  6,  6);
	
#define step
    if(skill_get(mut_second_stomach)) {
        with(instances_matching_ne(HPPickup, "sprite_index", global.sprMedpack)) {
            sprite_index = global.sprMedpack;
        }
    }

#define draw
	with(instances_matching_ne(projectile, "musclememory", null)) {
		var nplayer = instance_nearest(x, y, Player);
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_red, 1 - point_distance(x, y, nplayer.x, nplayer.y)/24);
	}