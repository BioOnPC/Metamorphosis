#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#define skill_name    return "REVOLUTIONARY";
#define skill_text    return "SPLIT @rDAMAGE@s AMONG @wALLIES";
#define skill_tip     return "ALL AS ONE";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define skill_ultra   return "rebel";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool

#define step
	with(instances_matching(Player, "race", "rebel")) {
		if(!variable_instance_exists(self, "reb_lsthealth")) reb_lsthealth = my_health;
		if(!button_check(index, "spec") and reb_lsthealth > my_health and reb_lsthealth - my_health > 1) {
			if(instance_exists(Ally)) {
				sound_play_pitch(sndBloodGamble, 1.4 + (instance_number(Ally)/10));
				sound_play_pitch(sndBloodHurt, 1 + (instance_number(Ally)/10));
				with(Ally) {
					instance_create(x, y, BloodGamble).depth = other.depth - 1;
					projectile_hit_raw(self, instance_number(Ally), snd_hurt);
				}
				
				my_health += max((reb_lsthealth - my_health) - instance_number(Ally), 1);;
			}
		}
		
		reb_lsthealth = my_health;
	}

