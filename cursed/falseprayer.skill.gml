#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sndSkillSlct = sound_add("../sounds/Cursed/sndCurse" + string_upper(string(mod_current)) + ".ogg");
	global.level_start = false;

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "FALSE PRAYER";
#define skill_text    return "@pPORTALS@s @rHEAL@s AND RESTORE @wAMMO@s#@wSLOWED@s 10 SECONDS#AFTER EXITING A PORTAL";
#define skill_tip     return "OCCULT DEALINGS";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play_pitch(sndCursedChest, 1.2);
		sound_play(sndBigCursedChest);
		sound_play(global.sndSkillSlct);
	}
#define skill_avail   return false;
#define skill_cursed  return true; // for metamorphosis

#define step
	 // Level Start:
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	else if(global.level_start){
		global.level_start = false;
		with(Player) {
			var hpdiff = maxhealth - my_health,
				ammodiff = 0;
			if(hpdiff > 0) my_health += ceil(hpdiff/2);
			for(i = 0; i <= 5; i++) {
				ammodiff = typ_amax[i] - ammo[i];
				ammo[i] += min(ceil(typ_amax[i] * 0.65), ammodiff);
			}
			
			sound_play_pitchvol(sndUncurse, 0.6 + random(0.1), 0.7);
			sound_play_pitchvol(sndToxicBoltGas, 0.8 + random(0.2), 0.9);
			sound_play_pitchvol(sndGoldChest, 0.6 + random(0.2), 0.9);
			
			if(fork()) {
				repeat(20) {
					if(instance_exists(self)) instance_create(x + random_range(20, -20), y + random_range(20, -20), FireFly);
					wait 2;
				}
				
				exit;
			}
			
			if("falseprayer" not in self) falseprayer = 240;
			else {
				if(falseprayer <= 0) maxspeed += 0.5; 
				falseprayer = 240 + random(30);
			}
		}
	}
	
	with(instances_matching_gt(instances_matching_ne(Player, "falseprayer", null), "falseprayer", 0)) {
		falseprayer -= current_time_scale;
		if(falseprayer <= 0) {
			maxspeed -= 0.5;
			sound_play_pitchvol(sndHyperCrystalTaunt, 0.5 + random(0.2), 0.4);
			sound_play_pitchvol(sndLightningReload, 0.2 + random(0.2), 0.6);
		}
	}
	
#define skill_lose
	with(instances_matching_le(instances_matching_ne(Player, "falseprayer", null), "falseprayer", 0)) {
		maxspeed += 0.5;
	}