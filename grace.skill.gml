#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "GRACE";
#define skill_text    return "DODGING @wBULLETS HASTENS@s YOU#AND CLEARS @rBULLETS";
#define skill_tip     return "SOLID PLAY";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}
	
#define step
	with(Player) {
	    with(instance_rectangle(x - 24, y - 24, x + 24, y + 24, instances_matching_ne(projectile, "team", team))) {
	    	if(instance_exists(self) and ("creator" not in self or creator != other)) {
		    	if(!variable_instance_exists(self, "grace")) grace = 0;
	
		    	
		    	if(!(other.notoxic > 0 and object_index = ToxicGas) and object_index != Flame and object_index != TrapFire) {
			    	if(grace = 0 && point_distance(x, y, other.x, other.y) < (12 + (sprite_get_width(mask_index) * 0.75))) {
			    		grace = other.id;
			    		 // Stolen from defpack snipers. thank u karm and jsburg
			    		sound_play_pitch(sndSnowTankCooldown, 8);
						sound_play_pitchvol(sndShielderDeflect, 4, .5);
						sound_play_pitchvol(sndBigCursedChest, 20, .1);
						sound_play_pitchvol(sndCursedChest, 12, .2);
			    		with(instance_create(x + hspeed, y + vspeed, ChickenB)) image_speed = 0.8;
			    	}
		    	}
	    	}
	    }
	    
	    with(instances_matching(projectile, "grace", id)) {
		    if(instance_exists(self) and point_distance(x, y, other.x, other.y) > (12 + (sprite_get_width(mask_index) * 1.2)) && other.lsthealth = other.my_health) {
	    		sound_play_pitch(sndMenuLoadout, 0.8 + random(0.4));
	    		grace = 0;
	    		with(other) {
	    			haste(other.damage * 20, 0.6 * skill_get(mod_current));
	    		}
				var p = other;
	    		with(projectile) {
	    			if(instance_exists(self) and team != p.team and id != other.id and point_distance(x, y, other.x, other.y) < 64) {
						sound_play_pitchvol(sndGoldChest, 6 + random(0.4), .4);
						sound_play_pitchvol(sndGoldPickup, 1.3 + random(0.4), .4);
	    				mod_script_call("skill", "selectivefocus", "selectivefocus_destroy");
	    			}
	    		}
	    		
	    		mod_script_call("skill", "selectivefocus", "selectivefocus_destroy");
	    	}
	    }
	}
	
#define haste(amt, pow)                                            	    		return mod_script_call('mod', 'metamorphosis', 'haste', amt, pow);
#define instance_rectangle(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their coordinates touching a given rectangle
		Much better performance than manually performing "point_in_rectangle()" with every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "x", _x1), "x", _x2), "y", _y1), "y", _y2);