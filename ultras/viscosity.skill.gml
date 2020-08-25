#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "VISCOSITY";
#define skill_text    return "USE @gRADS@s FOR @rHEALTH";
#define skill_tip     return "EVER SUFFERING";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define skill_ultra   return "melting";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(Player) {
		if(!variable_instance_exists(self, "viscous_lsthealth")) viscous_lsthealth = my_health;
		if(viscous_lsthealth > my_health) {
			if(instance_exists(GameCont) and GameCont.rad >= max(1, 100 - ((skill_get("viscosity") - 1) * 25))) {
				GameCont.rad -= max(1, 100 - ((skill_get("viscosity") - 1) * 25));
				my_health = viscous_lsthealth;
				
				 // EFFECTS
				sound_play_pitch(sndRadMaggotDie, 0.8);
				sound_play(sndImpWristKill);
				
				var ang = random(360);
				repeat(3) {
					instance_create(x, y, AcidStreak).image_angle = ang;
					ang += 120;
				}
			}
			
			else {
				sound_play_pitch(sndUltraEmpty, 1.8);
				sound_play_pitch(sndHPPickup, 0.4);
			}
		}
		
		viscous_lsthealth = my_health;
	}
