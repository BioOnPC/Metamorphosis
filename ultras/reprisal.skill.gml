#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "REPRISAL";
#define skill_text    return "@wFIRE PROJECTILES WHEN UNSHIELDING";
#define skill_tip     return "GOOD OFFENSE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define step
	with(instances_matching(CrystalShieldDisappear, "reprisal", null)) {
		reprisal = 1;
		if(instance_exists(creator)) {
			with(creator) {
				var mouse_dir = point_direction(x, y, mouse_x[index], mouse_y[index]);
				for(i = 0; i <= 360; i += 360/8) {
					with(reprisal_fire(x + lengthdir_x(12, mouse_dir + i), y + lengthdir_y(12, mouse_dir + i), mouse_dir + i, weapon_get_type(wep))) {
						creator = other;
					}
				}
			}
		}
	}

#define reprisal_fire(_x, _y, _dir, _type)
	var o = noone;
	switch(_type) {
		case 1: // BULLETS
			var ang = -15;
			repeat(3) {
				o = instance_create(_x, _y, Bullet1);
				with(o) {
					motion_add(_dir + ang, 12);
					image_angle = direction;
					team = other.team;
				}
				ang += 15;
			}
			
			sound_play_pitch(sndQuadMachinegun, 0.6);
			sound_play_pitchvol(sndClusterOpen, 1.4 + random(0.4), 1.4);
			sound_play_pitch(sndShielderDeflect, 0.4 + random(0.3));
		break;
		
		case 2: // SHELLS
			var ang = -15;
			repeat(3) {
				o = instance_create(_x, _y, Bullet2);
				with(o) {
					motion_add(_dir + ang, 12);
					image_angle = direction;
					team = other.team;
				}
				ang += 15;
			}
			
			sound_play_pitch(sndSawedOffShotgun, 0.6);
			sound_play_pitchvol(sndClusterOpen, 1.4 + random(0.4), 1.4);
			sound_play_pitch(sndShielderDeflect, 0.4 + random(0.3));
		break;
		
		case 3: // BOLTS
			o = instance_create(_x, _y, Bolt);
			with(o) {
				motion_add(_dir, 16);
				image_angle = direction;
				team = other.team;
			}
			
			sound_play_pitch(sndSuperSplinterGun, 0.6);
			sound_play_pitchvol(sndClusterOpen, 1.4 + random(0.4), 1.4);
			sound_play_pitch(sndShielderDeflect, 0.4 + random(0.3));
		break;
		
		case 4: // EXPLOSIVES
			o = instance_create(_x, _y, SmallExplosion);
			with(o) {
				team = other.team;
			}
			
			sound_play_pitch(sndExplosionL, 1.2);
			sound_play_pitchvol(sndClusterOpen, 1.4 + random(0.4), 1.4);
			sound_play_pitch(sndShielderDeflect, 0.4 + random(0.3));
		break;
		
		case 5: // LASERS
			o = instance_create(_x, _y, Laser);
			with(o) {
				direction = _dir;
				image_angle = direction;
				team = other.team;
				event_perform(ev_alarm, 0);
			}
			
			sound_play_pitch(sndLaserUpg, 0.6);
			sound_play_pitchvol(sndClusterOpen, 1.4 + random(0.4), 1.4);
			sound_play_pitch(sndShielderDeflect, 0.4 + random(0.3));
		break;
		
		default: 
			var ang = -15;
			for(i = 0; i <= 2; i++) {
				o = instance_create(_x, _y, Bullet1);
				with(o) {
					motion_add(_dir + ang, 12);
					team = other.team;
				}
				ang += 15;
			}
			
			sound_play_pitch(sndQuadMachinegun, 0.6);
			sound_play_pitchvol(sndClusterOpen, 1.4 + random(0.4), 1.4);
			sound_play_pitch(sndShielderDeflect, 0.4 + random(0.3));
		break;
	}
	
	return o;

#define skill_ultra
    return "crystal";
 
#define skill_avail
    return 0; // Disable from appearing in normal mutation pool