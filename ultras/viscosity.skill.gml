#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sndSkillSlct = sound_add("../sounds/Ultras/sndUlt" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "VISCOSITY";
#define skill_text    return "USE @gRADS@s FOR @rHEALTH";
#define skill_tip     return "EVER SUFFERING";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndBasicUltra);
		sound_play(global.sndSkillSlct);
	}
#define skill_ultra   return "melting";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(Player) {
		if(!variable_instance_exists(self, "viscous_lsthealth")) viscous_lsthealth = my_health;
		if(viscous_lsthealth > my_health) {
			var viscdiff = viscous_lsthealth - my_health,
				visccost = 75 - max((skill_get("viscosity") - 1) * 10, 50);
			if(instance_exists(GameCont) && viscdiff) {
				repeat(viscdiff) {
					if(GameCont.rad >= visccost) {
						GameCont.rad -= visccost;
						my_health += 1;
						 // EFFECTS
						sound_play_pitch(sndRadMaggotDie, 0.8);
						sound_play(sndImpWristKill);
						
						instance_create(x, y, AcidStreak).image_angle = random(360);
					}
				}
			}
		}
		
		viscous_lsthealth = my_health;
	}
