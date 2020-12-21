#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sprCartridge = sprite_add("sprites/VFX/sprFatAmmo.png",  7,  6,  6);

#define skill_name    return "MAGAZINE FINGERS";
#define skill_text    return "GET MORE @yAMMO@s";
#define skill_tip     return "OVERLOADED";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut);
#define step
    with(instances_matching(AmmoPickup, "cartridge", null)) {
    	cartridge = 1;
    	sprite_index = global.sprCartridge;
    }
    
    with(instances_matching(Player, "cartridge", null)) {
    	cartridge = 1;
    	for(i = 0; i <= 5; i++) {
    		typ_ammo[i] = ceil(typ_ammo[i] * (1 + (0.4 * skill_get("magfingers"))));
    	}
    }