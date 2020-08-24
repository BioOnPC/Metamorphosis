#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "TECHNICIAN";
#define skill_text    return "@wDOUBLED FIRERATE@s AND @wFULL-AUTO@s#FOR LOW TIER WEAPONS";
#define skill_tip     return "HARDWARE UPGRADE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define skill_ultra   return "robot";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(Player) {
		if(button_check(index, "fire")) {
			if(fork()) {
				wait(0);
				if(instance_exists(self)) player_tech_fire(reload, wep, 0);
				exit;
			}
		}
		
		if(weapon_get_area(wep) < 9 and reload > 0) reload -= reloadspeed * 2;
		
		if(race = "steroids") {
			if(canspec and button_check(index, "spec")) {
				if(fork()) {
					wait(0);
					if(instance_exists(self)) player_tech_fire(breload, bwep, 1);
					exit;
				}
			}
			
			if(weapon_get_area(bwep) < 9 and breload > 0) breload -= reloadspeed * 2;
		}
	}
	
	if(random(20) < 1) {
		with(WepPickup) {
			if(weapon_get_area(wep) <= 9) {
				instance_create(x + lengthdir_x(random(sprite_width), rotation), y + lengthdir_y(random(sprite_height), rotation), CaveSparkle).depth = depth - 1;
			}
		}
	}

#define player_tech_fire(_reload, _wep, _b)
	if(weapon_get_area(_wep) < 9) {
		if(!weapon_get_auto(_wep)) {
			while(((_b and breload <= 0) or reload <= 0) && (ammo[weapon_get_type(_wep)] >= weapon_get_cost(_wep) || infammo != 0)){
				player_fire_ext(point_direction(x, y, mouse_x[index], mouse_y[index]), _wep, x, y, team, id);
				if(infammo = 0) ammo[weapon_get_type(_wep)] -= weapon_get_cost(_wep);
				if(_b) breload += weapon_get_load(_wep); else reload += weapon_get_load(_wep);
			}
		}
	}