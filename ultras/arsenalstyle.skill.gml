#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "ARSENAL STYLE";
#define skill_text    return "@wWEAPONS@s PULLED BY @wTELEKINESIS@s#FIRE THEMSELVES";
#define skill_tip     return "CONTAIN IT ALL";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define skill_ultra   return "eyes";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(instances_matching(Player, "race", "eyes")) { // Find players that are playing eyes
		if(button_check(index, "spec")) { // Is eyes using his active?
			with(instances_matching_gt(WepPickup, "ammo", 0)) { // Find any weppickup that hasn't been touched yet
				var nenemy = instance_near(x, y, enemy, 128), 
					aim_dir = 0;
					
				if(instance_seen(x, y, nenemy)) {
					 // Make sure this only happens once and makes it so weppickups that fire expend their ammo
					ammo = 0;
					
					 // Effects
					sound_play_pitch(sndGunGun, 0.4 + random_range((weapon_get_load(wep)/2)/10, weapon_get_load(wep)/10));
					instance_create(x, y, LaserBrain);
					
					if(fork()) { // Fork the script to repeat it a couple of times
						if(!instance_exists(self) or !instance_exists(other)) exit; // Make sure no errors occur because something disappeared
						repeat(3 * skill_get("arsenalstyle")) { // Repeat three times
							with(other) { // cheeky way to avoid problems with firing from something other than the player 
								if(!instance_exists(self)) exit; // Make sure no errors occur because something disappeared
								 // Decide firing direction
								if(!instance_exists(nenemy)) aim_dir = point_direction(other.x, other.y, mouse_x[index], mouse_y[index]);
								else aim_dir = point_direction(other.x, other.y, nenemy.x, nenemy.y);
								
								 // Fire
								player_fire_ext(aim_dir, other.wep, other.x, other.y, team, id);
							}
							 // Visually rotate gun to aim direction
							rotation = aim_dir;
							
							wait weapon_get_load(wep); // Make sure 
						}
						exit; // Exit the forked script
					}
				}
			}
		}
	}
    
#define instance_seen(_x, _y, _obj)                                             return  mod_script_call_nc  ('mod', 'metamorphosis', 'instance_seen', _x, _y, _obj);
#define instance_near(_x, _y, _obj, _dis)										return  mod_script_call_nc  ('mod', 'metamorphosis', 'instance_near', _x, _y, _obj, _dis);