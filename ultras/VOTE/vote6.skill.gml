#define init
	global.sprSkillIcon = sprite_add("../../sprites/Icons/Ultras/VOTE/sprVote" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../../sprites/HUD/Ultras/VOTE/sprVote"   + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sprReroute   = sprite_add("../../sprites/VFX/sprReroute.png",  														 1,  0,  0);
	global.sndSkillSlct = sound_add("../../sounds/Ultras/sndUlt" + string_upper(string(mod_current)) + ".ogg");
	
	 // Don't Appear as an Ultra:
	skill_set_active(mod_current, false);
	
#define skill_name    return "TECH CONGLOMRAT";
#define skill_text    return "HOLDING @wENERGY WEAPONS@s#REROUTES @yAMMO GAIN";
#define skill_tip     return "BILLIONAIRES";
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
	with(Player) {
		if("lst_ammo" not in self) {
			for(i = 1; i < 5; i++) {
				lst_ammo[i] = ammo[i];
			}
		}
		
		for(i = 1; i < 5; i++) {
			if((weapon_get_type(wep) = 5 or (race = "steroids" and weapon_get_type(bwep) = 5)) and ammo[5] < typ_amax[5]) {
				if(lst_ammo[i] <= ammo[i]) {
					var diff   = (ammo[i] - lst_ammo[i]),
						pickno = round(diff/typ_ammo[i]);
					
					if(pickno > 0) {
						 // find related ammo popup
						with(instances_matching(PopupText, "conglomerate", null)) {
							if(string_count(string(diff), mytext) and string_count("NOT ENOUGH", mytext) = 0) {
								 // this is stupid but im lazy
								with(other) {
									with(instance_create(x, y, PopupText)) {
										if(other.ammo[5] + (pickno * other.typ_ammo[5]) >= other.typ_amax[5]) mytext = "@gMAX@w ENERGY";
										else mytext = `@1(${global.sprReroute})${pickno * other.typ_ammo[5]} ENERGY`
									}
								}
								
								
								instance_destroy();
							}
						}
						
						ammo[i] -= diff; 
						ammo[5] += min(pickno * typ_ammo[5], typ_amax[5] - ammo[5]);
						sound_play_pitch(sndLightningReload, 1.8 + random(0.3));
						sound_play_pitch(sndPlasmaReloadUpg, 2 + random(0.3));
					}
				}
			}	
			lst_ammo[i] = ammo[i];
		}
	}
	
	with(instances_matching(PopupText, "conglomerate", null)) {
		conglomerate = 1;
	}
