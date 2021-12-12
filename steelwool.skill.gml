#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	//global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "STEEL WOOL";
#define skill_text    return "KILLS WITH @wENERGY WEAPONS@s#@yPARALYZE@s ENEMIES";
#define skill_tip     return "KINETIC ENERGY";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_avail     return (mod_exists("mod", "varia_tools") and (instance_exists(Menu) or instance_exists(LevCont) or skill_get(mod_current) > 0));
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		//sound_play(global.sndSkillSlct);
	}

#define step
    with(mod_variable_get("mod", "metamorphosis", "steel_wool")) {
    	if(!instance_exists(self)) {
    		mod_variable_set("mod", "metamorphosis", "steel_wool", call(scr.array_delete_value, mod_variable_get("mod", "metamorphosis", "steel_wool"), self));
    		exit;
    	}
    	
    	var _e = [];
    	
    	with(call(scr.instances_meeting, x + hspeed, y + vspeed, enemy)) {
    		array_push(_e, [self, x, y, sprite_width * 1.2, sprite_height * 1.2, depth]);
    	}
    	
    	if(fork()) {
    		wait 0;
    		
    		with(_e) {
    			if(!instance_exists(self[0]) or self[0].my_health <= 0) {
	    			repeat(max(1, min(self[3], self[4])/4)) with(mod_script_call("mod", "varia_particles", "varia_particle_create", self[1] + call(scr.orandom, self[3]), self[2] + call(scr.orandom, self[4]), "voltaic_spark")){
						depth = other[5] - 1;
					}
					
					sound_play_pitch(sndLightningCrystalHit, 1.4 + random(0.2));
					sound_play_pitch(sndLightningHit, 1.2 + random(0.2));
					sound_play_pitchvol(sndLightningCannon, 1.7 + random(0.2), 0.3);
	    			
	    			with(call(scr.instances_in_rectangle, self[1] - self[3], self[2] - self[4], self[1] + self[3], self[2] + self[4], enemy)) {
	    				mod_script_call("mod", "varia_tools", "paralyze", 10 + (5 * skill_get(mod_current)) + random(8), 1);
	    			}
    			}
    		}
    		
    		exit;
    	}
    }
   	
#macro  scr																						mod_variable_get("mod", "metamorphosis", "scr")
#macro  call																					script_ref_call