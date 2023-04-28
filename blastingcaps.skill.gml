#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	//global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	
	global.sprBlastingCap    = sprite_add("sprites/VFX/sprBlastingCap.png", 8, 16, 16);

#define skill_name    return "BLASTING CAPS";
#define skill_text    return "FIRING @wSHELL WEAPONS@s#REFLECTS @wNEARBY PROJECTILES@s";
#define skill_tip     return "CAVITIES";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_type    return "offensive";
#define skill_wepspec return 1;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		//sound_play(global.sndSkillSlct);
	}

#define step
    if(!instance_exists(SpiralCont)) with(Player){
	    var _auto = weapon_get_auto(wep);
	    if(race == "steroids" && _auto >= 0){
	        _auto = true;
	    }
	    if(race == "steroids" && weapon_get_type(bwep) = 2 && bcan_shoot && canspec && (_auto ? button_check(index, "spec") : button_pressed(index, "spec")) && (ammo[weapon_get_type(bwep)] >= weapon_get_cost(bwep) || infammo != 0)){
	        blast_fire(gunangle, weapon_get_load(bwep)); // secondary fire
	    }
	    
	    if(weapon_get_type(wep) = 2 and can_shoot){
	        if(race == "skeleton" && canspec && button_pressed(index, "spec") && weapon_get_cost(wep) > 0){
	            blast_fire(gunangle, weapon_get_load(wep)); // skeleton fire
	        }
	        else if(race == "venuz" && canspec && button_pressed(index, "spec") && weapon_get_type(wep) != 0 && (ammo[weapon_get_type(wep)] >= weapon_get_cost(wep) * floor(2 + (2 * skill_get(mut_throne_butt))) || infammo != 0)){
	            blast_fire(gunangle, weapon_get_load(wep)); // YV fire
	        }
	        else if(canfire && (_auto ? button_check(index, "fire") : (clicked || button_pressed(index, "fire"))) && (ammo[weapon_get_type(wep)] >= weapon_get_cost(wep) || infammo != 0)){
	            blast_fire(gunangle, weapon_get_load(wep)); // normal fire
	        }
	    }
	}


#define blast_fire(_ang, _load)
	with(call(scr.projectile_create, self, x + hspeed + call(scr.orandom, 8), y + vspeed + call(scr.orandom, 8), CustomSlash, _ang, 7 + random(2))) {
			name = "BlastingCap";
			sprite_index = global.sprBlastingCap;
			image_speed  = 0.4 + random(0.2);
			friction = 0.4;
			//image_xscale = 0.4 + random(0.25);
			//image_yscale = 0.4 + random(0.25);
			damage		 = 0;
		}

	if(_load >= 8) repeat(round(_load/8)) {
		with(call(scr.projectile_create, self, x + hspeed + call(scr.orandom, 8), y + vspeed + call(scr.orandom, 8), CustomSlash, _ang + call(scr.orandom, 6 * min(_load, 6)), 7 + random(4))) {
			name = "BlastingCap";
			sprite_index = global.sprBlastingCap;
			image_speed  = 0.4 + random(0.2);
			friction = 0.4;
			//image_xscale = 0.2 + random(0.25);
			//image_yscale = 0.2 + random(0.25);
			damage		 = 0;
		}
	}
	
	sound_play_pitchvol(sndEnergyHammer, 1.4 + random(0.2), 0.5);
	sound_play_pitchvol(sndSuperFlakExplode, 1.5 + random(0.4), 0.5);
	sound_play_pitchvol(sndFlareExplode, 1.6 + random(0.4), 0.7);
	
#macro  scr																						mod_variable_get("mod", "metamorphosis", "scr")
#macro  call																					script_ref_call