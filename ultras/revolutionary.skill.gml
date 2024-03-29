#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sndSkillSlct = sound_add("../sounds/Ultras/sndUlt" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "REVOLUTIONARY";
#define skill_text    return "@wALLIES@s SPAWN WITH @wLOW TIER GUNS#ALLIES HAVE @rLESS HEALTH";
#define skill_tip     return "ARMED AND DANGEROUS";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndBasicUltra);
		sound_play(global.sndSkillSlct);
	}
#define skill_ultra   return "rebel";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	script_bind_draw(revolution_draw, 0);

	with(instances_matching(Ally, "revolutionarywep", null)) {
		var wep_choose = ds_list_create();
		weapon_get_list(wep_choose, 0, 5);
		
		while("revolutionarywep" not in self or 
			  revolutionarywep = -1 or 
			  array_length(string_split(weapon_get_name(revolutionarywep), "TOXIC")) > 1 or
			  array_length(string_split(weapon_get_name(revolutionarywep), "DISC")) > 1 or
			  weapon_is_melee(revolutionarywep) or
			  (weapon_get_type(revolutionarywep) = 4 and !skill_get(mut_boiling_veins))) {
			  	
			  revolutionarywep = ds_list_find_index(wep_choose, irandom_range(1, ds_list_size(wep_choose)));
		}
		
		ds_list_destroy(wep_choose);
		gunspr = mskNone;
		
		maxhealth = round(maxhealth * 0.75);
		if(my_health >= maxhealth) my_health = maxhealth;
	}

	with(instances_matching(AllyBullet, "rev_change", null)) {
		rev_change = 1;
		
		 // check to make sure this was spawned by an ally. names can be deceiving!!
		if(instance_exists(creator) and creator.object_index = Ally) {
			with(creator) {
				if(instance_exists(creator) and creator.object_index = Player) {
					 // THIS IS A LOT OF CREATORS!! this one is the player though! need to do a player_fire function to not cause compatability problems
					with(creator) {
						var cur_wep  = wep,
							cur_x    = x,
							cur_y    = y,
							cur_kick = wkick;
						
						wep = other.revolutionarywep;
						x = other.x;
						y = other.y;
						
						ammo[weapon_get_type(wep)] += weapon_get_cost(wep);
						player_fire(other.gunangle);
						reload -= weapon_get_load(wep);
						
						
						var kick = wkick - cur_kick;
						wkick -= kick;
						other.wkick = kick;
						
						wep = cur_wep;
						x = cur_x;
						y = cur_y;
					}
					
					alarm1 = round((weapon_get_load(revolutionarywep) * 1.2)/(skill_get(mut_throne_butt) + skill_get("technician") + 1));
					
					with(other) instance_delete(self);
				}
			}
		}
	}

#define revolution_draw
	with(instances_matching_ne(Ally, "revolutionarywep", null)) {
		draw_sprite_ext(weapon_get_sprite(revolutionarywep), 0, x - lengthdir_x(wkick, gunangle), y - lengthdir_y(wkick, gunangle), image_xscale, image_yscale, gunangle, image_blend, image_alpha);
	}
	
	instance_destroy();