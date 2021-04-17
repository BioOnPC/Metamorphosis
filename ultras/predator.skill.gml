#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sndSkillSlct = sound_add("../sounds/Ultras/sndUlt" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "PREDATOR";
#define skill_text    return "@wSNARED ENEMIES@s BLEED @rHP@s AND @yAMMO@s DROPS";
#define skill_tip     return "MORE MORE MORE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndBasicUltra);
		sound_play(global.sndSkillSlct);
	}
#define skill_ultra   return "plant";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	 // Every five frames...
	if((floor(current_frame) mod (25 * (room_speed/30))) = 0) {
		with(Tangle) {
			with(instances_meeting(x, y, enemy)) {
				var tangledmg = 2;
				sleep(3);
				view_shake_at(x, y, 4);
				if(my_health - tangledmg > 0) {
					projectile_hit_raw(id, tangledmg, 1);
					sound_play_pitch(sndPlantSnare, 1.8);
					sound_play_pitch(sndSharpTeeth, 1.4);
					
					if(random(3) < 1) repeat(skill_get(mod_current) + skill_get(mut_rabbit_paw)) {
						var tanglepickup = choose(AmmoPickup, AmmoPickup, HPPickup);
						with(instance_create(x, y, tanglepickup)) {
							motion_add(random(360), 3 + random(2));
						}
					}
				}
			}
		}
	}

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