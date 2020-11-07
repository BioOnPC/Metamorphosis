#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "SUPER RESOURCEFUL";
#define skill_text    return "@wENEMIES@s AND @bIDPD@s DROP @bPORTAL STRIKES";
#define skill_tip     return "ARMS RACE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take    sound_play(sndBasicUltra);
#define skill_ultra   return "rogue";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(instances_matching_le(enemy, "my_health", 0)) { // Find all dead enemies
		var strikechance = 0;
		switch(object_index) {
			case Grunt: 
			case PopoFreak: strikechance = 12; break;
			case Inspector: 
			case Shielder: strikechance = 8; break;
			case EliteGrunt: 
			case EliteShielder: 
			case EliteInspector: strikechance = 4; break;
			case Van: strikechance = 1; break;
			default: strikechance = 32;
		}
		
		if(variable_instance_exists(self, "resourcefulchance")) strikechance = rousrcefulchance;
		
		if(random(strikechance) < skill_get("superresourceful")) { 
			with(instance_create(x, y, RoguePickup)) alarm0 -= 120;
			with(instance_create(x, y, SmallExplosion)) {
				damage = 0;
				sprite_index = sprPopoExplo;
				mask_index = mskNone;
				image_xscale = 0.2;
				image_yscale = 0.2;
				sound_play_pitch(sndRogueAim, 1.8);
				sound_play_pitch(sndRogueCanister, 1.4);
			}
		}
	}