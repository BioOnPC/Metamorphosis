#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Ultras/sprUltraEFFIGYIcon.png", 3, 12, 16); 
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Ultras/sprUltra" + string_upper(string(mod_current)) + "HUD.png",  1,  9,  9);

#macro metacolor `@(color:${make_color_rgb(110, 140, 110)})`;
#macro snd mod_variable_get("mod", "metamorphosis", "snd")

#define skill_name    return "DISCIPLE";
#define skill_text    return `${metacolor}SACRIFICE THIS ULTRA@s#TO SUMMON A @gGIANT RAD BEAM@s`;
#define skill_tip     return "CHANGE THE WORLD";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  
	sprite_index = global.sprSkillIcon;
	image_speed = 0;
	image_index = 2;
	with(GameCont) mutindex--;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndBasicUltra);
		sound_play(snd.EffigyUltraC);
	}

#define skill_ultra   return "effigy";
#define skill_avail   return 0; // Disable from appearing in normal mutation pool