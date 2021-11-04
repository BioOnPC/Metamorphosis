#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);
	global.sndSkillSlct = sound_add("../sounds/Ultras/sndUlt" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "SUPER RESOURCEFUL";
#define skill_text    return "LOSING @rHEALTH@s GIVES @bSTRIKE AMMO@s";
#define skill_tip     return "ARMS RACE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon; with(GameCont) mutindex--;
#define skill_take(_num)
     // Sound:
	if(_num > 0 && instance_exists(LevCont)){
		sound_play(sndBasicUltra);
		sound_play(global.sndSkillSlct);
	}
#define skill_ultra   return "rogue";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(Player) {
		var hp = my_health;
		if(fork()){
			wait(0);
			if(!instance_exists(self)){exit;}
			if(my_health < hp){
				rogueammo = min(rogueammo + 1, ultra_get(char_rogue,1) > 0 ? 6 : 3);
				instance_create(x, y, PopupText).mytext = rogueammo = 3 + (ultra_get(char_rogue, 1) * 3) ? "MAX PORTAL STRIKES" : "+1 PORTAL STRIKE"
				sound_play_pitch(sndRogueCanister, 1.4 + random(0.4));
				sound_play_pitch(sndWeaponChest, 0.7 + random(0.2));
				sound_play_pitch(sndSwapMotorized, 0.4 + random(0.2));
			}
			exit;
		}
	}