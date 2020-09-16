#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "TECHNICIAN";
#define skill_text    return "@wDOUBLED FIRERATE@s AND @wFULL-AUTO@s#FOR LOW TIER WEAPONS";
#define skill_tip     return "HARDWARE UPGRADE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndBasicUltra);
#define skill_ultra   return "robot";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(Player) {
		if(button_check(index, "fire") and can_shoot) {
			if(fork()) {
				wait(0);
				if(instance_exists(self)) player_tech_fire();
				exit;
			}
		}
		
		if(weapon_get_area(wep) < 9 and weapon_get_area(wep) >= 0 and reload > reloadspeed) reload -= reloadspeed * 2;
		
		if(race = "steroids") {
			if(canspec and bcan_shoot and button_check(index, "spec")) {
				if(fork()) {
					wait(0);
					player_swap();
					if(instance_exists(self)) player_tech_fire();
					player_swap();
					exit;
				}
			}
			
			if(weapon_get_area(bwep) < 9 and weapon_get_area(bwep) >= 0 and breload > 0) breload -= reloadspeed * 2;
		}
	}
	
	if(random(20) < 1) {
		with(WepPickup) {
			if(weapon_get_area(wep) <= 9) {
				instance_create(x + lengthdir_x(random(sprite_width), rotation), y + lengthdir_y(random(sprite_height), rotation), CaveSparkle).depth = depth - 1;
			}
		}
	}

#define player_tech_fire()
	if(weapon_get_area(wep) < 9) {
		if(weapon_get_auto(wep) = 0) {
			while(reload <= 0 && (ammo[weapon_get_type(wep)] >= weapon_get_cost(wep) || infammo != 0)){
				player_fire(point_direction(x, y, mouse_x[index], mouse_y[index]));
			}
		}
	}

#define player_swap()
	/*
		Swaps weapons and weapon-related vars
		Called from a Player object
	*/
	
	with(["wep", "curse", "reload", "wkick", "wepflip", "wepangle", "can_shoot", "interfacepop"]){
		var _temp = variable_instance_get(other, self);
		variable_instance_set(other, self, variable_instance_get(other, "b" + self));
		variable_instance_set(other, "b" + self, _temp);
	}
	
	can_shoot = (reload <= 0);
	drawempty = 30;
	swapmove = true;
	clicked = false;