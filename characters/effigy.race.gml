#define init
	if(effigy_get_muts()[0] = mut_none or effigy_get_muts()[1] = mut_none) effigy_set_muts(skill_decide(0), skill_decide(0));
	
	global.sprPortrait[0] = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Portrait.png", 1, 30, 250);
	global.sprIdle[0]     = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Idle.png",   4, 24, 24);
	global.sprWalk[0]     = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Walk.png",   6, 24, 24);
	global.sprHurt[0]     = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Hurt.png",   3, 24, 24);
	global.sprDead[0]     = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Dead.png",   6, 24, 24);
	global.sprSit[0]      = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Sit.png",    1, 12, 12);
	global.sprGoSit[0]    = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "GoSit.png",  3, 12, 12);
	global.sprMap[0]      = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "MapA.png",   1, 10, 10);
	global.sprSkin[0]     = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "SkinA.png",  1, 16, 16);
	
	global.sprIdle[1]   =  sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "IdleB.png",   4, 24, 24);
	global.sprWalk[1]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "WalkB.png",   6, 24, 24);
	global.sprHurt[1]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "HurtB.png",   3, 24, 24);
	global.sprDead[1]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "DeadB.png",   6, 24, 24);
	global.sprSit[1]    = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "SitB.png",    1, 12, 12);
	global.sprGoSit[1]  = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "GoSitB.png",  3, 12, 12);
	global.sprMap[1]    = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "MapB.png",    1, 10, 10);
	global.sprSkin[1]   = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "SkinB.png",   1, 16, 16);
	
	global.sprSelect      = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "Select.png",     1, 0, 0);
	global.sprSelectLock  = sprite_add("../sprites/Characters/Effigy/spr" + string_upper(string(mod_current)) + "SelectLock.png", 1, 0, 0);
	global.sprUltraIcon   = sprite_add("../sprites/Icons/Ultras/sprUltra" + string_upper(string(mod_current)) + "Icon.png",       3, 12, 16);
	global.sprUltraHUD[0] = sprite_add("../sprites/HUD/Ultras/sprUltraEIDOLONHUD.png",  1, 8, 8);
	global.sprUltraHUD[1] = sprite_add("../sprites/HUD/Ultras/sprUltraANATHEMAHUD.png", 1, 8, 8);

	global.sprOrbital[1] = sprite_add("../sprites/Characters/Effigy/Orbitals/sprOffensiveOrbital.png", 9, 12, 12);
	global.sprOrbital[2] = sprite_add("../sprites/Characters/Effigy/Orbitals/sprDefensiveOrbital.png", 9, 12, 12);
	global.sprOrbital[3] = sprite_add("../sprites/Characters/Effigy/Orbitals/sprUtilityOrbital.png",   9, 12, 12);
	global.sprOrbital[4] = sprite_add("../sprites/Characters/Effigy/Orbitals/sprAmmoOrbital.png",      9, 12, 12);
	global.sprOrbital[5] = global.sprOrbital[3]; // No purpose other than avoiding errors
	global.sprOrbital[6] = sprite_add("../sprites/Characters/Effigy/Orbitals/sprUltraOrbital.png",     9, 12, 12);
	
	global.sprOrbitalGlow[1] = sprite_add("../sprites/Characters/Effigy/Orbitals/sprOffensiveOrbitalGlow.png", 9, 12, 12);
	global.sprOrbitalGlow[2] = sprite_add("../sprites/Characters/Effigy/Orbitals/sprDefensiveOrbitalGlow.png", 9, 12, 12);
	global.sprOrbitalGlow[3] = sprite_add("../sprites/Characters/Effigy/Orbitals/sprUtilityOrbitalGlow.png",   9, 12, 12);
	global.sprOrbitalGlow[4] = sprite_add("../sprites/Characters/Effigy/Orbitals/sprAmmoOrbitalGlow.png",      9, 12, 12);
	global.sprOrbitalGlow[5] = global.sprOrbital[3]; // No purpose other than avoiding errors
	global.sprOrbitalGlow[6] = sprite_add("../sprites/Characters/Effigy/Orbitals/sprUltraOrbitalGlow.png",     9, 12, 12);
	
	global.sprOrbitalDie = sprite_add("../sprites/Characters/Effigy/Orbitals/sprOrbitalDie.png", 5, 12, 12);

	global.rerolls = 0;

	 // Reapply sprites if the mod is reloaded. we should add this to our older race mods //
	with(instances_matching(Player, "race", mod_current)) { 
		assign_sprites();
		assign_sounds();
	}
	
	with(instances_matching(CustomHitme, "name", "EffigyOrbital")) {
		assign_sprites();
	}

#macro categories mod_variable_get("mod", "metamorphosis", "mut_category")
#macro metacolor `@(color:${make_color_rgb(110, 140, 110)})`
#macro SETTING mod_variable_get("mod", "metamorphosis_options", "settings")
#macro snd mod_variable_get("mod", "metamorphosis", "snd")

#define race_name              return "EFFIGY";
#define race_text
	var e = effigy_get_muts();

	return `STARTS WITH@3(${skill_get_icon(e[0])[0]}:${skill_get_icon(e[0])[1]})AND@3(${skill_get_icon(e[1])[0]}:${skill_get_icon(e[1])[1]})##${metacolor}SACRIFICE@w MUTATIONS`;
#define race_swep              return wep_rusty_revolver;
#define race_menu_button    
	if(fork()) {
		wait 0;
		if(instance_exists(self)) sprite_index = (option_get("effigy_tokens") > 0 ? global.sprSelect : global.sprSelectLock);
		exit;
	}
#define race_skins			   return 2;
#define race_skin_button	   sprite_index = global.sprSkin[argument0];
#define race_lock              return `${metacolor}STORE MUTATIONS`;
#define race_unlock            return `FOR ${metacolor}STORING MUTATIONS`;
#define race_tb_text           return "GAIN AN @gADDITIONAL MUTATION@s OPTION#FOR SACRIFICED MUTATIONS";
#define race_cc_text		   return `${metacolor}REROLL@s SOME#MUTATION OPTIONS @wPER LOOP@s`;

#define race_ultra_name
	switch(argument0)
	{
		case 1: return "EIDOLON"; break;
		case 2: return "ANATHEMA"; break;
	}

#define race_ultra_button
	sprite_index = global.sprUltraIcon;
	image_index = argument0 - 1;
	image_speed = 0;

#define race_ultra_icon
	return global.sprUltraHUD[argument0 - 1];

#define race_ultra_text
	switch(argument0)
	{
		case 1: return `${metacolor}SACRIFICING@s MUTATIONS GRANTS#AN @wADDITIONAL EFFECT@s`; break;
		case 2: return `@wKILLS@s EXTEND ${metacolor}SACRIFICE DURATION@s`; break;
	}
	
#define race_ultra_take
	if(argument1 > 0 and instance_exists(LevCont)) {
		sound_play(sndBasicUltra);
		
		switch(argument0)
		{
			case 1: sound_play(snd.EffigyUltraA); break;
			case 2: sound_play(snd.EffigyUltraB); break;
			case 3: sound_play(snd.EffigyUltraC); break;
		}
	}

#define race_portrait(_p, _b)  return global.sprPortrait[0];
#define race_mapicon(_p, _b)   return global.sprMap[_b];
#define race_avail             
	return option_get("effigy_tokens");

#define race_ttip
	 // ULTRA TIPS //
	if(instance_exists(GameCont) and GameCont.level >= 10 and random(5) < 1) return choose("UNEARTHLY SECRETS", "KNOW THE UNKNOWABLE", "BECOME REMADE", "EUREKA", "AUTOMATON KING");
	
	 // NORMAL TIPS //
	else return choose("METAMORPHICAL SCHEME", "GENE SPLICING", "FIELD EXPERIMENTS", "SACRIFICAL LAMB", "MAGICAL SCIENCES", "WHO ARE YOU", "EFFIGY IS LOYAL");

#define game_start
	global.rerolls = 3;
	
	var t = option_get("effigy_tokens");
	option_set("effigy_tokens", t = undefined ? 0 : max(t - 1, 0));
	
	mod_script_call("mod", "metamorphosis", "metamorphosis_save");

#define create
	 // Random lets you play locked characters: (Can remove once 9941+ gets stable build)
	if(!race_avail()){
		race = "fish";
		player_set_race(index, race);
		exit;
	}
	
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
	
	if(ultra_get(mod_current, 2)) with(instances_matching(instances_matching_le(enemy, "my_health", 0), "anathema", null)) {
		anathema = true;
		
		var anathemaincrease = ceil(maxhealth/16),
			orbitals = instances_matching(CustomHitme, "name", "EffigyOrbital");
		
		if(array_length(orbitals)) {
			sound_play_pitchvol(sndRadMaggotDie, 1.4 + random(0.3), 0.4);
			sound_play_pitchvol(sndToxicBoltGas, 1.5 + random(0.2), 0.4);
			sound_play_pitchvol(sndGammaGutsProc, 1.2 + random(0.2), 0.4);
			
			with(orbitals) {
				my_health = min(maxhealth, my_health + anathemaincrease);
				instance_create(x, y, BulletHit).sprite_index = sprScorpionBulletHit;
			}
		}
	}

	if(usespec or (canspec and button_check(index, "spec"))) {
		if(button_pressed(index, "spec") and !instance_exists(LevCont) and !instance_exists(GenCont)) {
			var m = 0;
			
			var effigy_eligible_unsorted = [],
				s = skill_get_at(m);
			
			while(s != undefined) {
				if((s != mut_patience and 
					skill_get_category(s) != -1 and 
					(!mod_script_exists("skill", string(s), "skill_sacrifice") or mod_script_call("skill", string(s), "skill_sacrifice") != false)) and 
					(mod_script_call("mod", "metamorphosis", "skill_get_avail", s) or string_lower(`${s}`) = "disciple") and 
					array_length(instances_matching(instances_matching(CustomObject, "name", "OrchidSkill"), "skill", s)) = 0) {
					array_push(effigy_eligible_unsorted, [s, skill_get_category(s)]);
				}
				m++;
				s = skill_get_at(m);
			}
			
			array_sort_sub(effigy_eligible_unsorted, 1, 0);
			
			effigy_eligible = [];
			
			for(var i = 0; i < array_length(effigy_eligible_unsorted); i++){
				array_push(effigy_eligible, effigy_eligible_unsorted[i][0]);
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
		
		effigy_lerp = lerp(effigy_lerp, 1, 0.45 * current_time_scale);
		
		if(array_length(effigy_eligible) > 0) {
			var ang = ((point_direction(x, y, mouse_x[index], mouse_y[index]) + ((360 div array_length(effigy_eligible))/2)) mod 360) div (360 div array_length(effigy_eligible)),
				lstselect = effigy_selected;
			
			if(effigy_selected != -1 and point_distance(x, y, mouse_x[index], mouse_y[index]) < 120) {
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
			
			effigy_selected = (point_distance(x, y, mouse_x[index], mouse_y[index]) < 120 ? ang : -1);
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
				
				var t = `@w${skill_get_name(effigy_eligible[effigy_selected])} ${metacolor}SACRIFICED`,
					c = skill_get_category(effigy_eligible[effigy_selected]);
				
				if(c != 0) {
					if(c != 6) {
						array_push(effigy_sacrificed, effigy_eligible[effigy_selected]);
						with(GameCont) skillpoints++;
					}
					
					else {
						with(GameCont) endpoints++;
					}
					
					skill_set(effigy_eligible[effigy_selected], 0);
					t += `#${get_sacrifice(c)}`;
					if(ultra_get(race, 1)) {
						t += `#${get_sacrifice(irandom_range(1, 4))}`;
						sound_play_pitch(sndLevelUltra, 1.7 + random(0.2));
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
			draw_circle_color(x, y, 36 * effigy_lerp, c_green, c_green, 0);
			for(var i = 0; i < array_length(effigy_eligible); i++){
				var _c = make_color_rgb(72, 253, 8);
				switch(skill_get_category(effigy_eligible[i])){
					case 1:
						_c = make_color_rgb(41, 12, 12);
						break;
					case 2:
						_c = make_color_rgb(102, 0, 24);
						break;
					case 3:
						_c = make_color_rgb(16, 39, 79);
						break;
					case 4:
						_c = make_color_rgb(171, 156, 22);
						break;
					case 5:
						_c = make_color_rgb(148, 56, 192);
						break;
				}
				draw_pie(x, y, startang+90 - amt/2 + amt*i, startang+90 + amt/2 + amt*i, _c, 36 * effigy_lerp);
			}
			draw_set_alpha(0.4);
			draw_line_width_color(x + lengthdir_x(10 * effigy_lerp, mdir), y + lengthdir_y(10 * effigy_lerp, mdir), x + lengthdir_x(36 * effigy_lerp, mdir), y + lengthdir_y(36 * effigy_lerp, mdir), 3, c_lime, c_lime);
			draw_circle_color(x, y, 10 * effigy_lerp, c_lime, c_lime, 0);
			draw_set_alpha(1);
			
			draw_circle_color(x, y, 36 * effigy_lerp, c_lime, c_lime, 1);
		}
	}

#define EffigyHudDraw
	with(instances_matching(Player, "race", "effigy")) {
		if(effigy_lerp > 0) {
			var amt = (360/array_length(effigy_eligible)),
				startang = 180 * effigy_lerp,
				curang = startang,
				category = "";
			
			draw_set_font(fntSmall);
			draw_set_halign(fa_center);
			if(effigy_selected != -1) {
				switch(skill_get_category(effigy_eligible[max(min(effigy_selected, array_length(effigy_eligible) - 1), 0)])) {
					case 1: category = "BACKUP"; break;
					case 2: category = "INVULNERABILITY"; break;
					case 3: category = "EMPOWER"; break;
					case 4: category = "INFINITE AMMO"; break;
					case 6: category = "RAD BEAM"; break;
				}
				
				draw_text_nt(x, y - (60 * effigy_lerp) + (2 * effigy_hover), `${skill_get_name(effigy_eligible[max(min(effigy_selected, array_length(effigy_eligible) - 1), 0)])}`); 
				draw_text_nt(x, y - (52 * effigy_lerp) + (2 * effigy_hover), `@s${category}`)
			}
			draw_set_halign(fa_left);
			draw_set_font(fntM);
			
			for(var i = 0; i < array_length(effigy_eligible); i++) {
				curang = startang + (amt * i);
				
				draw_sprite_ext(skill_get_icon(effigy_eligible[i])[0], skill_get_icon(effigy_eligible[i])[1], x - (lengthdir_x(32, curang) * effigy_lerp), y - (lengthdir_y(32, curang) * effigy_lerp) - (effigy_selected = i ? effigy_hover : 0), effigy_lerp, effigy_lerp, 0, (effigy_selected = i ? c_white : c_gray), effigy_lerp);
			}
		}
	}

#define assign_sprites
	if(object_index = Player) {
		spr_idle = global.sprIdle[bskin];
		spr_walk = global.sprWalk[bskin];
		spr_hurt = global.sprHurt[bskin];
		spr_dead = global.sprDead[bskin];
		spr_sit2 = global.sprSit[bskin];
		spr_sit1 = global.sprGoSit[bskin];
	}
	
	else if("name" in self and name = "EffigyOrbital") {
		spr_idle = global.sprOrbital[type];
		spr_glow = global.sprOrbitalGlow[type];
		spr_dead = global.sprOrbitalDie;
	}

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
	
#define get_sacrifice(mut)
	with(Player) {
		instance_create(x, y, PortalClear);
		
		if("effigy_orbital" not in self) effigy_orbital = [];
		with(obj_create(x, y, "EffigyOrbital")) {
			index = array_length(other.effigy_orbital);
			array_push(other.effigy_orbital, id);
			creator = other;
			team = other.team;
			type = mut;
			
			spr_idle = global.sprOrbital[type];
			spr_glow = global.sprOrbitalGlow[type];
			spr_dead = global.sprOrbitalDie;
			
			if(type = 2) {
				var c = other;
				with(obj_create(x, y, "CrystallineEffect")) {
					creator = c;
				}
			}
			
			if(array_length(instances_matching(instances_matching(CustomHitme, "name", name), "type", type)) > 1) with(instances_matching(instances_matching(CustomHitme, "name", name), "type", type)) {
				my_health = maxhealth * 1.20;
			}
			
			repeat(GameCont.level - 1) {
				maxhealth *= 1.05;
			}
			
			if(type = 6) {
				if(fork()) {
					wait 35;
					if(instance_exists(self)) with(obj_create(x, y, "CustomBeam")) {
						direction = other.creator.gunangle;
						other.beam = id;
						//image_yscale = 3;
						
						sound_play_pitch(sndNothingBeamStart, 0.6 + random(0.2));
						sound_play_pitch(sndLaserCrystalCharge, 0.4 + random(0.2));
						sound_play_pitch(sndHyperCrystalRelease, 0.2 + random(0.2));
						sound_play_pitch(sndLaserCannonUpg, 0.6 + random(0.2));
						sound_play_pitch(sndPlasmaHugeUpg, 0.4 + random(0.2));
						sound_play_pitch(sndUltraLaserUpg, 0.6 + random(0.2));
					}
					
					exit;
				}
				
				maxhealth = 160;
			}
			
			my_health = maxhealth;
		}
	}

	switch(mut) {
		case 1: // OFFENSIVE -- Summon an allied gunner drone for all players
			sound_play_pitch(sndSwapMotorized, 0.6 + random(0.2));
			sound_play_pitch(sndHorrorPortal, 0.8 + random(0.3));
			return "@sBACKUP!"
		break;
		
		case 2: // DEFENSIVE -- Summon an orbital that blocks a limited number of shots
			sound_play_pitch(sndCrystalShield, 0.6 + random(0.2));
			sound_play_pitch(sndShielderDeflect, 1.4 + random(0.4));
			sound_play_pitch(sndEliteShielderTeleport, 1.4 + random(0.4));
			sound_play_pitch(sndHyperCrystalTaunt, 1.7 + random(0.2));
			
			return "@sINVULNERABILITY!";
		break;
		
		case 3: // UTILITY -- Empowered, gives haste + increased accuracy 
			sound_play_pitch(sndDogGuardianJump, 0.6 + random(0.2));
			sound_play_pitch(sndDogGuardianLand, 1.4 + random(0.2));
			sound_play_pitch(sndHammer, 0.6 + random(0.3));
			
			return "@sEMPOWERED!";
		break;
		
		case 4:  // AMMO -- Get infinte ammo for a certain amount of time
			sound_play_pitch(sndLightningShotgunUpg, 0.3 + random(0.4));
			sound_play_pitch(sndFishWarrantEnd, 0.6 + random(0.3));
			
			return "@sINFINITE AMMO!"
		break;
		
		case 6:
			sound_play_pitch(sndLaserCannonCharge, 0.2 + random(0.2));
			sound_play_pitchvol(sndHyperCrystalChargeExplo, 0.6 + random(0.2), 0.4);
			sound_play_pitchvol(sndNothingBeamWarn, 0.4 + random(0.2), 0.6);
			
			return "@sRAD BEAM!"
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
	
#define skill_decide(_category)
	return mod_script_call("mod", "metamorphosis", "skill_decide", _category);

#define skill_get_category(mut)
	return mod_script_call("mod", "metamorphosis", "skill_get_category", mut);

#define obj_create(_x, _y, obj)
	return mod_script_call("mod", "metamorphosis", "obj_create", _x, _y, obj);
	
#define array_delete(_array, _index)
	return mod_script_call("mod", "metamorphosis", "array_delete", _array, _index);
	
#define draw_pie(x ,y ,startang, endang, colour, radius)

if (argument2 > 0) { // no point even running if there is nothing to display (also stops /0
    var i, len, tx, ty, val;
    
    var numberofsections = 90 // there is no draw_get_circle_precision() else I would use that here
    var sizeofsection = 360/numberofsections
    
    val = (endang/360) * numberofsections
    
    if (val > 1) { // HTML5 version doesnt like triangle with only 2 sides
    
        draw_set_colour(argument4);
        
        draw_primitive_begin(pr_trianglefan);
        draw_vertex(argument0 + 1, argument1 + 1);
        
        for(i=floor(startang/360 * numberofsections); i<=floor(val); i++) {
            len = (i*sizeofsection)+90; // the 90 here is the starting angle
            tx = lengthdir_x(argument5, len);
            ty = lengthdir_y(argument5, len);
            draw_vertex(argument0+tx + 1, argument1+ty + 1);
        }
        draw_primitive_end();
        
    }
}
