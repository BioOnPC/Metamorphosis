#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.level_start = (instance_exists(GenCont) || instance_exists(Menu));

#define skill_name    return "PYROMANIA";
#define skill_text    return "FIRE AND EXPLOSIONS @rIGNITE@s CORPSES";
#define skill_tip     return "HELL WORLD";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define step
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
		else if((place_meeting(x, y, CustomProjectile) && variable_instance_exists(instance_nearest(x, y, CustomProjectile), "pyroflammable")) || place_meeting(x, y, Flame) || place_meeting(x, y, FlameShell) || place_meeting(x, y, TrapFire) || place_meeting(x, y, Explosion)) {
			pyroignite = (30 + irandom(15)) * skill_get("pyromania");
		}
	}

