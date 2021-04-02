#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.level_start = false;

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "VACUUM VACUOLES";
#define skill_text    return "GAIN @rMAX HP@s FROM @rMEDKIT CHESTS@s#MORE @rMEDKIT CHESTS@s#@pATTRACT PROJECTILES@s";
#define skill_tip     return "BOTTOMLESS SOUL";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut); //sound_mutation_play();
#define skill_avail   return false;
#define skill_cursed  return true; // for metamorphosis

#define step
	with(Player) {
		if(chickendeaths = 0) chickendeaths += 2;
		
		with(instance_rectangle(x - 24, y - 24, x + 24, y + 24, instances_matching_ne(projectile, "team", team))) {
			var lstspd = speed;
			motion_add(point_direction(x, y, other.x, other.y), speed * 0.2);
			speed = lstspd;
			image_angle = direction;
		}
	}
	
	 // Level Start:
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	else if(global.level_start){
		global.level_start = false;
		
		var f = instances_matching(Floor, "", null),
			rf = f[irandom_range(0, array_length(f) - 1)];
		
		if(random(6 - skill_get(mod_current)) < 1) {
			with(rf) instance_create(x + 16, y + 16, HealthChest);
		}
	}

#define instance_rectangle(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their coordinates touching a given rectangle
		Much better performance than manually performing "point_in_rectangle()" with every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "x", _x1), "x", _x2), "y", _y1), "y", _y2);