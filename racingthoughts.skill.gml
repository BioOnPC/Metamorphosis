#define init
	global.sprSkillIcon = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAABgAAAAgBAMAAAD6cKULAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAwUExURQAAABQTGyctMCAzVUhSWR9QhQBy8ECSkpceANFlAMeWAPCvAPPzAISPl6GzvfPz82qDn0UAAAAJcEhZcwAADsIAAA7CARUoSoAAAAFSSURBVCjPLZCxasNADIZlkvNQiGM/RMeA4bDnDF0DhiAPHUognKCBOq/RkqVryNKtYAKdQ9+gGFJI6GbI0GbokPOUoRSrsqmm++6/+39J4NuzZa6ntr45gFdxU0fmTIDnzBWfuW8O4GPWKF+2RgCIqPljUpPVwDrNTieaRmgZGDURTWNKbR8qJCSTyoU8U9SWpTyfgJsdmzPPiuIZ3HkbWq+3/AaqjeHvgrkASG0jzLY/L79wwqySzOt/wFSsZ1tmAdceNdp6zWLgeTKMmFwUxRP4ULEOK+7m+RCCAEBL98loD6II6giTu48E3AkEfoTo9nYhmMXS6WjEuLeL4HazcrwdJpMxxrB6eIXPEl2SxuB+sfFGAyAKI4Ll6nFfXhKZjiJA9MqBjDfWKgWVlKUyNNWhL6G9q3cXxxGGEh50uyrRMWHSwhCVbMq04DvtuowTBH/rJ7qqQZVxlgAAAABJRU5ErkJggg==", 1, 12, 16);
	global.sprSkillHUD  = sprite_add_base64("iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAC6SURBVDhPnVHBDcIwEMuefPgxBR/erMAkSP10At5ISEwS5Ls4cU5pFWrJysUXO5c2bSAHEiOtgzWfy5rfn68RNfWcG4tWYcL1djfSDA0rNDcqWkg1nM4XY5wAGgNeDwaFAB7c4u4E4Mik9JsbaQa6J7COxIQIAeFxq6MeQIC+nz1wdwJQx9WQ3qxoIfX3waw19xrgNTAIQM3bS3Nugll6iFP0flNW1kDt8/tgFX0ao4C/oLceCgCCOaUfX8/I2KnacDsAAAAASUVORK5CYII=",  1,  8,  8);
    skill_set_active(23, 0); // Disable normal trigger fingers

#define skill_name    return "RACING THOUGHTS";
#define skill_text    return "@wKILLS@s LOWER YOUR @wRELOAD TIME@s#BASED ON @wENEMY @rHP";
#define skill_tip     return "FASTEST POPS IN THE WEST";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMutTriggerFingers);
#define step
    with(instances_matching_le(enemy, "my_health", 0)) { // Find all dead enemies
        if(!variable_instance_exists(self, "racingthoughts")) {
            racingthoughts = 1; // Make sure this only happens once
            var loadreduce = maxhealth; // Figure out how big of a bitch this was
            
            with(Player) {
                if(reload >= 1) reload = max(reload - floor(loadreduce/2), -floor(weapon_get_load(wep)/2));
                if(breload >= 1) {
                	if(race = "steroids") {
                		breload = max(breload - floor(loadreduce/2), -floor(weapon_get_load(wep)/2));
                	}
                	
                	else { // Not steroids
                		breload = max(breload - floor(loadreduce/4), -floor(weapon_get_load(wep)/4));
                	}
                }
            }
        }
    }