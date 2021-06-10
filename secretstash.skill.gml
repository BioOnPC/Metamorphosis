#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	global.sndSkillSlct = sound_add("sounds/sndMut" + string_upper(string(mod_current)) + ".ogg");
	global.sprMachine     = sprite_add("sprites/Props/sprSodaMachine.png",  	1,  16,  16);
	global.sprMachineHurt = sprite_add("sprites/Props/sprSodaMachineHurt.png",  3,  16,  16);
	global.sprMachineDead = sprite_add("sprites/Props/sprSodaMachineDead.png",  3,  16,  16);
	global.taken = 0;

#define skill_name      return "SECRET STASH";
#define skill_text      return "GET A @wSODA SUPPLY DROP!@s";
#define skill_tip       return choose("DRINK @wSODA!@s FOREVER", "@q@wRADICAL!");
#define skill_icon      return global.sprSkillHUD;
#define skill_button    sprite_index = global.sprSkillIcon;
#define skill_take(_num)
	if(global.taken and global.taken < _num) global.taken = 0;
	
	if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) {
		sound_play(sndMut);
		sound_play(global.sndSkillSlct);
	}
	
	else if(!global.taken) {
		soda_spawn();
		
		global.taken += global.taken - _num;
	}
	
#define skill_avail     return mod_exists("mod", "defpack tools");
#define skill_sacrifice return false; // Stop Effigy from sacrificing this mutation
#define step
	if(!instance_exists(GenCont) and !global.taken) {
		soda_spawn();
		global.taken += global.taken - skill_get(mod_current);
	}

#define soda_spawn
	var vfloors = instances_matching_ne(Floor, "object_index", FloorExplo);
	
	with(vfloors) {
		if(!collision_rectangle(x, y, x + sprite_width, y + sprite_height, hitme, false, false) and !collision_rectangle(x, y, x + sprite_width, y + sprite_height, chestprop, false, false) and !collision_rectangle(x, y, x + sprite_width, y + sprite_height, Wall, false, false)) stashlocated = true;
	}
	
	vfloors = instances_matching(Floor, "stashlocated", true);
	
	repeat(10 + (skill_get(mod_current) * 4)) {
		var locfloor = vfloors[irandom(array_length(vfloors) - 1)]; 
		with(instance_create(locfloor.x + (locfloor.sprite_width/2), locfloor.y + (locfloor.sprite_height/2), SodaMachine)) {
			spr_idle = global.sprMachine;
			spr_hurt = global.sprMachineHurt;
			spr_dead = global.sprMachineDead;
			spr_shadow = shd24;
			spr_shadow_y = 6;
		}
		
		locfloor.stashlocated = false;
		vfloors = instances_matching(Floor, "stashlocated", true);
	}

	sound_play_pitch(sndSodaMachineBreak, 1.4 + random(0.3));
	sound_play_pitch(sndSnowBotSlideStart, 1.5 + random(0.2));
	sound_play_pitch(sndSnowTankPreShoot, 1.7 + random(0.2));
