#define init
	global.sprSkillIcon = sprite_add("../../sprites/Icons/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../../sprites/HUD/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "ANRCY";
#define skill_text    return "@wHASTENED AFTER REFLECTING PROJECTILES@s#DELAYED @wPOP POP@s WITH MELEE WEAPONS";
#define skill_tip     return "GET IT OVER WITH";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define skill_avail   return 0; // Disable from appearing in normal mutation pool
#define step
	with(Player) {
		if("anarchyhaste" not in self) anarchyhaste = 0;
		if(anarchyhaste > 0) {
			anarchyhaste -= current_time_scale;
			
			 // FAST EFFECTS
			if(speed > 0 and (current_frame mod (current_time_scale * 2)) = 0) { 
				with(instance_create(x - (hspeed * 2) + orandom(3), y - (vspeed * 2) + orandom(3), BoltTrail)) {
					creator = other; 
					image_angle = other.direction;
				    image_yscale = 1.4;
				    image_xscale = other.speed * 4;
				}
			}
			
			if(anarchyhaste <= 0) {
				sound_play_pitch(sndLabsTubeBreak, 1.4 + random(0.2));
				sound_play_pitch(sndSwapGold, 0.8 + random(0.1));
				
				with(instance_create(x, y, BulletHit)) {
					sprite_index = sprGunWarrantDisappear;
					image_angle = random(360);
				}
				
				maxspeed -= 0.6;
				reloadspeed -= 0.6;
			}
		}
		
		if(race = "venuz" and canspec and (button_pressed(index, "spec") or usespec)) {
			if(weapon_is_melee(wep) and reload <= 0) {
				sound_stop(sndMutant6No);
				sound_play(skill_get(mut_throne_butt) ? sndPopPopUpg : sndPopPop);
				if(fork()) {
					repeat((2 + ultra_get(race, 2)) * (skill_get(mut_throne_butt) + 1)) {
						player_fire(gunangle);
						wait(6);
					}
					exit;
				}
			}
		}
	}
	
	with(projectile) {
    	if(!variable_instance_exists(self, "anarchyteam")) anarchyteam = team;
	    if(instance_exists(Player) and anarchyteam != team and instance_nearest(x, y, Player).team = team) {
	    	anarchyteam = team;
	    	with(instance_nearest(x, y, Player)) {
	    		if(anarchyhaste <= 0) {
	    			maxspeed += 0.6;
	    			reloadspeed += 0.6;
	    		}
	    		
	    		sound_play_pitch(sndMoneyPileBreak, 0.4 + random(0.2));
    			sound_play_pitch(sndSwapHammer, 1.2 + random(0.4));
    			sound_play_pitch(sndSalamanderEndFire, 1.2 + random(0.3));
    			
    			with(instance_create(x, y, BulletHit)) {
					sprite_index = sprChickenB;
					image_angle = random(360);
				}
	    		
	    		anarchyhaste = other.damage * 20;
	    	}
	    }
	}

#define orandom(_num)                                            	    		return	mod_script_call_nc('mod', 'metamorphosis', 'orandom', _num);