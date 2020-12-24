#define init
	//global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	//global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "BUSY BODY";
#define skill_text    return "PICKING UP @wWEAPON@s DROPS#GIVES @wINFINITE AMMO";
#define skill_tip     return "CAN'T STOP MOVING";
//#define skill_icon    return global.sprSkillHUD;
//#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut);

#define step
    with(Player) {
    	if("busywep" not in self) {
    		busywep = wep;
    		busybwep = bwep;
    	}
    	
    	if(busywep != wep) { // if main wep changes
    		if(busywep != bwep and bwep != wep_none) { // make sure your main weapon switching out because of mods doesnt pop busy body
    			busybody_ammo(); // infinite ammo time
    		}
    		
    		busywep = wep;
    	}
    	
    	if(busybwep != bwep) { // if bwep changes
    		if(busybwep = wep_none) { // now THIS is to specifically make something like chicken's thrown wep ultra work! secret synergy
    			busybody_ammo(); // infinite ammo time
    		}
    		
    		busybwep = bwep;
    	}
    }
    
#define busybody_ammo
	if(infammo <= 0) { // funny effects
		sound_play_pitch(sndShotReload, 0.8 + random(0.4));
		sound_play_pitchvol(sndNadeReload, 0.5 + random(0.2), 1.2);
		sound_play_pitch(sndShotgunHitWall, 0.7 + random(0.2));
		sound_play_pitchvol(sndRobotEat, 1.5 + random(0.3), 1.4);
	}
	
	infammo += (infammo > 0 ? 1 : 60); // hotswapping shouldnt break this, it just lengthens out the time