#define init
	global.sprSkillIcon = sprite_add("../../sprites/Icons/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../../sprites/HUD/Ultras/VOTE/sprVote"   + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sndSkillSlct = sound_add("../../sounds/Ultras/sndUlt" + string_upper(string(mod_current)) + ".ogg");
	
	 // Don't Appear as an Ultra:
	skill_set_active(mod_current, false);
	
#define skill_name    return "ANRCY";
#define skill_text    return "@wHASTENED AFTER REFLECTING PROJECTILES@s#DELAYED @wPOP POP@s WITH MELEE WEAPONS";
#define skill_tip     return "GET IT OVER WITH";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_ultra   return "venuz";
#define skill_avail   return false;

#define skill_take(_num)
	var _mult = skill_get("vote2bcool");
	if(_mult != 0){
		skill_set("vote2bcool", 0);
		skill_set(mod_current, _num * _mult);
	}
	
	 // Sound:
	if(_num > 0 && instance_exists(LevCont)){
		sound_play(sndBasicUltra);
		sound_play(global.sndSkillSlct);
	}
	
#define step
	with(instances_matching(Player, "race", "venuz")) {
		if(canspec and (button_pressed(index, "spec") or usespec)) {
			if(weapon_is_melee(wep) and reload <= 0) {
				sound_stop(sndMutant6No);
				sound_play(skill_get(mut_throne_butt) ? sndPopPopUpg : sndPopPop);
				if(fork()) {
					var w = wep;
					repeat((2 + ultra_get(race, 2)) * (skill_get(mut_throne_butt) + 1)) {
						if(!instance_exists(self) or w != wep) exit;
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
	    		sound_play_pitch(sndMoneyPileBreak, 0.4 + random(0.2));
    			sound_play_pitch(sndSwapHammer, 1.2 + random(0.4));
    			sound_play_pitch(sndSalamanderEndFire, 1.2 + random(0.3));
    			
    			with(instance_create(x, y, BulletHit)) {
					sprite_index = sprChickenB;
					image_angle = random(360);
				}
	    		
	    		haste(other.damage * 20, 0.6);
	    	}
	    }
	}

#define orandom(_num)                                            	    		return	mod_script_call_nc('mod', 'metamorphosis', 'orandom', _num);
#define haste(amt, pow)                                            	    		return	mod_script_call('mod', 'metamorphosis', 'haste', amt, pow);