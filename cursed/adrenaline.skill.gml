#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "ADRENALINE";
#define skill_text    return "@wINFINITE AMMO@s WHEN PICKING UP @yAMMO@s#@rTAKE DAMAGE@s WHEN NOT IN COMBAT";
#define skill_tip     return "HIGH OCTANE VIOLENCE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut); //sound_mutation_play();
#define skill_avail   return false;
#define skill_cursed  return true; // for metamorphosis

#define step
	with(AmmoPickup) {
	    if("adrenalinepickup" not in self) {
	    	adrenalinepickup = 1;
	    	with(obj_create(x, y, "AdrenalinePickup")) {
	    		creator = other.id;
	    	}
	    }
	    
	    if(random(30/current_time_scale) < 1) with(instance_create(x, y, PortalL)) {
			depth = other.depth - 1;
			image_xscale = 0.75;
			image_yscale = 0.75;
		}
	}
	
	with(Player) {
		if("adrenalinetimer" not in self) adrenalinetimer = 120;
		
		if(reload > 0 or (bwep != wep_none and breload > 0)) adrenalinetimer = 120;
		
		if(instance_exists(enemy)) adrenalinetimer -= current_time_scale;
		
		if(adrenalinetimer <= 0) {
			if(my_health > 1) {
				projectile_hit(self, 1);
				lasthit = [sprRabbitPaw, "ANXIETY"];
				sound_play_pitch(sndBloodHurt, 0.8 + random(0.2));
				sound_play_pitch(sndCursedChest, 1 + random(0.1));
				sound_play_pitch(sndWeaponPickup, 0.8 + random(0.4));
				sound_play_pitch(sndWeaponChest, 1.8 + random(0.4));
			}
			
			adrenalinetimer += 50;
		}
	}

#define obj_create(_x, _y, _obj)                                            	return	mod_script_call_nc('mod', 'metamorphosis', 'obj_create', _x, _y, _obj);