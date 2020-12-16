#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.level_start = (instance_exists(GenCont) || instance_exists(Menu));

#define skill_name    return "PYROMANIA";
#define skill_text    return "FIRE AND EXPLOSIONS @rIGNITE@s CORPSES";
#define skill_tip     return "HELL WORLD";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take(_num)  
	sound_mutation_play();
	
	if(_num > 0 and instance_exists(LevCont)) {
		with(GameCont) wepmuts++;
	}

#define step
	with(instances_matching(CustomProjectile, "name", "Fire Bullet")) pyroflammable = true;

	with(Corpse) {
		 // Initialize variable, just make sure the game knows it exists
		if(!variable_instance_exists(self, "pyroignite")) pyroignite = 0;

		 // If they're already ignited, do stuff!
		if(pyroignite > 0) {
			 // This looks weird, but it's to mitigate how often it spawns fire. Should be once every 3 frames!
			if((pyroignite mod 5) = 0) {
				var nplayer = instance_nearest(x, y, Player);

				with(instance_create(x + random_range(8, -8), y + random_range(8, -8), Flame)) {
					 // Makes sure there's a player that exists. No errors!
					if(nplayer > 0) {
						creator = nplayer;
						team = creator.team;
					}
				}

				 // Set the direction of the smoke, for visual reasons
				var dir = ((direction > 90 and direction < 270) ? -30 : 30);

				with(instance_create(x + random_range(6, -6), y + random_range(6, -6), SmokeOLD)) {
					depth = -10;
					motion_add(90 + (dir * speed), 5);
					mask_index = mskNone;
				}

				sound_play_pitchvol(sndFiretrap, 1 + random(0.4), 1.4);
			}

			pyroignite--;

			if(pyroignite = 0) {
				 // SOFTLOCK PREVENTION
				if(alarm_get(0) > -1) {
					pyroignite++;
				}

				else {
					for(i = 0; i < 360; i += 40/size) {
						with(instance_create(x + random_range(6, -6), y + random_range(6, -6), SmokeOLD)) {
							motion_add(other.i, 3 * (other.size/2));
							friction = other.size * 0.2;
						}
					}
					instance_destroy();
				}
			}
		}

		 // Ignite corpse if they're not ignited!
		else if((place_meeting(x, y, CustomProjectile) && variable_instance_exists(instance_nearest(x, y, CustomProjectile), "pyroflammable")) || place_meeting(x, y, Flame) || place_meeting(x, y, FlameShell) || place_meeting(x, y, TrapFire) || place_meeting(x, y, Explosion) || place_meeting(x, y, GreenExplosion) || place_meeting(x, y, SmallExplosion)) {
			pyroignite = (30 + irandom(15)) * skill_get("pyromania");
		}
	}

#define sound_mutation_play()
	sound_play(sndMut);
	with instance_create(0, 0, CustomObject){
		lifetime = 0;
		stage = 0;
		pitch = 1;
		on_step = sound_step
		on_destroy = sound_destroy
	}

#define sound_step
	lifetime += current_time_scale;
	if lifetime >= 5 && stage = 0{
		stage++;
		sound_play(sndMutant5IDPD)
		sound_play_pitchvol(sndFiretrap, 1.4, .7)
	}
	if lifetime > 8 && stage = 1{
		stage++;
		sound_play_pitchvol(sndExplosion, 1.3, .7)
	}
	if lifetime > 10 && stage = 2{
		stage++;
		sound_play_pitchvol(sndExplosionL, 1, .7)
		sound_play_pitchvol(sndAssassinGetUp, .85, .9)
	}
	if lifetime > 26 && stage = 3{
		stage++;
		sound_play_pitchvol(sndExplosionS, .9, .7)
		sound_play_pitchvol(sndAssassinHit, .85, .9)
		sound_play_pitchvol(sndBanditDie, 1.1, .9)
	}
	if lifetime > 32 && stage = 4{
		stage++;
		sound_play_pitchvol(sndExplosion, 1.2, .7)
		sound_play_pitchvol(sndAssassinHit, .85, .9)
	}
	if lifetime > 32 && stage = 5{
		stage++;
		sound_play_pitchvol(sndExplosionL, 1.2, .7)
		sound_play_pitchvol(sndAssassinDie, 1, .9)
	}
	if lifetime > 37 && stage = 6{
		stage++;
		sound_play_pitchvol(sndBurn, 1.2, 2)
	}
	if lifetime > 43 && stage = 7{
		stage++;
		sound_play_pitchvol(sndBurn, 1, 2)
	}
	if lifetime > 49 && stage = 8{
		stage++;
		sound_play_pitchvol(sndBurn, 1, 2)
	}


	if lifetime >= 15 && lifetime < 18{
		pitch -= .001 * room_speed/current_time_scale;
		audio_sound_pitch(sndMutant5IDPD, pitch);
	}
	if lifetime >= 30 && lifetime < 40{
		pitch += .0008 * room_speed/current_time_scale;
		audio_sound_pitch(sndMutant5IDPD, pitch);
	}
	if lifetime >= 60 instance_destroy();

#define sound_destroy
	audio_sound_pitch(sndMutant5IDPD, 1);
	sound_stop(sndFlamerLoop);
