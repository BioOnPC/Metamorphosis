#define init
	if(effigy_get_muts()[0] = mut_none or effigy_get_muts()[1] = mut_none) effigy_set_muts(skill_decide(), skill_decide());
	global.sprIdle[0]   =  sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Idle.png",   4, 24, 24);
	global.sprWalk[0]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Walk.png",   6, 24, 24);
	global.sprHurt[0]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Hurt.png",   3, 24, 24);
	global.sprDead[0]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Dead.png",   6, 24, 24);
	global.sprSit[0]    = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Sit.png",    1, 12, 12);
	global.sprGoSit[0]  = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "GoSit.png",  3, 12, 12);
	global.sprMap[0]    = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "MapA.png",   1, 10, 10);
	global.sprSkin[0]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "SkinA.png",  1, 16, 16);
	
	global.sprIdle[1]   =  sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "IdleB.png",   4, 24, 24);
	global.sprWalk[1]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "WalkB.png",   6, 24, 24);
	global.sprHurt[1]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "HurtB.png",   3, 24, 24);
	global.sprDead[1]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "DeadB.png",   6, 24, 24);
	global.sprSit[1]    = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "SitB.png",    1, 12, 12);
	global.sprGoSit[1]  = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "GoSitB.png",  3, 12, 12);
	global.sprMap[1]    = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "MapB.png",    1, 10, 10);
	global.sprSkin[1]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "SkinB.png",   1, 16, 16);
	
	global.sprSelect = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Select.png", 1, 0,  0);

	with(instances_matching(Player, "race", mod_current)) { // Reapply sprites if the mod is reloaded. we should add this to our older race mods //
		assign_sprites();
		assign_sounds();
	}

#macro categories mod_variable_get("mod", "metamorphosis", "mut_category")
#macro metacolor `@(color:${make_color_rgb(110, 140, 110)})`;
#macro SETTING mod_variable_get("mod", "metamorphosis_options", "settings")
#macro snd mod_variable_get("mod", "metamorphosis", "snd")

#define race_name              return "EFFIGY";
#define race_text
	var e = effigy_get_muts();

	return `START WITH@3(${skill_get_icon(e[0])[0]}:${skill_get_icon(e[0])[1]})AND@3(${skill_get_icon(e[1])[0]}:${skill_get_icon(e[1])[1]})#${metacolor}SACRIFICE@w YOUR MUTATIONS`;
#define race_menu_button       sprite_index = global.sprSelect;
#define race_skins			   return 2;
#define race_skin_button	   sprite_index = global.sprSkin[argument0];
#define race_lock              return `${metacolor}STORE MUTATIONS`;
#define race_unlock            return `FOR ${metacolor}STORING MUTATIONS`;
#define race_tb_text           return "GAIN AN @gADDITIONAL MUTATION@s OPTION#FOR SACRIFICED MUTATIONS";
/*#define race_cc_text		   
	if(skill_get_at(2) != undefined) return `${metacolor}STORE@s THE @gMUTATION@s YOU PICKED LAST`;
	else return "";*/

#define race_ultra_name
	switch(argument0)
	{
		case 1: return "EPITOME"; break;
		case 2: return "@d(NYI)@w"; break;
		case 3: return "MARTYR@d(NYI)@w"; break;
	}

#define race_ultra_text
	switch(argument0)
	{
		case 1: return `${metacolor}SACRIFICING@s MUTATIONS GRANTS#AN @wADDITIONAL EFFECT@s`;
		case 2: return "NOT YET IMPLEMENTED";
		case 3: return `${metacolor}SACRIFICE THIS ULTRA@s FOR A SPECIAL ALLY#@dNOT YET IMPLEMENTED@`;
	}
//#define race_portrait(_p, _b)  return race_sprite_raw("Portrait", _b);
#define race_mapicon(_p, _b)   return global.sprMap;
#define race_avail             return 1 //option_get("effigy_unlocked");
#define race_ttip
	 // ULTRA TIPS //
	if(instance_exists(GameCont) and GameCont.level >= 10 and random(5) < 1) return choose("UNEARTHLY SECRETS", "KNOW THE UNKNOWABLE", "BECOME REMADE", "EUREKA", "AUTOMATON KING");
	
	 // NORMAL TIPS //
	else return choose("METAMORPHICAL SCHEME", "GENE SPLICING", "FIELD EXPERIMENTS", "SACRIFICAL LAMB", "MAGICAL SCIENCES", "WHO ARE YOU", "EFFIGY IS LOYAL");
	
#define create
	var e = effigy_get_muts();
	skill_set(e[0], 1);
	skill_set(e[1], 1);
	
	assign_sprites();
	assign_sounds();
	sound_play(snd_crwn);
	
	effigy_eligible = [];
	effigy_lerp = 0;
	effigy_selected = -1;
	effigy_hover = 0;
	effigy_orbital = [];
	effigy_sacrificed = [];
	
#define step
	if(array_length(instances_matching(CustomDraw, "name", "EffigyDraw")) = 0) with(script_bind_draw(EffigyDraw, depth + 1)) name = "EffigyDraw";
	if(array_length(instances_matching(CustomDraw, "name", "EffigyHudDraw")) = 0) with(script_bind_draw(EffigyHudDraw, -1002)) name = "EffigyHudDraw";

	with(Player) {
		if("effigy_invuln" in self and effigy_invuln > 0) {
			effigy_invuln -= current_time_scale;
			candie = 0;
			
			if(fork()) {
				wait 0;
				if(instance_exists(GenCont) or instance_exists(LevCont)) effigy_invuln = 0;
				exit;
			}
			
			
			var effhp = my_health;
			if(fork()) {
				wait 0;
				if(!instance_exists(self)) exit;
				if(my_health < effhp) {
					my_health = effhp;
					sound_play_pitch(sndExploFreakDead, 0.6 + random(0.2));
					sound_play_pitch(sndCrownGuardianHurt, 0.4 + random(0.3));
					sound_play_pitch(sndHyperCrystalHurt, 0.3 + random(0.3));
				}
			}
			
			if(effigy_invuln <= 0) {
				candie = 1;
				sound_play_pitch(sndExploFreakHurt, 0.7 + random(0.2));
				sound_play_pitch(sndCrownGuardianAppear, 0.4 + random(0.3));
				sound_play_pitch(sndHyperCrystalSearch, 0.5 + random(0.3));
			}
		}
		
		if("effigy_acc" in self and effigy_acc and (hastened = 0 or (instance_exists(GenCont) or instance_exists(LevCont)))) {
			hastened = 0;
			effigy_acc = 0;
			accuracy *= 2;
		}
	}

	if(usespec or (canspec and button_check(index, "spec"))) {
		if(button_pressed(index, "spec") and !instance_exists(LevCont)) {
			var m = 0;
			
			effigy_eligible = [];
			
			while(skill_get_at(m) != undefined) {
				if(mod_script_call("mod", "metamorphosis", "skill_get_avail", skill_get_at(m)) and array_length(instances_matching(instances_matching(CustomObject, "name", "OrchidSkill"), "skill", skill_get_at(m))) = 0) array_push(effigy_eligible, skill_get_at(m));
				m++;
			}
			
			if(array_length(effigy_eligible) = 0) {
				sound_play_pitch(sndCursedReminder, 1 + random(0.2));
			}
			
			else {
				sound_play_pitch(sndGuardianFire, 0.6 + random(0.2));
				sound_play_pitch(sndDogGuardianJump, 0.7 + random(0.2));
				sound_play_pitchvol(sndHyperCrystalRelease, 0.3 + random(0.5), 0.4);
			}
		}
		
		effigy_lerp = lerp(effigy_lerp, 1, 0.25 * current_time_scale);
		
		if(array_length(effigy_eligible) > 0) {
			var ang = ((point_direction(x, y, mouse_x[index], mouse_y[index]) + ((360 div array_length(effigy_eligible))/2)) mod 360) div (360 div array_length(effigy_eligible)),
				lstselect = effigy_selected;
			
			if(effigy_selected != -1 and point_distance(x, y, mouse_x[index], mouse_y[index]) < 96) {
				effigy_hover = lerp(effigy_hover, 2, 0.60 * current_time_scale);
			}
			
			if(fork()) {
				wait 0;
				if(!instance_exists(self)) exit;
				
				if(effigy_selected != lstselect) {
					effigy_hover = 0;
					
					if(effigy_selected = -1) sound_play_pitch(sndChickenThrow, 1.5 + random(0.3));
					else sound_play_pitchvol(sndDiscBounce, 2.4 + random(0.3), 0.6);
				}
				exit;
			}
			
			effigy_selected = (point_distance(x, y, mouse_x[index], mouse_y[index]) < 96 ? ang : -1);
		}
	}
	
	else {
		if(button_released(index, "spec")) {
			if(effigy_selected != -1) {
				
				 // LOTS OF EFFECTS //
				sleep(100);
				sound_play_pitchvol(sndUltraGrenade, 1.6 + random(0.4), 0.8);
				sound_play_pitch(sndLevelUp, 0.6 + random(0.4));
				sound_play_pitchvol(sndHyperCrystalSpawn, 1.6 + random(0.4), 0.4);
				sound_play(snd.EffigyConfirm);
				
				repeat(irandom_range(5, 10)) {
					with(instance_create(x, y, EatRad)) {
						sprite_index = sprEatBigRad;
						image_index += irandom(3);
						image_speed = 0.35;
						motion_add(random(360), random_range(1, 3));
						hspeed += other.hspeed;
						vspeed += other.vspeed;
						friction = 0.08;
					}
				}
				
				with(instance_create(x, y, ScorpionBulletHit)) {
		    		image_speed = 0.3;
				}
				
				var t = `${metacolor}${skill_get_name(effigy_eligible[effigy_selected])} @wSACRIFICED`,
					c = get_category(effigy_eligible[effigy_selected]);
				
				if(c != 0) {
					array_push(effigy_sacrificed, effigy_eligible[effigy_selected]);
					skill_set(effigy_eligible[effigy_selected], 0);
					with(GameCont) skillpoints++;
					t += `#${get_sacrifice(c)}`;
					if(ultra_get(race, 1)) {
						t += `#${get_sacrifice(irandom(4))}`;
					}
				}
				
				with(instance_create(x, y, PopupText)) {
					mytext = t;
				}
			}
			
			else {
				sound_play_pitchvol(sndUltraEmpty, 0.5 + random(0.2), 0.6);
				sound_play_pitchvol(sndHorrorEmpty, 0.2 + random(0.4), 0.6);
			}
			
			effigy_selected = -1;
		}
		
		effigy_lerp = lerp(effigy_lerp, 0, 0.30 * current_time_scale);
	}

#define EffigyDraw
	with(instances_matching(Player, "race", "effigy")) {
		if(effigy_lerp > 0) {
			var amt = (360/array_length(effigy_eligible)),
				startang = 180 * effigy_lerp,
				curang = startang,
				mdir = point_direction(x, y, mouse_x[index], mouse_y[index]);
			
			draw_set_alpha(0.6);
			draw_circle_color(x, y, 32 * effigy_lerp, c_green, c_green, 0);
			draw_set_alpha(0.4);
			draw_line_width_color(x + lengthdir_x(10 * effigy_lerp, mdir), y + lengthdir_y(10 * effigy_lerp, mdir), x + lengthdir_x(32 * effigy_lerp, mdir), y + lengthdir_y(32 * effigy_lerp, mdir), 3, c_lime, c_lime);
			draw_circle_color(x, y, 10 * effigy_lerp, c_lime, c_lime, 0);
			draw_set_alpha(1);
			
			draw_circle_color(x, y, 32 * effigy_lerp, c_lime, c_lime, 1);
		}
	}

#define EffigyHudDraw
	with(instances_matching(Player, "race", "effigy")) {
		if(effigy_lerp > 0) {
			var amt = (360/array_length(effigy_eligible)),
				startang = 180 * effigy_lerp,
				curang = startang;
			
			draw_set_font(fntSmall);
			draw_set_halign(fa_center);
			if(effigy_selected != -1) draw_text_nt(x, y - (48 * effigy_lerp) + (2 * effigy_hover), `${skill_get_name(effigy_eligible[min(effigy_selected, array_length(effigy_eligible) - 1)])}`); 
			draw_set_halign(fa_left);
			draw_set_font(fntM);
			
			for(var i = 0; i < array_length(effigy_eligible); i++) {
				curang = startang + (amt * i);
				
				draw_sprite_ext(skill_get_icon(effigy_eligible[i])[0], skill_get_icon(effigy_eligible[i])[1], x - (lengthdir_x(28, curang) * effigy_lerp), y - (lengthdir_y(28, curang) * effigy_lerp) - (effigy_selected = i ? effigy_hover : 0), effigy_lerp, effigy_lerp, 0, (effigy_selected = i ? c_white : c_gray), effigy_lerp);
			}
		}
	}

#define assign_sprites
	spr_idle = global.sprIdle[bskin];
	spr_walk = global.sprWalk[bskin];
	spr_hurt = global.sprHurt[bskin];
	spr_dead = global.sprDead[bskin];
	spr_sit2 = global.sprSit[bskin];
	spr_sit1 = global.sprGoSit[bskin];

#define assign_sounds
	snd_hurt = snd.EffigyHurt;
	snd_dead = snd.EffigyDead;
	snd_lowa = snd.EffigyLowAM;
	snd_lowh = snd.EffigyLowHP;
	snd_wrld = snd.EffigyWorld;
	snd_crwn = snd.EffigyConfirm;
	snd_chst = snd.EffigyChest;
	snd_valt = snd.EffigyVault;
	snd_thrn = snd.EffigyVault;
	snd_spch = snd.EffigyThrone;
	snd_idpd = snd.EffigyIDPD;
	snd_cptn = snd.EffigyCaptain;

#define get_category(mut)
	for(var i = 1; i < array_length(categories); i++) {
		if(array_find_index(categories[i], mut) != -1) {
			return i;
		}
	}
	
	return 0;
	
#define get_sacrifice(mut)
	with(Player) {
		if("effigy_orbital" not in self) effigy_orbital = [];
		repeat(mut = 2 ? 2 : 1) with(obj_create(x, y, "EffigyOrbital")) {
			index = array_length(other.effigy_orbital);
			array_push(other.effigy_orbital, id);
			creator = other;
			team = other.team;
			type = mut;
			
			if(type = 2) {
				maxhealth = other.maxhealth * 3;
				mask_index = mskPlayer;
				image_blend = c_red;
			}
			
			if(type = 3) image_blend = c_gray;
			if(type = 4) image_blend = c_orange;
			
			repeat(GameCont.level - 1) {
				maxhealth *= 1.1;
			}
			
			my_health = maxhealth;
		}
	}

	switch(mut) {
		case 1: // OFFENSIVE -- Summon an allied gunner drone for all players
			sound_play_pitch(sndSwapMotorized, 0.6 + random(0.2));
			sound_play_pitch(sndHorrorPortal, 0.8 + random(0.3));
			return "@sARTIFICAL BACKUP!"
		break;
		
		case 2: // DEFENSIVE -- a handful of seconds of invulnerability for all players
			sound_play_pitch(sndCrystalShield, 0.6 + random(0.2));
			sound_play_pitch(sndShielderDeflect, 1.4 + random(0.4));
			sound_play_pitch(sndEliteShielderTeleport, 1.4 + random(0.4));
			sound_play_pitch(sndHyperCrystalTaunt, 1.7 + random(0.2));
			
			return "@sRADIATION SHIELD!";
		break;
		
		case 3: // UTILITY -- Empowered, gives haste + increased accuracy 
			sound_play_pitch(sndDogGuardianJump, 0.6 + random(0.2));
			sound_play_pitch(sndDogGuardianLand, 1.4 + random(0.2));
			sound_play_pitch(sndHammer, 0.6 + random(0.3));
			
			return "@sHASTENED!";
		break;
		
		case 4:  // AMMO -- Ammo frenzy, gives a bunch of ammo pickups over time and spawns a few ammo chests near players
			sound_play_pitch(sndLightningShotgunUpg, 0.3 + random(0.4));
			
			return "@sINFINITE AMMO!"
		break;
	}
	
	return "";

#define effigy_set_muts(first, second)
	return mod_script_call("mod", "metamorphosis", "effigy_set_muts", first, second);

#define effigy_get_muts
	return mod_script_call("mod", "metamorphosis", "effigy_get_muts");

#define option_set(opt, val)
	return mod_script_call("mod", "metamorphosis", "option_set", opt, val);

#define option_get(opt)
	return mod_script_call("mod", "metamorphosis", "option_get", opt);
	
#define skill_get_icon(_skill)
	return mod_script_call("mod", "metamorphosis", "skill_get_icon", _skill);
	
#define skill_decide
	return mod_script_call("mod", "metamorphosis", "skill_decide");
	
#define obj_create(_x, _y, obj)
	return mod_script_call("mod", "metamorphosis", "obj_create", _x, _y, obj);
	
#define array_delete(_array, _index)
	return mod_script_call("mod", "metamorphosis", "array_delete", _array, _index);
