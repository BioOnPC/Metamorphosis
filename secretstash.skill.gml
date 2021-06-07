#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	global.sprMachine     = sprite_add("sprites/Props/sprSodaMachine.png",  	1,  16,  16);
	global.sprMachineHurt = sprite_add("sprites/Props/sprSodaMachineHurt.png",  3,  16,  16);
	global.sprMachineDead = sprite_add("sprites/Props/sprSodaMachineDead.png",  3,  16,  16);

#define skill_name      return "SECRET STASH";
#define skill_text      return "GET MORE @wSODA!";
#define skill_tip       return choose("DRINK @wSODA!@s FOREVER", "@q@wRADICAL!");
#define skill_icon      return global.sprSkillHUD;
#define skill_button    sprite_index = global.sprSkillIcon;
#define skill_take    
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}
#define skill_avail     return mod_exists("mod", "defpack tools");
#define skill_sacrifice return false; // Stop Effigy from sacrificing this mutation
#define step
	if(!instance_exists(GenCont)) {
	    with(instances_matching(Floor, "stashlocated", null)) {
	    	stashlocated = "HERE";
	    	
	    	if(object_index != FloorExplo and !collision_rectangle(x, y, x + sprite_width, y + sprite_height, hitme, false, false) and !collision_rectangle(x, y, x + sprite_width, y + sprite_height, chestprop, false, false) and (!instance_exists(SodaMachine) and random(20) < skill_get(mod_current))) {
	    		with(instance_create(x + (sprite_width/2), y + (sprite_height/2), SodaMachine)) {
	    			spr_idle = global.sprMachine;
	    			spr_hurt = global.sprMachineHurt;
	    			spr_dead = global.sprMachineDead;
	    			spr_shadow = shd24;
	    			spr_shadow_y = 6;
	    		}
	    	}
	    }
	}