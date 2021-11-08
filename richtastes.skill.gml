#define init
	global.sprSkillIcon     		= sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD      		= sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sprGoldAmmo              = sprite_add("sprites/VFX/sprGoldAmmo.png",     		 7, 5,  5);
	global.sprGoldFatAmmo           = sprite_add("sprites/VFX/sprGoldFatAmmo.png",  		 7, 6,  6);
	global.sprGoldAmmoChest         = sprite_add("sprites/VFX/sprGoldAmmoChest.png",		 7, 12, 8);
	global.sprGoldAmmoChestSteroids = sprite_add("sprites/VFX/sprGoldAmmoChestSteroids.png", 7, 12, 8);
	global.sndSkillSlct 			= sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	global.sndGoldRush 				= sound_add("sounds/sndGoldRush.ogg");

#define skill_name    return "RICH TASTES";
#define skill_text    return "SOME KILLS GRANT @wHASTE@s#@yGOLDEN WEAPONS@s RELOAD FASTER";
#define skill_tip     return "GOLDEN GRILL";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}

#define step
	 // Speed up golden weapons gogogogogo:
	with(Player) {
		if(weapon_get_gold(wep) or (race = "steroids" and weapon_get_gold(bwep))) {
			 // Reloadspeed nonsense:
			if(weapon_get_gold(wep) and reload) 						reload  -= (reloadspeed * (0.6 + ((weapon_get_gold(bwep) and race = "steroids") * 0.6))) * current_time_scale; 
			if(race = "steroids" and weapon_get_gold(bwep) and breload) breload -= (reloadspeed * (0.6 + (weapon_get_gold(wep) * 0.6))) * current_time_scale; 
			
			 // VFX:
			if(call(scr.chance_ct, 1, 8)) {
				repeat(irandom_range(1, 3)) {
					with(instance_create(x + call(scr.orandom, sprite_width/2), y + call(scr.orandom, sprite_height/2), BulletHit)) sprite_index = sprCaveSparkle;
				}
			}
		}
	}
	
	 // Haste players on some kills:
	with(instances_matching_ne(enemy, "richtastes_select", null)) {
		if(instance_exists(self) and object_index != RavenFly) {
			if(my_health > 0) {
				 // VFX:
				if(call(scr.chance_ct, 1, 10)) {
					repeat(irandom_range(1, 3)) {
						with(instance_create(x + call(scr.orandom, sprite_width/3), y + call(scr.orandom, sprite_height/3), BulletHit)) sprite_index = sprCaveSparkle;
					}
				}
			}
			
			else if("richhaste" not in self) {
				 // Make sure this only happens once, there are some weirdy enemies that stay at 0 hp for a bit
				richhaste = true;
				
				 // VFX:
				repeat(6 + irandom(4)) {
					call(scr.fx, x, y, 2 + random(5), Feather).sprite_index = sprMoney;
				}
				
				with(Player) {
					 // Haste:
					call(["mod", "metamorphosis", "haste"], 40 + (skill_get(mod_current) * 20), 0.4);
					
					 // FX:
					sound_play_pitch(global.sndGoldRush, 1 + random(0.3));
					repeat(6 + irandom(4)) {
						call(scr.fx, x, y, 2 + random(5), Feather).sprite_index = sprMoney;
					}
				}
			}
		}
	}
	
#macro  scr																						mod_variable_get("mod", "metamorphosis", "scr")
#macro  call																					script_ref_call