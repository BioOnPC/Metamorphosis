#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "DECAYING FLESH";
#define skill_text    return "KILLING @wENEMIES@s DAMAGES#ALL @wSIMILAR ENEMIES@s#TAKE @rDELAYED DOUBLE DAMAGE@s";
#define skill_tip     return "A HORRIBLE AFFLICTION";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut); //sound_mutation_play();
#define skill_avail   return false;
#define skill_cursed  return true; // for metamorphosis

#define step
	with(instances_matching_le(enemy, "my_health", 0)) {
		if(array_length(instances_matching(enemy, "object_index", object_index)) > 1) {
			sound_play_pitch(sndScorpionMelee, 0.8 + random(0.4));
			sound_play_pitchvol(sndMeatExplo, 0.6 + random(0.3), 1.4);
			sound_play_pitchvol(sndBloodLauncherExplo, 0.4 + random(0.2), 1.2);
			
			with(instances_matching(enemy, "object_index", object_index)) {
				projectile_hit_raw(self, 2 + (GameCont.loops), 2);
			}
		}
	}
	
	with(Player) {
		if("flesh_lsthealth" not in self) flesh_lsthealth = my_health;
		
		if(flesh_lsthealth != my_health) {
			if(instance_exists(enemy) and flesh_lsthealth > my_health) {
				var fleshdmg = flesh_lsthealth - my_health
				sound_play(sndBloodCannonEnd);
				
				if(fork()) {
					wait 20 * current_time_scale;
					if(instance_exists(self)) {
						repeat(4) instance_create(x, y, AllyDamage);
						projectile_hit(self, fleshdmg);
						flesh_lsthealth = my_health;
						lasthit = [sprRevive, "@pROT"];
						sound_play_pitch(sndBloodCannon, 0.8 + random(0.2));
					}
					exit;
				}
			}
			
			flesh_lsthealth = my_health;
		}
	}
