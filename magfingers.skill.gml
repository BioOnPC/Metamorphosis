#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkillMagFingersIcon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkillMagFingersHUD.png",  1,  8,  8);
	global.sprCartridge = sprite_add("sprites/VFX/sprFatAmmo.png",  7,  6,  6);

#define skill_name    return "MAGAZINE FINGERS";
#define skill_text    return "@yAMMO PICKUPS@s GIVE MORE AMMO";
#define skill_tip     return "OVERLOADED";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define step
    with(instances_matching(AmmoPickup, "cartridge", null)) {
    	cartridge = 1;
    	sprite_index = global.sprCartridge;
    	num += 0.4;
    }