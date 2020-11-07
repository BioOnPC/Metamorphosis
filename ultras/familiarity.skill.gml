#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "FAMILIARITY";
#define skill_text    return "CHARGING @gTOXIC CLOUD@s#SPAWNS @gBALLS OF TOXIC";
#define skill_tip     return "LIKE MOTHER...";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take    sound_play(sndBasicUltra);
#define skill_ultra   return "frog";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(instances_matching(Player, "race", "frog")) {
		with(instances_matching_le(instances_matching(FrogQueenBall, "team", team), "speed", 0)) {
			instance_destroy();
			sound_play(sndFrogExplode);
			sound_play(sndToxicBarrelGas);
		}
		
		if(frogcharge >= 20/skill_get("familiarity")) {
			if(frogcharge - current_time_scale < 20) {
				sound_play(sndMenuLoadout);
				sound_play_pitch(sndFrogGasRelease, 1.4);
				instance_create(x, y, ThrowHit).image_speed = 0.4;
				
				var ang = random(360);
				repeat(3) {
					instance_create(x, y, AcidStreak).image_angle = ang;
					ang += 120;
				}
				view_shake_at(x, y, 10);
			}
			
			
			if(canspec and (button_released(index, "spec") or usespec)) {
				with(instance_create(x, y, FrogQueenBall)) {
					motion_add(point_direction(x, y, mouse_x[other.index], mouse_y[other.index]), 2 + (6 * (other.frogcharge/100)));
					team = other.team;
					creator = other;
					friction = 0.05;
				}
				view_shake_at(x, y, frogcharge);
				sleep(5 * frogcharge);
				
				sound_play_pitch(sndBallMamaFire, 0.7);
				sound_play_pitch(sndNukeFire, 1.6 - (frogcharge/100));
			}
		}
	}