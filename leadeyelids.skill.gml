#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "LEAD EYELIDS";
#define skill_text    return "ENEMIES @wDON'T ACT@s FOR A#FEW SECONDS AFTER EXITING A @pPORTAL";
#define skill_tip     return "SO SLEEPY...";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut);
#define step
    if(instance_exists(GenCont) and GenCont.alarm0 > 0 and GenCont.alarm0 <= ceil(current_time_scale)) { 
		if(fork()) {
			wait 5;
			with(instances_matching(enemy, "leadsleep", null)) {
				leadsleep = 150 + random(30);
				leadalarm = alarm1;
			}
			exit;
		}
    }
	
	with(enemy) {
		if(variable_instance_exists(self, "leadsleep") and leadsleep > 0) {
			alarm1 = leadalarm;
			leadsleep -= current_time_scale;
			
			if(leadsleep <= 0) {
				instance_create(x, y, AssassinNotice).depth = depth - 1;
				sound_play_pitchvol(sndImpWristHit, 1.4 + random(0.4), 1);
				sound_play_pitchvol(sndDragonStart, 2 + random(0.4), 0.4);
			}
		}
	}