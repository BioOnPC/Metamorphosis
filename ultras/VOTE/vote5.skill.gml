#define init
	global.sprSkillIcon = sprite_add("../../sprites/Icons/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../../sprites/HUD/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "POPO STATE";
#define skill_text    return "@wEXPLOSIONS@s DELETE @wBULLETS";
#define skill_tip     return "AUTHORITARIAN";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take    
	sound_play(sndBasicUltra);
	skill_set("vote2bcool", 0);
#define skill_avail   return 0; // Disable from appearing in normal mutation pool
#define skill_ultra   return -1; // Doesn't show up
#define step
	with(instances_matching(Explosion, "policedestroy", null)) {
		policedestroy = "it sure be";
		
		with(instance_create(x, y, PopoExplosion)) {
			policedestroy = "real";
			team   = other.team;
			ang    = other.ang;
			damage = other.damage;
			hitid  = other.hitid;
			force  = other.force;
			
			image_xscale = (sprite_get_width(other.sprite_index)/sprite_get_width(sprPopoExplo));
			image_yscale = (sprite_get_height(other.sprite_index)/sprite_get_height(sprPopoExplo));
		}
		
		sound_play_pitch(sndEnergyScrewdriverUpg, 1.4 + random(0.3));
		sound_play_pitch(sndWallBreakCrystal, 1.4  + random(0.3));
		sound_play_pitchvol(sndNothingSmallball, 0.8 + random(0.3), 0.6);
		sound_play_pitchvol(sndEliteInspectorAlarmed, 1.4 + random(0.3), 0.6);
		
		instance_delete(self);
	}

#define instance_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their bounding box touching a given rectangle
		Much better performance than manually performing 'place_meeting()' on every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x1), "bbox_left", _x2), "bbox_bottom", _y1), "bbox_top", _y2);