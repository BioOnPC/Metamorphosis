#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "PORTAL INSTABILITY";
#define skill_text    return "@bEXPLOSIVELY TELEPORT@s EVERY 7 SECONDS";
#define skill_tip     return "NEED AN I.T.";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut); //sound_mutation_play();
#define skill_avail   return false;
#define skill_cursed  return true; // for metamorphosis

#define step
	with(Player) {
		if("tele" not in self) {
			tele = 30 * 7;
		}
		
		if("televisual" not in self or !instance_exists(televisual)) {
			with(mod_script_call_nc('mod', 'metamorphosis', 'obj_create', x, y, "CheekPouch")) {
				creator = other.id;
				other.televisual = id;
			}
		}
		
		else with(televisual) depth = other.depth + 1;
		
		if(tele > 0) {
			if(!instance_exists(GenCont) and !instance_exists(LevCont)) tele -= current_time_scale;
			
			if(tele <= 0) {
				tele = 30 * 7;
				
				repeat(2 + (2 * skill_get(mod_current))) {
					with(instance_create(x, y, PopoExplosion)) {
						team = other.team;
						mask_index = mskSmallExplosion;
						image_xscale = (sprite_get_width(sprSmallExplosion)/sprite_get_width(sprPopoExplo));
						image_yscale = (sprite_get_height(sprSmallExplosion)/sprite_get_height(sprPopoExplo));
					}
				}
				
				var telefloor = instance_nearest(x + lengthdir_x(128, direction), y + lengthdir_y(128, direction), Floor),
					telefloorx = telefloor.x + (sprite_get_width(telefloor.sprite_index)/2),
					telefloory = telefloor.y + (sprite_get_height(telefloor.sprite_index)/2);
				
				x = telefloorx;
				y = telefloory;
				xprevious = x;
				yprevious = y;
				
				if(fork()) {
					wait 6;
					
					if("televisual" in self and instance_exists(televisual)) {
						televisual.scale = 4;
					}
					
					exit;
				}
				
				sound_play_pitch(sndFreakPopoRevive, 0.7 + random(0.2));
				sound_play_pitch(sndSwapEnergy, 0.6 + random(0.2));
				sound_play_pitch(sndIDPDNadeExplo, 1.5 + random(0.3));
				sound_play_pitch(sndDevastatorExplo, 1.2 + random(0.4));
				
				repeat(2 + (2 * skill_get(mod_current))) {
					with(instance_create(x, y, PopoExplosion)) {
						team = other.team;
						mask_index = mskSmallExplosion;
						image_xscale = (sprite_get_width(sprSmallExplosion)/sprite_get_width(sprPopoExplo));
						image_yscale = (sprite_get_height(sprSmallExplosion)/sprite_get_height(sprPopoExplo));
					}
				}
			}
		}
	}