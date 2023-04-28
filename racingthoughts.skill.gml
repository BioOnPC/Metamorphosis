#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAC6SURBVDhPnVHBDcIwEMuefPgxBR/erMAkSP10At5ISEwS5Ls4cU5pFWrJysUXO5c2bSAHEiOtgzWfy5rfn68RNfWcG4tWYcL1djfSDA0rNDcqWkg1nM4XY5wAGgNeDwaFAB7c4u4E4Mik9JsbaQa6J7COxIQIAeFxq6MeQIC+nz1wdwJQx9WQ3qxoIfX3waw19xrgNTAIQM3bS3Nugll6iFP0flNW1kDt8/tgFX0ao4C/oLceCgCCOaUfX8/I2KnacDsAAAAASUVORK5CYII=",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");

#define skill_name    return "RACING THOUGHTS";
#define skill_text    return "@wKILLS@s LOWER YOUR @wRELOAD TIME@s#BASED ON @wENEMY @rHP";
#define skill_tip     return "FASTEST POPS IN THE WEST";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_type    return "offensive";
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}
	
#define step
    with(instances_matching_le(enemy, "my_health", 0)) { // Find all dead enemies
        if(!variable_instance_exists(self, "racingthoughts")) {
            racingthoughts = 1; // Make sure this only happens once
            var loadreduce = maxhealth * 0.75 * (skill_get(mod_current) + 1)/2; // Figure out how big of a bitch this was
            
            with(Player) {
            	gunshine = 7;
                if(reload >= 1) reload = max(reload - floor(loadreduce), -floor(weapon_get_load(wep)));
                if(breload >= 1) {
                	if(race = "steroids") {
                		breload = max(breload - floor(loadreduce), -floor(weapon_get_load(wep)));
                	}
                	
                	else { // Not steroids
                		breload = max(breload - floor(loadreduce/2), -floor(weapon_get_load(bwep)/2));
                	}
                }
            }
        }
    }