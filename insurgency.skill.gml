#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkillInsurgencyIcon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkillInsurgencyHUD.png",  1,  8,  8);
	global.level_start = (instance_exists(GenCont) || instance_exists(Menu));

#define skill_name    return "INSURGENCY";
#define skill_text    return "@wSOME ENEMIES@s ARE REPLACED BY @wBANDITS#SOME @wBANDITS@s ARE ON YOUR SIDE";
#define skill_tip     return "SWAY THE MASSES";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
//#define skill_take    sound_play(sndMutTriggerFingers);
#define step
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	else if(global.level_start){
		global.level_start = false;
		with(instances_matching_le(enemy, "maxhealth", 30)) {
			if(random(60) < 1) {
				 // Fake body!
				with(instance_create(x, y, Corpse)) {
					sprite_index = other.spr_dead;
					size = other.size;
				}
				
				 // Deploy boys on nearby floors
				var dir = random(360);
				var nfloor = instance_nearest(x + lengthdir_x(16, dir), y + lengthdir_x(16, dir), Floor);
				for(i = 0; i < 5; i++) {
					instance_create(nfloor.x + 16, nfloor.y + 16, Bandit);
				}
				
				 // Kill he (with no drops!)
				instance_delete(self);
			}
		}
		
		with(Bandit) {
			if(random(15) < 1) {
				 // Spawn a friend
				with(instance_create(x, y, Ally)) {
					if(instance_exists(Player)) {
						creator = instance_nearest(x, y, Player);
						team = creator.team;
					}
				}
				
				 // Kill he (with no corpse!)
				instance_delete(self);
			}
		}
	}
