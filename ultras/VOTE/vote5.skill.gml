#define init
	global.sprSkillIcon = sprite_add("../../sprites/Icons/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../../sprites/HUD/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "POLICE STATE";
#define skill_text    return "EXPLOSIONS DELETE BULLETS#@wAUTO-POP POP EXPLOSIVE WEAPONS";
#define skill_tip     return "AUTHORITARIAN";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(instances_matching(Explosion, "policedestroy", null)) {
		policedestroy = "it sure be";
		
		var hbox_w = sprite_get_width(mask_index)/2,
			hbox_h = sprite_get_height(mask_index)/2;
		
		with(instance_rectangle_bbox(x - hbox_w, y - hbox_h, x + hbox_w, y + hbox_h, instances_matching_ne(projectile, "team", team))) {
			with(other) {
				image_xscale = sprite_get_width(mask_index)/sprite_get_width(mskPopoExplo);
				image_yscale = sprite_get_width(mask_index)/sprite_get_height(mskPopoExplo);
				
				sprite_index = sprPopoExplo;
				mask_index   = mskPopoExplo;
				
				sound_play_pitch(sndEnergyScrewdriverUpg, 1.4 + random(0.3));
				sound_play_pitch(sndWallBreakCrystal, 1.4  + random(0.3));
				sound_play_pitchvol(sndNothingSmallball, 0.8 + random(0.3), 0.6);
				sound_play_pitchvol(sndEliteInspectorAlarmed, 1.4 + random(0.3), 0.6);
			}
			
			sleep(1);
			
			instance_destroy();
		}
	}

#define instance_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their bounding box touching a given rectangle
		Much better performance than manually performing 'place_meeting()' on every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x1), "bbox_left", _x2), "bbox_bottom", _y1), "bbox_top", _y2);