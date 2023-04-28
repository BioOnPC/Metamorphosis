#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sndSkillSlct = sound_add("../sounds/Cursed/sndCurse" + string_upper(string(mod_current)) + ".ogg");

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "ADRENALINE";
#define skill_text    return "@wINFINITE AMMO@s WHEN PICKING UP @yAMMO@s#@rTAKE DAMAGE@s WHILE NOT @wSHOOTING@s";
#define skill_tip     return "HIGH OCTANE VIOLENCE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_type    return "cursed";
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
	with(AmmoPickup) {
	    if("adrenalinepickup" not in self) {
	    	adrenalinepickup = 1;
	    	with(call(scr.obj_create, x, y, "AdrenalinePickup")) {
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
		if("adrenalinetimer" not in self) adrenalinetimer = 90;
		
		var shot = can_shoot && canfire && (weapon_get_auto(wep) > 0 ? button_check(index, "fire") : (clicked || button_pressed(index, "fire"))) && (ammo[weapon_get_type(wep)] >= weapon_get_cost(wep) || infammo != 0),
				bshot = race == "steroids" && bcan_shoot && canspec && (weapon_get_auto(wep) > 0 ? button_check(index, "spec") : button_pressed(index, "spec")) && (ammo[weapon_get_type(bwep)] >= weapon_get_cost(bwep) || infammo != 0);
		if(shot) adrenalinetimer += weapon_get_load(wep) * 1.2;
		if(bshot) adrenalinetimer += weapon_get_load(bwep) * 1.2;
		
		if(instance_exists(enemy) and my_health > 1) {
			adrenalinetimer -= current_time_scale;
		}
		
		else adrenalinetimer = 90;
		
		if(adrenalinetimer <= 0) {
			if(my_health > 1) {
				projectile_hit(self, 1);
				lasthit = [sprRabbitPaw, "ANXIETY"];
				sound_play_pitchvol(sndBloodHurt, 0.8 + random(0.2), 0.7);
				sound_play_pitchvol(sndCursedChest, 1 + random(0.1), 0.7);
				sound_play_pitchvol(sndWeaponPickup, 0.8 + random(0.4), 0.7);
				sound_play_pitchvol(sndWeaponChest, 1.8 + random(0.4), 0.7);
			}
			
			adrenalinetimer += 50;
		}
	}

#macro  scr																						mod_variable_get("mod", "metamorphosis", "scr")
#macro  call																					script_ref_call