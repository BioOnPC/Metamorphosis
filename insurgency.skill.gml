#define init
	global.sprSkillIcon     = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD      = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",    1,  8,  8);
	global.sprFlagAllyIdle  = sprite_add("sprites/VFX/sprFlagAllyIdle.png",                                         6,  24,  24);
	global.sprFlagAllyWalk  = sprite_add("sprites/VFX/sprFlagAllyWalk.png",                                         6,  24,  24);
	global.sprFlagAllyHurt  = sprite_add("sprites/VFX/sprFlagAllyHurt.png",                                         3,  24,  24);
	global.sprFlagAllyDead  = sprite_add("sprites/VFX/sprFlagAllyDead.png",                                         6,  24,  24);
	global.sprFlag          = sprite_add("sprites/VFX/sprFlag.png",                                                 5,  8,  16);

	global.level_start = (instance_exists(GenCont) || instance_exists(Menu));

#define skill_name    return "INSURGENCY";
#define skill_text    return "@wWEAKER ENEMIES@s ARE REPLACED BY @wBANDITS#SOME @wBANDITS@s ARE ON YOUR SIDE";
#define skill_tip     return "SWAY THE MASSES";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) sound_play(sndMut); //sound_mutation_play();
#define step
	if(instance_exists(GenCont) || instance_exists(Menu)){
		global.level_start = true;
	}
	else if(global.level_start){
		global.level_start = false;

		var insurrection = (instance_number(enemy) * 0.4) * skill_get(mod_current);
		while(insurrection > 0 and array_length(instances_matching_le(enemy, "my_health", 30 + (1.5 * GameCont.loops))) > instance_number(Bandit)) {
			with(instances_matching_le(enemy, "my_health", 32 + (4 * GameCont.loops))) {
				if(object_index != Bandit and random(100) < 1) {
					insurrection -= my_health;

					 // Fake body!
					with(instance_create(x, y, Corpse)) {
						sprite_index = other.spr_dead;
						size = other.size;
						insurgencyflag = 1;
					}

					 // Deploy boys on nearby floors
					var dir = random(360);
					var nfloor = instance_nearest(x + lengthdir_x(16, dir), y + lengthdir_x(16, dir), Floor);
					for(i = 0; i < 5; i++) {
						instance_create(nfloor.x + 16, nfloor.y + 16, Bandit);
						instance_create(nfloor.x + 16, nfloor.y + 16, PortalClear).mask_index = mskBandit;
					}

					 // Kill he (with no drops!)
					instance_delete(self);
				}

			}
		}

		with(Bandit) {
			if(random(25 * (1/skill_get(mod_current))) < 1) {
				 // Spawn a friend
				with(instance_create(x, y, Ally)) {
					spr_idle = global.sprFlagAllyIdle;
					spr_walk = global.sprFlagAllyWalk;
					spr_hurt = global.sprFlagAllyHurt;
					spr_dead = global.sprFlagAllyDead;

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

	script_bind_draw(corpseflag, -1);

#define corpseflag
	with(instances_matching(Corpse, "insurgencyflag", 1)) {
		draw_sprite(global.sprFlag, current_frame * 0.3, x, y - (4 * image_yscale));
	}

	with(instances_matching(Player, "race", "bandit")) {
		draw_sprite_ext(global.sprFlag, current_frame * 0.3, x - (4 * right), y - 8, (-image_xscale) * right, image_yscale, image_angle, image_blend, image_alpha);
	}

	instance_destroy();

#define sound_mutation_play()
		sound_play(sndMut);
		with instance_create(0, 0, CustomObject){
			lifetime = 0;
			stage = 0;
			pitch = 1;
			on_step = sound_step
			on_destroy = sound_destroy
		}

#define sound_step
	lifetime += current_time_scale;
	if lifetime >= 5 && stage = 0{
		stage++;
		sound_play_pitch(sndVenuz, 3)
	}if lifetime >= 11 && stage = 1{
		stage++;
		sound_stop(sndVenuz)
	}

	if lifetime >= 16 && stage = 2{
		stage++;
		sound_play_pitch(sndVenuz, 3)
	}if lifetime >= 22 && stage = 3{
		stage++;
		sound_stop(sndVenuz )
	}

	if lifetime >= 60 instance_destroy()

#define sound_destroy
