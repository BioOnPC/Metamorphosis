#define init
	global.sprSkillIcon = sprite_add("../../sprites/Icons/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../../sprites/HUD/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "ETHICAL CONSUMPTION";
#define skill_text    return "@wFULL AUTO POP POP@s WITH BULLET WEAPONS#RECYCLE HALF YOUR SPENT @yBULLET AMMO@s";
#define skill_tip     return "TEAR APART THIS ESTABLISHMENT";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(Player) {
		if(variable_instance_get(self, "consume_lstammo") != ammo[1]) {
			if("consume_lstammo" in self and consume_lstammo > ammo[1] and ammo[1] + ceil(weapon_get_cost(wep)/2) <= typ_amax[1]) {
				ammo[1] += ceil((consume_lstammo - ammo[1])/2);
				sound_play_pitchvol(sndImpWristKill, 1.4, 0.6);
				sound_play_pitchvol(sndRecGlandProc, 0.7, 0.6);
			}
			consume_lstammo = ammo[1];
		}
		
		 // make sure its possible to POP POP
		if(race = "venuz" and weapon_get_type(wep) = 1 and weapon_get_auto(wep) >= -1 and (canspec and button_check(index, "spec")) and can_shoot) {
			if(fork()) {
				wait(0);
				while(reload <= 0 && (ammo[weapon_get_type(wep)] >= weapon_get_cost(wep) || infammo != 0)){
					repeat(2 + (2 * skill_get(mut_throne_butt)) + (ultra_get(race, 2) * (skill_get(mut_throne_butt) + 1))) {
						player_fire(point_direction(x, y, mouse_x[index], mouse_y[index]));
					}
				}
				exit;
			}
		}
	}

