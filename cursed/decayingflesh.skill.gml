#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.hpamt = (4 * skill_get(mod_current)) + ((GameCont.loops * 2) * (skill_get("insurgency") + 1))

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "DECAYING FLESH";
#define skill_text    return "KILLING @wENEMIES@s KILLS ALL#@wLOW HP ENEMIES@s ON SCREEN#TAKE @rDELAYED DOUBLE DAMAGE@s";
#define skill_tip     return "A HORRIBLE AFFLICTION";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut); //sound_mutation_play();
#define skill_avail   return false;
#define skill_cursed  return true; // for metamorphosis

#define step
	global.hpamt = (4 * skill_get(mod_current)) + ((GameCont.loops * 2) * (skill_get("insurgency") + 1));
	with(instances_matching_le(enemy, "my_health", 0)) {
		var e = [];
		for(var i = 0; i < maxp; i++) {
			e = instances_matching_le(instance_rectangle(view_xview[i], view_yview[i], view_xview[i] + game_width, view_yview[i] + game_height, enemy), "my_health", global.hpamt);
			if(array_length(e) > 1) {
				sound_play_pitch(sndScorpionMelee, 0.8 + random(0.4));
				sound_play_pitchvol(sndMeatExplo, 0.6 + random(0.3), 1.4);
				sound_play_pitchvol(sndBloodLauncherExplo, 0.4 + random(0.2), 1.2);
				
				with(e) {
					projectile_hit_raw(self, my_health, 2);
				}
			}
		}
	}
	
	with(Player) {
		if("flesh_lsthealth" not in self) flesh_lsthealth = my_health;
		
		if(flesh_lsthealth != my_health) {
			if(instance_exists(enemy) and flesh_lsthealth > my_health) {
				var fleshdmg = flesh_lsthealth - my_health
				sound_play_pitch(sndBloodCannonEnd, 0.6 + random(0.2));
				
				if(fork()) {
					wait 20 * current_time_scale;
					if(instance_exists(self)) {
						repeat(4) instance_create(x, y, AllyDamage);
						projectile_hit(self, fleshdmg);
						flesh_lsthealth = my_health;
						lasthit = [sprCurse, "@pROT"];
						sound_play_pitch(sndBloodCannon, 0.8 + random(0.2));
					}
					exit;
				}
			}
			
			flesh_lsthealth = my_health;
		}
	}

#define instance_rectangle(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their coordinates touching a given rectangle
		Much better performance than manually performing "point_in_rectangle()" with every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "x", _x1), "x", _x2), "y", _y1), "y", _y2);