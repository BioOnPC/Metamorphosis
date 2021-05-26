 //				--- BASE NTT SCRIPTS ---			//
#define init
	 // SOUNDS, USING A LWO BECAUSE OF HOW MANY THERE ARE //
	global.snd = {};
	with(snd) {
		 // SHOPKEEP //
		PotAggro   = sound_add("sounds/Vault/Pot/sndPotAggro.ogg");
		PotConfirm = sound_add("sounds/Vault/Pot/sndPotConfirm.ogg");
		PotDead    = sound_add("sounds/Vault/Pot/sndPotDead.ogg");
		PotHurt    = sound_add("sounds/Vault/Pot/sndPotHurt.ogg");
		PotPrompt  = sound_add("sounds/Vault/Pot/sndPotPrompt.ogg");
		PotRemind  = sound_add("sounds/Vault/Pot/sndPotRemind.ogg");
		PotTurnin  = sound_add("sounds/Vault/Pot/sndPotTurnin.ogg");
		
		 // MUTATOR //
		StatueAggro   = sound_add("sounds/Vault/Statue/sndStatueAggro.ogg");
		StatueConfirm = sound_add("sounds/Vault/Statue/sndStatueConfirm.ogg");
		StatueDead    = sound_add("sounds/Vault/Statue/sndStatueDead.ogg");
		StatueHurt    = sound_add("sounds/Vault/Statue/sndStatueHurt.ogg");
		StatuePrompt  = sound_add("sounds/Vault/Statue/sndStatuePrompt.ogg");
		
		 // EFFIGY //
		EffigyHurt    = sound_add("sounds/Characters/Effigy/sndEffigyHurt.ogg");
		EffigyDead    = sound_add("sounds/Characters/Effigy/sndEffigyDeath.ogg");
		EffigyLowHP   = sound_add("sounds/Characters/Effigy/sndEffigyLowHP.ogg");
		EffigyLowAM   = sound_add("sounds/Characters/Effigy/sndEffigyLowAmmo.ogg");
		EffigySelect  = sound_add("sounds/Characters/Effigy/sndEffigySelect.ogg");
		EffigyConfirm = sound_add("sounds/Characters/Effigy/sndEffigyConfirm.ogg");
		EffigyChest   = sound_add("sounds/Characters/Effigy/sndEffigyChestWeapon.ogg");
		EffigyWorld   = sound_add("sounds/Characters/Effigy/sndEffigyWorld.ogg");
		EffigyIDPD    = sound_add("sounds/Characters/Effigy/sndEffigyIDPD.ogg");
		EffigyCaptain = sound_add("sounds/Characters/Effigy/sndEffigyCaptain.ogg");
		EffigyThrone  = sound_add("sounds/Characters/Effigy/sndEffigyThrone.ogg");
		EffigyVault   = sound_add("sounds/Characters/Effigy/sndEffigyVault.ogg");
		EffigyUltraA  = sound_add("sounds/Ultras/sndUltEIDOLON.ogg");
		EffigyUltraB  = sound_add("sounds/Ultras/sndUltANATHEMA.ogg");
		EffigyUltraC  = sound_add("sounds/Ultras/sndUltDisciple.ogg");
		
		Artificing = sound_add("sounds/Vault/mus100c.ogg");
		
		GoldRush = sound_add("sounds/sndGoldRush.ogg");
	}
	
	 // MUTATION EFFECTS //
	global.sprMedpack		= sprite_add("sprites/VFX/sprFatHP.png",  7,  6,  6);
	global.sprSleep 		= sprite_add("sprites/VFX/sprSleep.png",  1,  4,  4);
	global.sprCursedOutline = sprite_add("sprites/Icons/Cursed/sprCursedOutline.png",  5,  17,  23);
	
	 // SHOP SPRITES //
	global.sprWallMerchantBot   = sprite_add("sprites/Shop/sprWallMerchantBot.png",  10,  0,  0);
	global.sprWallMerchantOut   = sprite_add("sprites/Shop/sprWallMerchantOut.png",  1,  4,  12);
	global.sprWallMerchantTop   = sprite_add("sprites/Shop/sprWallMerchantTop.png",  15,  0,  0);
	global.sprWallMerchantTrans = sprite_add("sprites/Shop/sprWallMerchantTrans.png",  6,  0,  0);
	global.sprMerchantFloor     = sprite_add("sprites/Shop/sprMerchantFloor.png",  8,  0,  0);
	global.sprMerchantCarpet    = sprite_add("sprites/Shop/sprMerchantCarpet.png",  1,  83,  34);
	
	 // SHOPKEEP //
	global.sprMerchantIdle     = sprite_add("sprites/Shop/sprMerchantIdle.png", 15, 32, 32);
	global.sprMerchantHurt     = sprite_add("sprites/Shop/sprMerchantHurt.png", 4, 32, 32);
	global.sprMerchantDie      = sprite_add("sprites/Shop/sprMerchantDie.png",  6, 32, 32);
	global.sprMerchantPuff     = sprite_add("sprites/Shop/sprMerchantPuff.png", 12, 32, 32);

	 // VARIOUS USEFUL VARIABLES //
	global.begin_step    = script_bind_begin_step(begin_step, 0);
	global.option_list   = ["shopkeeps", "allow characters", "cursed mutations", "custom ultras", "loop mutations", "metamorphosis tips"];
	global.stats_list    = ["vault visits", "distance evolved", "quests completed", "times loaded"];
	global.mutation_list = [];
	global.disabled_muts = [];
	
	global.current_muts  = [];
    
    global.mut_category[1] = [mut_gamma_guts, mut_scarier_face, mut_long_arms, mut_shotgun_shoulders, mut_laser_brain, mut_eagle_eyes, mut_impact_wrists, mut_bolt_marrow, mut_stress, mut_trigger_fingers, mut_sharp_teeth, "dividedelbows", "linkedlobes", "pyromania", "racingthoughts", "richtastes", "blastbile", "ignitionpoint", "thunderclap", "compoundelbow", "concentration", "excitedneurons", "powderedgums", "flamingpalms", "braintransfer", "compressingfist", "confidence", "doublevision", "energizedintenstines", "fracturedfingers", "neuralnetwork", "rocketcasings", "shatteredskull", "shockedskin", "sloppyfingers", "stakedchest", "wastegland", "musclememory", "prismaticiris"]; // Offensive
    global.mut_category[2] = [mut_rhino_skin, mut_bloodlust, mut_second_stomach, mut_boiling_veins, mut_strong_spirit, "crystallinegrowths", "turtleshell", "perfectfreeze", "condensedmeat", "garmentregenerator", "sadism", "steelnerves", "tougherstuff"]; // Defensive
    global.mut_category[3] = [mut_extra_feet, mut_plutonium_hunger, mut_throne_butt, mut_euphoria, mut_last_wish, mut_patience, mut_hammerhead, mut_heavy_heart, "atomicpores", "camoflauge", "crowncranium", "grace", "insurgency", "leadeyelids", "secretstash", "selectivefocus", "gluttony", "dynamiccalves", "filteringteeth", "mimicry", "pressurizedlungs", "thickhead", "toxicthoughts", "unstabledna", "floweringfolicles", "compassion"]; // Utility
    global.mut_category[4] = [mut_rabbit_paw, mut_lucky_shot, mut_back_muscle, mut_recycle_gland, mut_open_mind, "cheekpouch", "magfingers", "thinktank", "duplicators", "scraparms", "brassblood", "silvertongue"]; // Ammo
    global.mut_category[5] = ["adrenaline", "decayingflesh", "displacement", "falseprayer", "impatience", "portalinstability", "weirdscience", "scartissue", "vacuumvacuoles"]; // Cursed
    
    
	 // GET EM //
	global.mut_quest = mut_none;
	
	with(Menu) {
		mode = 0;
		event_perform(ev_step, ev_step_end);
		sound_volume(sndMenuCharSelect, 1);
		sound_stop(sndMenuCharSelect);
		with(CharSelect) alarm0 = 2;
	}
    
    if(fork()) {
    	wait 3;
    	
    	repeat(17) trace("");
    	trace_color("Thanks for playing Metamorphosis!", c_green);
    	trace_color("Be sure to report any bugs to tildebee in the official Nuclear Throne discord (discord.gg/nt)", c_aqua);
    	
    	 // Update the stats //
    	var t = option_get("times_loaded");
	    option_set("times_loaded", t = undefined ? 1 : (t + 1));
    	
    	
    	var skill_list = mod_get_names("skill"),
    		c = 0;
	
		for(var m = 0; m < 29 + array_length(skill_list); m++) {
			 // Reassign all disabled mutations //
			if(m <= 29) {
				if(lq_get(SETTING, `${m}_enabled`) = false) array_push(global.disabled_muts, real(m));
			} else if(lq_get(SETTING, `${skill_list[m - 30]}_enabled`) = false) {
				array_push(global.disabled_muts, skill_list[m - 30]);
				
				 // Add any missing mutations to your mutation categories //
				if(mod_script_exists("skill", `${skill_list[m - 30]}`, "skill_type")) {
					c = categories[mod_script_call("skill", `${skill_list[m - 30]}`, "skill_type")];
					if(array_find_index(c, "skill_type") = -1) array_push(c, `${skill_list[m - 30]}`);
				}
			}
		}
		
		with(GameCont) if(area = 100 and array_length(instances_matching(Player, "race", "effigy"))) {
			if(!audio_is_playing(snd.Artificing)) {
				sound_play_music(snd.Artificing);
			}
		}
    	
    	exit;
    }

 // General Use Macros:
#macro mod_current_type script_ref_create(0)[0]
#macro bbox_center_x (bbox_left + bbox_right + 1) / 2
#macro bbox_center_y (bbox_top + bbox_bottom + 1) / 2
#macro infinity 1/0
#macro snd global.snd

 // Mod Macros:
#macro metacolor `@(color:${make_color_rgb(110, 140, 110)})`;
#macro minicolor `@(color:${make_color_rgb(183, 195, 204)})`;
#macro SETTING mod_variable_get("mod", "metamorphosis_options", "settings")
#macro options_open mod_variable_get("mod", "metamorphosis_options", "option_open")
#macro options_avail instance_exists(Menu) and (Menu.mode = 1 or options_open)
#macro quest global.mut_quest
#macro categories global.mut_category

 // Custom Instance Macros:
#macro CrystallineEffect instances_matching(CustomObject, "name", "CrystallineEffect")
#macro CrystallinePickup instances_matching(CustomObject, "name", "CrystallinePickup")

#define game_start
	 // Gives you your proto mutation, if you have it enabled //
	if(SETTING.use_proto = true and SETTING.proto_mutation != mut_none) {
		skill_set(SETTING.proto_mutation, 1);
		option_set("proto_mutation", mut_none);
		metamorphosis_save();
	}
	
	global.disabled_muts = [];
	
	var skill_list = mod_get_names("skill"),
    		c = 0;
	
	for(var m = 0; m < 29 + array_length(skill_list); m++) {
		 // Reassign all disabled mutations //
		if(m <= 29) {
			if(lq_get(SETTING, `${m}_enabled`) = false) array_push(global.disabled_muts, real(m));
		} else if(lq_get(SETTING, `${skill_list[m - 30]}_enabled`) = false) {
			array_push(global.disabled_muts, skill_list[m - 30]);
			
			 // Add any missing mutations to your mutation categories //
			if(mod_script_exists("skill", `${skill_list[m - 30]}`, "skill_type")) {
				c = categories[mod_script_call("skill", `${skill_list[m - 30]}`, "skill_type")];
				if(array_find_index(c, "skill_type") = -1) array_push(c, `${skill_list[m - 30]}`);
			}
		}
	}
	
	global.mut_quest = mut_none; // Make sure the shopkeep doesn't have a quest active //
	

#define step
	if(!instance_exists(global.begin_step)) global.begin_step = script_bind_begin_step(begin_step, 0);
	script_bind_draw(cursed_mut_draw, -1001);
	
	 // Setting setup:
	with(instances_matching(Menu, "metamorphosis", null)) {
		metamorphosis = 1;
		
		if(SETTING.proto_mutation = -1) lq_set(SETTING, "proto_mutation", mut_none);
		
		with(obj_create(x, y, "MetaButton")) {
			name = "MetaSettings";
			page = 0;
			pages = ["options", "mutations", "stats"];
			left_off = 0;
			top_off = 0;
			right_off = 45;
			bottom_off = 6;
			on_end_step = script_ref_create(MetaSettings_end_step);
			on_click = script_ref_create(MetaSettings_click);
		}
		
		with(obj_create(x, y, "MetaButton")) {
			name = "MetaProto";
			setting = ["use_proto", SETTING.use_proto];
			left_off = 36;
			right_off = 0;
			top_off = 28;
			bottom_off = 28;
			on_click = script_ref_create(MetaButton_click);
		}
	}
	
	 // Character Selection Sound:
	if(instance_exists(CharSelect) and instance_exists(Menu)) {
    	var _race = [];
		for(var i = 0; i < maxp; i++){
		    _race[i] = player_get_race(i);
		    if(fork()) {
		    	wait 1;
		    	
				var r = player_get_race(i);
				if(_race[i] != r and r = "effigy") {
					sound_play(snd.EffigySelect);
				}
				_race[i] = r;
				
				exit;
		    }
		}
	}
	
	 
	with(GameCont) {
		 // Avoid duplicating ultras by accident
		if("alreadyultra" not in self) {
			if(level >= 10) alreadyultra = true;
		} 
		
		else if(fork()) {
			if(level < 10) {
				wait 0;
				if(instance_exists(self) and level >= 10 and endpoints > 0) endpoints = 0;
			}
			exit;
		}
		
		 // Effigy's new track, so cool
		if(area = 100 and array_length(instances_matching(Player, "race", "effigy")) and !audio_is_playing(snd.Artificing)) sound_play_music(snd.Artificing);
	}
	
    if(skill_get(mut_second_stomach)) { // Make Second Stomach medkits bigger
        with(instances_matching_ne(HPPickup, "sprite_index", global.sprMedpack)) {
            sprite_index = global.sprMedpack;
        }
    }
    
    with(instances_matching_gt(GameCont, "loops", 0)) { // Free mutation for every loop past the first
		if(!variable_instance_exists(self, "lstloop") or lstloop != loops) {
			lstloop = loops;
			if(SETTING.loop_mutations and loops > 1) {
	    		skillpoints++;
				sound_play(sndLevelUp);
		    }
		    
		    if(array_length(instances_matching(Player, "race", "effigy"))) mod_variable_set("race", "effigy", "rerolls", 3);
		}
    }
    
    with(instances_matching(mutbutton, "object_index", SkillIcon, EGSkillIcon)) { 
    	 // For the mutation options screen
    	if(instance_exists(self) and object_index = SkillIcon and "seen" not in self) {
    		seen = true;
    		option_set(`${skill}_seen`, 1);
    	}
    	
		if(instance_exists(self) and ((object_index = EGSkillIcon) or (is_string(skill) and mod_script_exists("skill", skill, "skill_ultra")))) { // Handler for redundant ultras
			if((!is_string(skill) and ultra_get(race, skill)) or (object_index != EGSkillIcon and is_string(skill) and (skill_get(skill) or !SETTING.custom_ultras))) {
				if(instance_exists(creator)) creator.maxselect--;
				
				var c = creator,
					n = num;
				with(instances_matching_ge(instances_matching(mutbutton, "creator", c), "num", n)) {
					if(num = n) {
						instance_destroy();
					}
					
					else {
						num--;
						alarm0--;
					}
				}
				
				if(instance_number(mutbutton) = 1) {
					with(GameCont){
						endpoints = 0;
						
						with(LevCont) instance_destroy();
						if(skillpoints > 0) instance_create(0, 0, LevCont);
						else instance_create(0, 0, GenCont);
					}
				}
			}
		}
	}
	
    
    with(Player) {
    	if("hastened" not in self) {
    		hastened = 0;
    		hastened_power = 0;
    	}
    	
    	if(hastened > 0) {
    		 // FAST EFFECTS
			if(speed > 0 and (current_frame mod (current_time_scale * 2)) = 0) { 
				with(instance_create(x - (hspeed * 2) + orandom(3), y - (vspeed * 2) + orandom(3), BoltTrail)) {
					creator = other; 
					image_angle = other.direction;
				    image_yscale = 1.4;
				    image_xscale = other.speed * 4;
				}
			}
			
			hastened -= current_time_scale;
    	
	    	if(hastened <= 0) {
	    		reloadspeed -= hastened_power;
	    		maxspeed -= hastened_power;
	    		hastened_power = 0;
	    		
	    		sound_play_pitch(sndLabsTubeBreak, 1.4 + random(0.2));
				sound_play_pitch(sndSwapGold, 0.8 + random(0.1));
	    	}
    	}
    	
    	var m = 0;
		global.current_muts = [];

		while(skill_get_at(m) != undefined) {
			if(!mod_script_exists("skill", string(skill_get_at(m)), "skill_ultra")) array_push(global.current_muts, skill_get_at(m));
			m++;
		}
    	
    	if(fork()) {
    		wait 0;
    		
    		if(instance_number(Player) = 0 and array_length(global.current_muts) > 0) {
				var l = array_length(global.current_muts);
				if(array_length(global.current_muts) = 1) {
					effigy_set_muts(global.current_muts[l - 1], skill_decide(0));
				}
				
				else {
					effigy_set_muts(global.current_muts[l - 1], global.current_muts[l - 2]);
				}
    			
    		}
    		
    		exit;
    	}
    }
    
     // Some funky stuff to make sure the prompt acts on step. props to yokin for helping a ton and also letting me steal NTTE code
    if(array_length(instances_matching(CustomObject, "name", "MetaPrompt")) > 0) script_bind_step(prompt_collision, 0);
    
     // LEVEL GEN BULLSHIT
    if(instance_exists(GenCont) and GenCont.alarm0 > 0 and GenCont.alarm0 <= room_speed) { // this checks to make sure the level is *mostly* generated, save for *most* props. for example, this will find the Crown Pedestal in the Vaults, but won't find any torches.
    
    	 // for horror's ultra
    	if(skill_get("criticalmass") > 0) {
			 // Place down the mutation reselector
			if((GameCont.hard - mod_variable_get("skill", "criticalmass", "diff")) mod 3 = 0 and array_length(instances_matching(CustomProp, "name", "MutRefresher")) <= 0) {
				var ffloor = instance_furthest(0, 0, Floor);
				with(ffloor) obj_create(bbox_center_x, bbox_center_y, "MutRefresher");
			}
		}
    	
    	
    	 // place the shop area in the crown vault
    	with(instances_matching(CrownPed, "shopping", null)) {
    		shopping = "i be";
    		
    		 // Update the stats //
	    	var v = option_get("vault_visits");
		    option_set("vault_visits", v = undefined ? 1 : (v + 1));
    		
	    	if(option_get("shopkeeps")) {
	    		 // Find the furthest floor in the crown vault and find the direction its in, rounded to 90 degrees
	    		var ffloor = instance_furthest(10016, 10016, Floor),
	    			shop_dir = grid_lock(point_direction(x, y, ffloor.x, ffloor.y), 90);
				
				 // Place down floors.
				floor_fill(ffloor.x + lengthdir_x(128, shop_dir) - 96, ffloor.y + lengthdir_y(128, shop_dir) - 32, 1, 3);
				floor_fill(ffloor.x + lengthdir_x(128, shop_dir) - 32, ffloor.y + lengthdir_y(128, shop_dir) + 96, 3, 1);
				floor_fill(ffloor.x + lengthdir_x(128, shop_dir) - 64, ffloor.y + lengthdir_y(128, shop_dir) - 64, 5, 5);
				floor_fill(ffloor.x + lengthdir_x(128, shop_dir) - 32, ffloor.y + lengthdir_y(128, shop_dir) - 96, 3, 1);
				floor_fill(ffloor.x + lengthdir_x(128, shop_dir) + 96, ffloor.y + lengthdir_y(128, shop_dir) - 32, 1, 3);
				instance_create(ffloor.x + lengthdir_x(32, shop_dir), ffloor.y + lengthdir_y(32, shop_dir), Floor);
				
				 // Make the cool carpet!
				instance_create(ffloor.x + lengthdir_x(128, shop_dir) + 16, ffloor.y + lengthdir_y(128, shop_dir) + 16, VenuzCarpet).sprite_index = global.sprMerchantCarpet;
				
				if(fork()) {
					wait 3; // Wait to make sure that everything generates
					
					with(Floor) { // Resprite floors
						if(point_distance(x, y, ffloor.x + lengthdir_x(128, shop_dir), ffloor.y + lengthdir_y(128, shop_dir)) < 128) {
							sprite_index = global.sprMerchantFloor;
						}
					}
					
					with(Wall) { // Resprite walls
						if(point_distance(x, y, ffloor.x + lengthdir_x(128, shop_dir), ffloor.y + lengthdir_y(128, shop_dir)) < 144) {
							topspr       = global.sprWallMerchantTop;
							topindex     = irandom(9);
							outspr       = global.sprWallMerchantOut;
							sprite_index = global.sprWallMerchantBot;
							image_index  = irandom(6);
						}
					}
					
					with(TopSmall) { // Resprite outside walls
						if(point_distance(x, y, ffloor.x + lengthdir_x(128, shop_dir), ffloor.y + lengthdir_y(128, shop_dir)) < 160) {
							sprite_index = global.sprWallMerchantTrans;
							image_index  = irandom(6);
						}
					}
					
					with(prop) { // Remove props
						if(point_distance(x, y, ffloor.x + lengthdir_x(128, shop_dir), ffloor.y + lengthdir_y(128, shop_dir)) < 96) {
							instance_delete(self);
						}
					}
					
					if(global.mut_quest != -1) {
						 // Spawn da boys
						obj_create(ffloor.x + lengthdir_x(128, shop_dir) - 4, ffloor.y + lengthdir_y(128, shop_dir), "Shopkeep");
						obj_create(ffloor.x + lengthdir_x(128, shop_dir) + 36, ffloor.y + lengthdir_y(128, shop_dir), "Mutator");
					}
				}
	    	}
    	}
    	
    	with(Player) { // Chicken ultra
    		haste(210 * skill_get("strengthindeath"), 0.5);
    	}
    	
    	
    	 // This is just here to add any missing mutations you have when you add mutation mods mid-run //
    	global.disabled_muts = [];
	
		var skill_list = mod_get_names("skill"),
	    		c = 0;
		
		for(var m = 0; m < 29 + array_length(skill_list); m++) {
			 // Reassign all disabled mutations //
			if(m <= 29) {
				if(lq_get(SETTING, `${m}_enabled`) = false) array_push(global.disabled_muts, real(m));
			} else if(lq_get(SETTING, `${skill_list[m - 30]}_enabled`) = false) {
				array_push(global.disabled_muts, skill_list[m - 30]);
				
				 // Add any missing mutations to your mutation categories //
				if(mod_script_exists("skill", `${skill_list[m - 30]}`, "skill_type")) {
					c = categories[mod_script_call("skill", `${skill_list[m - 30]}`, "skill_type")];
					if(array_find_index(c, "skill_type") = -1) array_push(c, `${skill_list[m - 30]}`);
				}
			}
		}
    }
    
    if(SETTING.metamorphosis_tips) {
	     // tip moment
	    with(instances_matching(GenCont, "metamorphosistip", null)) {
	    	metamorphosistip = random(10);
	    	
	    	if(metamorphosistip < 1) {
	    		tip = tip_generate();
	    	}
	    }
    }
	
	with(instances_matching(Corpse, "sprite_index", -5)){
		instance_destroy();
	}
	
	 // Replace SkillIcons that use F O R B I D D E N    M U T A T I O N S
	if(instance_exists(LevCont)) {
		with(instances_matching(SkillIcon, "disabledcheck", null)) {
			disabledcheck = "checked";
			
			if(array_find_index(global.disabled_muts, skill) != -1) {
				disabledcheck = null; // retry if this fails
				skill = skill_decide(0);
				name = skill_get_name(skill);
				text = skill_get_text(skill);
				if(is_string(skill)) mod_script_call("skill", skill, "skill_button");
				else {
					sprite_index = sprSkillIcon;
					image_index = skill;
				}
				
				if(skill = mut_none) {
					with(instances_matching_gt(instances_matching(mutbutton, "creator", creator), "num", num)) {
						num--;
						alarm0--;
					}
					
					if(instance_number(mutbutton) = 1) {
						with(GameCont){
							endpoints = 0;
							
							with(LevCont) instance_destroy();
							if(skillpoints > 0) instance_create(0, 0, LevCont);
							else instance_create(0, 0, GenCont);
						}
					}
					instance_destroy();
				}
			}
		}
	}
	
	 // Remove any previously obtained mutations that were Banished, typically for stuff like NTTE
	for(var i = 0; i < array_length(global.disabled_muts); i++) {
		if(skill_get(global.disabled_muts[i])) {
			var s = skill_decide(0);
			if(s != mut_none) {
				skill_set(s, skill_get(global.disabled_muts[i]));
				with(instances_matching(instances_matching(CustomObject, "name", "OrchidSkill"), "skill", global.disabled_muts[i])) skill = s; 
				skill_set(global.disabled_muts[i], 0);
			}
		}
	}

#define begin_step
	if(array_length(instances_matching(Player, "race", "effigy")) > 0) with(instances_matching(LevCont, "effigy_mut", null)) {
		effigy_mut = 0;
	
		for(var e = 0; e < maxp; e++) {
			if(effigy_mut = 0) {
				with(instances_matching(Player, "index", e)) {
					if("effigy_sacrificed" in self and array_length(effigy_sacrificed) > 0) {
						other.effigy_mut = effigy_sacrificed[0];
						effigy_sacrificed = array_delete(effigy_sacrificed, 0);
					}
				}
			}
		}
    	
    	if(GameCont.crownpoints <= 0 and effigy_mut != 0) {
    		 // Clear:
			var _inst = instances_matching(mutbutton, "creator", self);
			if(array_length(_inst)){
				with(_inst){
					if(instance_is(self, SkillIcon) and (skill_get_avail(skill) or mod_script_exists("mod", string(skill), "skill_cursed"))){
						other.maxselect--;
						var _num = num;
						with(instances_matching(_inst, "num", _num)){
							instance_destroy();
						}
						with(instances_matching_gt(_inst, "num", _num)){
							num--;
							if(alarm0 > 0){
								alarm0--;
								if(alarm0 <= 0){
									with(self){
										event_perform(ev_alarm, 0);
									}
								}
							}
						}
					}
				}
			}
			
			var _skill = effigy_mut,
				 // Add a mutation for Throne Butt or Horror and remove one for crown of destiny
				_amt   = (crown_current = crwn_destiny ? -1 : 1) + skill_get(mut_throne_butt) + array_length(instances_matching(Player, "race", "horror"));
			
			 // Star of the Show:
			maxselect++;
			with(instance_create(0, 0, SkillIcon)){
				creator = other;
				num     = other.maxselect;
				alarm0	= num + 1;
				skill   = _skill;
				name    = skill_get_name(_skill);
				text    = skill_get_text(_skill);
				if(is_string(skill)) mod_script_call("skill", skill, "skill_button");
				else {
					sprite_index = sprSkillIcon;
					image_index = skill;
				}
				
				if(fork()) {
					while(instance_exists(self)) {
						wait 0;
						if(!instance_exists(self) and instance_exists(other)) other.effigy_mut = null;
						exit;
					}
				}
			}
			
			if(_amt > 0) repeat(_amt) {
				maxselect++;
				with(instance_create(0, 0, SkillIcon)){
					creator = other;
					num     = other.maxselect;
					alarm0	= num + 1;
					skill   = skill_decide(skill_get_category(_skill));
					name    = skill_get_name(skill);
					text    = skill_get_text(skill);
					if(is_string(skill)) mod_script_call("skill", skill, "skill_button");
					else {
						sprite_index = sprSkillIcon;
						image_index = skill;
					}
				}
			}
    	}
    	
    	if(!instance_exists(EGSkillIcon) and !instance_exists(CrownIcon) and skill_get("crowncranium") and instance_exists(SkillIcon) and mod_variable_get("race", "effigy", "rerolls")) {
    		var unavail = 0;
    		
    		with(SkillIcon) {
    			if(!skill_get_avail(skill)) unavail++;
    		}
    		
    		if(unavail < instance_number(SkillIcon)) {
    			maxselect++;
    			with(instance_create(0, 0, SkillIcon)){
					creator = other;
					num     = other.maxselect;
					alarm0	= num + 1;
					skill   = "effigyreroll";
					name    = `${skill_get_name(skill)} @g(${mod_variable_get("race", "effigy", "rerolls")} USES LEFT)`;
					mod_variable_set("skill", "effigyreroll", "category", irandom_range(1, 4));
					text    = `REROLL THESE @gMUTATIONS@s#INTO ${mod_script_call("skill", "effigyreroll", "category_names", mod_variable_get("skill", "effigyreroll", "category"))} MUTATIONS`;
					mod_script_call("skill", skill, "skill_button");
					image_index = mod_variable_get("skill", "effigyreroll", "category") - 1;
    			}
    		}
    	}
    }
    
    if(SETTING.cursed_mutations and !instance_exists(EGSkillIcon) and array_length(instances_matching_ne(SkillIcon, "curseified", null)) = 0) {
		var potentialcurse = instances_matching(SkillIcon, "curseified", null);
		if(instance_number(SkillIcon) > 0){
			repeat(instance_number(SkillIcon)) {
				with(potentialcurse[irandom(array_length(potentialcurse) - 1)]) {
					curseified = "maybe!";
					
					var _mod = mod_get_names("skill"),
						_scrt = "skill_cursed",
						_cursed = [],
						_amtcurse = 0,
						_repent = 0;
					
					 // Go through and find all cursed mutations
					for(var i = 0; i < array_length(_mod); i++){ 
						if(mod_script_exists("skill", _mod[i], _scrt) and mod_script_call("skill", _mod[i], _scrt) > 0) {
							if(!skill_get(_mod[i])) {
								if(array_length(instances_matching(SkillIcon, "skill", _mod[i])) = 0) array_push(_cursed, _mod[i]);
							}
							
							else _amtcurse++;
						}
					}
					
					if(_amtcurse > 0 and array_length(instances_matching(SkillIcon, "skill", "repentance")) = 0 and skill_get("repentance") <= 0 and random(30) < 1) _repent = 1; 
					
					if(skill_get_active(skill) and skill_get_avail(skill) and skill != mut_heavy_heart and ((_repent) or current_cursed())) {
						var _mut = "";
						
						if(_repent) {
							_mut = "repentance";
						}
						
						else if(array_length(_cursed) > 0) {
							_mut = _cursed[irandom_range(0, array_length(_cursed) - 1)];
						}
						
						if(_mut != "") {
							skill = _mut;
							name = skill_get_name(skill);
							text = skill_get_text(skill);
							mod_script_call("skill", skill, "skill_button");
							
							sound_play(sndCursedPickup);
						}
					}
				}
				
				potentialcurse = instances_matching(SkillIcon, "curseified", null);
			}
		}
	}

#define draw
	if(skill_get("grace") > 0 and instance_exists(Player)) { // Color projectiles being dodged while Muscle Memory is active
		with(instances_matching_gt(instances_matching_ne(projectile, "grace", null), "grace", 0)) {
			var nplayer = instance_nearest(x, y, Player);
			if(!(nplayer.race = "frog" and object_index = ToxicGas) and object_index != Flame and object_index != TrapFire and team != nplayer.team) {
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_red, 1 - point_distance(x, y, nplayer.x, nplayer.y)/32);
			}
		}
	}
	
	with(instances_matching_ne(Player, "adrenalinetimer", null)) {
		draw_sprite_ext(sprite_index, image_index, x, y, (image_xscale * right) / ((60 - adrenalinetimer)/60), image_yscale / ((60 - adrenalinetimer)/60), image_angle, c_maroon, ((60 - adrenalinetimer)/60) * 0.4);
	}
	
	with(instance_rectangle_bbox(view_xview_nonsync - (game_width), 
								 view_yview_nonsync - (game_height), 
								 view_xview_nonsync + (game_width), 
								 view_yview_nonsync + (game_height), 
								 instances_matching_gt(instances_matching_ne(enemy, "leadsleep", null), "leadsleep", 0))) {
		var vis = 1;
		if(leadsleep <= room_speed) vis = leadsleep mod (4 * leadsleep);
		
		draw_sprite_ext(global.sprSleep, 1, x + 6, y - 8 - (sprite_get_height(sprite_index)/2) + sin((leadsleep + 20) * 0.1), 1, 1, sin((leadsleep + 20) * 0.1) * 10, c_white, vis);
		
		draw_sprite_ext(global.sprSleep, 1, x, y - 4 - (sprite_get_height(sprite_index)/2) + sin((leadsleep + 10) * 0.1), 1, 1, sin((leadsleep + 10) * 0.1) * 10, c_white, vis);
		
		draw_sprite_ext(global.sprSleep, 1, x - 6, y - (sprite_get_height(sprite_index)/2) + sin(leadsleep * 0.1), 1, 1, sin(leadsleep * 0.1) * 10, c_white, vis);
	}

#define cursed_mut_draw
	with(SkillIcon) {
		if(mod_script_exists("skill", string(skill), "skill_cursed") and mod_script_call("skill", string(skill), "skill_cursed") = true) {
			if("counter" not in self){
				counter = 0;
			}
			if(counter <= num){
				counter++;
				continue;
			}
			var _x = x + sprite_xoffset;
			var _y = y + sprite_yoffset;
			var hover = 0;
			for(i = 0; i <= maxp; i++) {
				if(point_in_rectangle(mouse_x[i], mouse_y[i], x - (sprite_width/2), y - (sprite_height/2), x + (sprite_width/2), y + (sprite_height/2))) {
					hover = 1;
				}
			}
			draw_sprite(global.sprCursedOutline, (current_frame * (0.4/current_time_scale)) mod 4, x, y - hover);
			if(depth != -1002) depth = -1002;
			if(current_frame * (0.2/current_time_scale)) {
				with instance_create(x - 12 + 6 * ((current_frame * (0.2/current_time_scale)) mod 4), y - 16 - hover, Curse) {
					depth = other.depth;
				}
			}
		}
	}
	
	instance_destroy();

#define draw_dark
	draw_set_color($808080);
	with(instances_matching(CustomProp, "name", "Shopkeep")) draw_circle(x, y, 30 + random(2), false);
	with(instances_matching(CustomProp, "name", "Mutator")) draw_circle(x, y, 60 + random(2), false);
	

#define draw_dark_end
	draw_set_color($000000);
	with(instances_matching(CustomHitme, "name", "EffigyOrbital")) draw_circle(x, y, 10 + random(2), false);	
	with(instances_matching(CustomProp, "name", "Shopkeep")) draw_circle(x, y, 20 + random(2), false);	
	with(instances_matching(CustomProp, "name", "Mutator")) draw_circle(x, y, 40 + random(2), false);

#define draw_bloom
	with(instances_matching(CustomHitme, "name", "EffigyOrbital")) {
		var hp = (my_health/maxhealth);
		draw_sprite_ext(spr_glow, image_index, x, y, (image_xscale * 1.5) * right, image_yscale * 1.5, image_angle, image_blend, 0.2 * hp);
	}

#define cleanup
	with(global.begin_step) instance_destroy();

	
 //				--- OBJECT SCRIPTS ---			//
#define obj_create(_x, _y, _name)
	 // this is all yokin. he is a powerful mans
	
	 // Vanilla Objects:
	if(is_real(_name) && object_exists(_name)){
		return instance_create(_x, _y, _name);
	}
	
	 // Create Object:
	var o = noone;
	switch(_name){
		case "CrystallineEffect":
			o = instance_create(_x, _y, CustomObject);
			with(o){
				 // Vars:
				scale	= 2;
				blink   = true;
				colors  = [make_color_rgb(173, 80, 185), make_color_rgb(250, 138, 0)];
				creator = noone;
				
			}
			break;
			
		case "CheekPouch":
			o = obj_create(_x, _y, "CrystallineEffect");
			with(o){
				colors  = [make_color_rgb(54, 121, 255), make_color_rgb(0, 255, 255)];
				on_step = script_ref_create(CheekPouch_step);
			}
			break;
		
		case "AdrenalinePickup":
		case "RichPickup":
		case "CrystallinePickup":
			o = instance_create(_x, _y, CustomObject);
			with(o){
				
				 // Vars:
				mask_index = mskPickup;
				creator    = noone;
				num		   = 1;
				
			}
			break;
		
		case "EffigyOrbital":
			o = instance_create(_x, _y, CustomHitme);
			with(o){
				 // Visual:
				spr_idle = mod_variable_get("race", "effigy", "sprOrbital")[3];
				spr_glow = mod_variable_get("race", "effigy", "sprOrbitalGlow")[3];
				spr_dead = mod_variable_get("race", "effigy", "sprOrbitalDie");
				spr_shadow = shd24;
				
				 // Sounds:
				snd_hurt = sndGuardianHurt;
				snd_dead = sndGuardianDead;
				
				 // Vars:
				mask_index  = mskNone;
				image_speed = 0.4;
				maxhealth   = 165;
				my_health   = maxhealth;
				size        = 1;
				right       = 1;
				index       = 0;
				target      = noone;
				creator     = noone;
				reload      = 0;
			}
			break;
		
		case "Mutator":
			o = instance_create(_x, _y, CustomProp);
			with(o){
				 // Visual:
				spr_idle = sprProtoStatueIdle;
				spr_hurt = sprProtoStatueHurt;
				spr_dead = sprProtoStatueDoneDie;
				spr_shadow = shd64B;
				spr_shadow_y = 6;
				
				 // Sounds:
				snd_hurt = snd.StatueHurt;
				snd_dead = snd.StatueDead;
				
				 // Vars:
				mask_index = mskBanditBoss;
				maxhealth  = 60;
				my_health  = maxhealth;
				size       = 2;
				team	   = 1; // Make sure they aren't killed by corrupted vaults
				
				prompt = prompt_create("+1 @gMUTATION@w#-2 @rMAX HP@s");
				with(prompt){
					mask_index = mskReviveArea;
					yoff = -4;
					hover = 0;
				}
			}
			break;
		
		case "MutRefresher":
			o = instance_create(_x, _y, CustomProp);
			with(o){
				 // Visual:
				spr_idle = sprHorrorMenu;
				spr_hurt = sprMutant11Dead;
				
				 // Sounds:
				snd_hurt = sndGuardianHurt;
				snd_dead = sndGuardianDead;
				
				 // Vars:
				mask_index = mskNone;
				maxhealth  = 999;
				size       = 3;
				
				prompt = prompt_create("RESELECT");
				with(prompt){
					mask_index = mskBandit;
					yoff       = -2;
				}
			}
			break;
		
		case "MetaButton":
			o = instance_create(_x, _y, CustomObject);
			with(o) {
				left_off   = 0;
				right_off  = 0;
				top_off    = 0;
				bottom_off = 0;
				
				click = 0;
				p_hover = { p1 : 0, p2 : 0, p3 : 0, p4 : 0 };
				hover = 0;
				shift = 0;
				splat = 0;
				tooltip = "";
				index = 0;
				
				on_click   = null;
				on_release = null;
				
				depth = -1002;
			}
		
			break;
		
		case "MetaPrompt":
			o = instance_create(_x, _y, CustomObject);
			with(o){
				 // Vars:
				mask_index = mskWepPickup;
				persistent = true;
				creator = noone;
				nearwep = noone;
				depth = 0; // Priority (0==WepPickup)
				pick = -1;
				xoff = 0;
				yoff = 0;
				
				 // Events:
				on_meet = null;
			}
			break;
		
		case "Shopkeep":
			o = instance_create(_x, _y, CustomProp);
			with(o){
				 // Visual:
				spr_idle = global.sprMerchantIdle;
				spr_hurt = global.sprMerchantHurt;
				spr_dead = global.sprMerchantDie;
				spr_shadow = shd24;
				
				 // Sounds:
				snd_hurt = snd.PotHurt;
				snd_dead = snd.PotDead;
				
				 // Vars:
				mask_index = mskBandit;
				maxhealth  = 20;
				my_health  = maxhealth;
				size       = 1;
				if(global.mut_quest != mut_none and global.mut_quest != -1) skill = global.mut_quest;
				else skill = skill_decide(0);
				team	   = 1; // Make sure they aren't killed by corrupted vaults
				
				prompt = prompt_create(`HELP FIND@3(${skill_get_icon(skill)[0]}:${skill_get_icon(skill)[1]})?`);
				with(prompt){
					mask_index = mskReviveArea;
					yoff = -4;
					hover = 0;
				}
			}
			break;
			
		case "FriendlyNecro":
			o = instance_create(_x, _y, CustomObject);
			with(o){
				image_index = 1;
				image_speed = 0.4;
				sprite_index = sprReviveArea;
			}
			break;
			
		case "FreakFriend":
			o = instance_create(_x, _y, CustomHitme);
			with(o){
				my_health = 4;
				while(place_meeting(x, y, Wall)){
					x = other.x+random(12)-6;
					y = other.y+random(12)-6;
				}
				image_speed = 0.4;
				friction = 0.25;
				maxspeed = 0.5;
				sprite_index = sprFreak1Idle;
				spr_idle = sprFreak1Idle;
				spr_walk = sprFreak1Walk;
				spr_hurt = sprFreak1Hurt;
				snd_hurt = sndFreakHurt;
				right = 1;
				wanderDir = direction;
			}
			break;
			
		case "MeatBlob":
			o = instance_create(_x, _y, CustomProp);
			with(o){
				my_health = 12;
				raddrop = 4;
				link = -4;
				sprite_index = sprBloodBall;
				mask_index = sprBloodBall;
				spr_idle = sprBloodBall;
				spr_hurt = sprBloodBall;
				spr_dead = -5;
				image_speed = 0;
				while(place_meeting(x, y, Wall) || place_meeting(x, y, CustomProp)){
					if(!place_meeting(x, y, Floor)){
						x = _x;
						y = _y;
					}
					x += random(12)-6;
					y += random(12)-6;
				}
				with(instance_create(x,y,Corpse)){
					other.link = self;
					sprite_index = sprBloodBall;
					visible = false;
					size = 6;
				}
			}
			break;
		
		default: // Called with undefined - for use with Yokin's cheats mod
			return ["AdrenalinePickup", "CheekPouch", "CrystallineEffect", "CrystallinePickup", "EffigyOrbital", "MutRefresher", "MetaButton", "MetaPrompt", "RichPickup", "Shopkeep", "Mutator"];
	}
	
	 // Instance Stuff:
	with(o){
		name = _name;
	
		 // Auto Script Binding:
		with([
			
			 // General:
			"_begin_step",
			"_step",
			"_end_step",
			"_draw",
			"_destroy",
			"_cleanup",
			
			 // Hitme/Enemy:
			"_hurt",
			"_death",
			
			 // Projectile:
			"_anim",
			"_wall",
			"_hit",
			
			 // Slash:
			"_grenade",
			"_projectile"
		]){
			var _var =  "on" + self,
				_scr = _name + self;
				
			if(mod_script_exists(mod_current_type, mod_current, _scr)){
				var _ref = script_ref_create_ext(mod_current_type, mod_current, _scr);
				variable_instance_set(o, _var, _ref);
			}
		}
	}
	
	 // Important:
	return o;

#define AdrenalinePickup_step
	if(!instance_exists(creator)){
		instance_destroy();
	}
	else{
		x = creator.x;
		y = creator.y;
	}
	
#define AdrenalinePickup_destroy
	var _player = instance_nearest(x, y, Player);
	if(instance_exists(_player) && place_meeting(x, y, _player)){
		with(_player){
			var _duration = (other.num * 45) * skill_get("adrenaline");
			infammo += _duration;
			
			 // Effects:
			sleep(30);
			
			sound_play_pitch(sndAmmoChest, 1.6 + random(0.4));
			sound_play_pitch(sndSwapShotgun, 1.2 + random(0.2));
			sound_play_pitch(sndSwapCursed, 1.8 + random(0.1));
		}
	}

#define CheekPouch_step
	if(instance_exists(creator) && "nexthurt" in creator){
		var _time = creator.nexthurt - current_frame;
		
		blink = (_time < 20 && (_time % 2) == 0);
		scale = lerp(scale, 1, current_time_scale / 3);
		depth = creator.depth;
		
		 // Effects:
		if(random(3) < current_time_scale){
			with(
				instance_create(
					random_range(creator.bbox_left, creator.bbox_right), 
					random_range(creator.bbox_top,  creator.bbox_bottom), 
					CrystTrail
				)
			){
				image_blend = other.colors[random(array_length(other.colors) - 1)];
				
				speed *= 2/3;
			}
		}
	}
	else{
		instance_destroy();
	}

#define CrystallineEffect_step
	if(instance_exists(creator) && creator.nexthurt > current_frame){
		var _time = creator.nexthurt - current_frame;
		
		blink = (_time < 20 && (_time % 2) == 0);
		scale = lerp(scale, 1, current_time_scale / 3);
		depth = creator.depth;
		
		 // Effects:
		if(random(3) < current_time_scale){
			with(
				instance_create(
					random_range(creator.bbox_left, creator.bbox_right), 
					random_range(creator.bbox_top,  creator.bbox_bottom), 
					CrystTrail
				)
			){
				sprite_index = (
					other.blink 
					? sprCrystTrailB 
					: sprCrystTrail
				);
				
				speed *= 2/3;
			}
		}
	}
	else{
		instance_destroy();
	}
	
#define CrystallineEffect_draw
	var _scale = scale;
	with(creator){
		if(visible){
			
			 // Store:
			var _xOff = orandom(2),
				_yOff = orandom(2);
				
			 // Set:
			draw_set_fog(true, other.colors[other.blink], 0, 0);
			x += _xOff;
			y += _yOff;
			image_xscale *= _scale;
			image_yscale *= _scale;
			
			 // The Magic:
			with(self) event_perform(ev_draw, 0);
			
			 // Reset:
			draw_set_fog(false, c_white, 0, 0);
			x -= _xOff;
			y -= _yOff;
			image_xscale /= _scale;
			image_yscale /= _scale;
		}
	}
	
#define CrystallinePickup_step
	if(!instance_exists(creator)){
		instance_destroy();
	}
	else{
		x = creator.x;
		y = creator.y;
	}
	
#define CrystallinePickup_destroy
	var _player = instance_nearest(x, y, Player);
	if(instance_exists(_player) && place_meeting(x, y, _player)){
		with(_player){
			var _duration = (
				other.num
				* (45 * current_time_scale)
				* skill_get("crystallinegrowths")
				+ (15 * skill_get("tougherstuff"))
			);
			nexthurt = current_frame + _duration;
			
			 // Effects:
			sleep(30);
			
			 // Player Effect:
			with(instances_matching(CrystallineEffect, "creator", id)){
				instance_destroy(); // prevent overlapping effects
			}
			with(obj_create(x, y, "CrystallineEffect")){
				creator = other;
				time	= _duration;
			}
		}
	}
	
#define EffigyOrbital_step
	if(instance_exists(Portal) or instance_exists(LevCont) or !instance_exists(creator)) {
		my_health = 0;
	}

	if(my_health <= 0) {
		instance_destroy();
		exit;
	}

	speed = 0;
	
	if(sprite_index == spr_hurt && image_index == sprite_get_number(spr_hurt) - 1){
		sprite_index = spr_idle;
	}

	if(sprite_index != spr_hurt && sprite_index != spr_dead) {
		if(speed > 0) {
			sprite_index = spr_walk;
		} else{
			sprite_index = spr_idle;
		}
	}

#define EffigyOrbital_begin_step
	if(type = 6 and array_length(instances_matching_lt(instances_matching(CustomHitme, "name", name), "id", id))) {
		instance_delete(self);
		exit;
	}

	if(instance_exists(creator)) {
		x = lerp(x, 
				 creator.x + lengthdir_x(16, (current_frame * 2) + (360 * (index/array_length(creator.effigy_orbital)))), 
				 max(creator.speed/creator.maxspeed, 0.2) * current_time_scale);
		y = lerp(y, 
				 creator.y + lengthdir_y(16, (current_frame * 2) + (360 * (index/array_length(creator.effigy_orbital)))), 
				 max(creator.speed/creator.maxspeed, 0.2) * current_time_scale);
		
		right = creator.right;
		
		switch(type) {
			case 1:
				if(reload <= 0) {
					target = instance_nearest(x, y, enemy);
					
					if(target != noone and !collision_line(x, y, target.x, target.y, Wall, false, false)) {
						with(instance_create(x, y, ThroneBeam)) {
							motion_add(point_direction(x, y, other.target.x, other.target.y) + random_range(7, -7), 8 + random(2));
							team = other.team;
							creator = other;
							image_angle = direction;
						}
						
						motion_add(point_direction(x, y, target.x, target.y) + 180 + random_range(4, -4), 3 + random(1));
						
						sound_play_pitchvol(sndNothingFire, 1.2 + random(0.3), 0.5);
						sound_play_pitchvol(sndUltraLaser, 2.2 + random(0.6), 0.4);
						sound_play_pitch(sndLightningReload, 1.5 + random(0.3));
					}
					
					reload += 1 + random(2);
				}
				
				else {
					reload -= current_time_scale;
				}
			break;
			
			case 2:
				with(creator) {
					nexthurt = max(nexthurt, current_frame + current_time_scale * 2);
					var chp = my_health;
					if(fork()) {
						wait 0;
						if(my_health < chp) {
							my_health = chp;
							sound_play_pitch(sndHyperCrystalHurt, 1.6 + random(0.2));
							sound_play_pitch(sndExploGuardianHurt, 0.6 + random(0.2));
						}
						exit;
					}
				}
			break;
			
			case 3:
				with(creator) haste(current_time_scale * 2, 0.8);
			break;
			
			case 4:
				with(creator) infammo = max(infammo, current_time_scale * 2);
			break;
			
			case 6:
			
			break;
		}
		
		my_health -= current_time_scale;
	}
	
#define EffigyOrbital_hurt(_dmg, _spd, _dir)
    my_health -= _dmg;
    nexthurt = current_frame + 5;
    sprite_index = spr_hurt;
    image_index = 0;
    sound_play_hit(snd_hurt, 0.6);
    motion_add(_dir, _spd);

#define EffigyOrbital_destroy
	with(instance_create(x, y, BulletHit)) {
		sprite_index = other.spr_dead;
	}
	
	sound_play(snd_dead);	
	switch(type) {
		case 1:
			sound_play_pitch(sndHorrorEmpty, 0.7 + random(0.2));
			sound_play_pitch(sndUltraEmpty, 0.7 + random(0.2));
			sound_play_pitch(sndUltraGrenadeSuck, 1.4 + random(0.2));
		break;
		
		case 2:
			sound_play_pitch(sndHyperCrystalRelease, 0.8 + random(0.2));
			sound_play_pitchvol(sndMutant11Dead, 1.2 + random(0.2), 0.6);
			sound_play_pitch(sndEliteShielderTeleport, 1.6 + random(0.2));
		break;
		
		case 3:
			sound_play_pitch(sndDogGuardianDead, 0.6 + random(0.2));
			sound_play_pitch(sndDiscDie, 0.8 + random(0.4));
			sound_play_pitch(sndChickenThrow, 0.6 + random(0.2));
			sound_play_pitch(sndDiscBounce, 1.2 + random(0.3));
		break;
		
		case 4:
			sound_play_pitch(sndFishWarrantEnd, 1.4 + random(0.4));
			sound_play_pitch(sndSwapShotgun, 0.5 + random(0.1));
			sound_play_pitch(sndFlamerStop, 0.4 + random(0.2));
		break;
	}
	
	
	with(creator) {
		effigy_orbital = array_delete(effigy_orbital, index);
	}
	
	with(instances_matching_gt(instances_matching(CustomProp, "name", name), "index", index)) {
		index--;
	}

#define EffigyOrbital_draw
	var hp = (my_health/maxhealth);
	draw_sprite_ext(spr_idle, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
	draw_sprite_ext(spr_glow, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha * hp);

#define FriendlyNecro_step
	if("counter" not in self){
		counter = 0;
	}
	counter += current_time_scale;
	if(counter >= 60){
		instance_destroy();
	}
	
#define FriendlyNecro_destroy
	var _t = team;
	var _c = creator;
	with(instances_meeting(x, y, Corpse)){
		with(obj_create(x,y,"FreakFriend")){
			team = _t;
			creator = _c;
		}
		instance_create(x,y,ReviveFX);
		instance_destroy();
	}

#define FreakFriend_step
	if(my_health <= 0){instance_destroy();exit;}//make them disappear in a poof
	//reusing some AI from an older mod!
	if(collision_line(x, y, creator.x, creator.y, Wall, false, false) == -4){
		motion_add_ct(point_direction(x, y, creator.x, creator.y), 0.5);
		wanderDir = direction;
	}
	else if(random(4)<1){
		wanderDir = (direction + point_direction(x,y,creator.x, creator.y)) / 2;
	}
	motion_add_ct(wanderDir, 1);
	speed = min(speed, 4);
	if(distance_to_object(hitme) < 10){
		x += 100;
		var near = instance_nearest(x-100,y,hitme);
		x -= 100;
		motion_add_ct(point_direction(near.x, near.y, x, y), 1);
	}
	if place_meeting(x + hspeed, y + vspeed, Wall) move_bounce_solid(true);
    var right = sign(lengthdir_x(1, direction));
    if(right == 0){right = 1;}
	if(sprite_index == spr_hurt && image_index == sprite_get_number(spr_hurt) - 1){
		sprite_index = spr_idle;
	}
	if(sprite_index != spr_hurt && sprite_index != spr_dead){
		if(speed > 0){
			sprite_index = spr_walk;
		}else{
			sprite_index = spr_idle;
		}
	}
	//damage enemies
	with(instances_meeting(x, y, enemy)){
		if(projectile_canhit_melee(other) && "canmelee" in self && canmelee && meleedamage > 0){
			projectile_hit(other, meleedamage);
		}
		with(other){
			if(projectile_canhit_melee(other)){
				projectile_hit(other, 3);
				sound_play(sndFreakMelee);
			}
		}
	}
	
#define FreakFriend_draw
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
	
#define FreakFriend_hurt(_dmg, _spd, _dir)
    my_health -= _dmg;
    nexthurt = current_frame + 5;
    sprite_index = spr_hurt;
    image_index = 0;
    sound_play_hit(snd_hurt, 0.6);
    motion_add(_dir, _spd);

#define FreakFriend_destroy
	instance_create(x,y,ReviveFX);
	sound_play(sndFreakDead);
	
#define MeatBlob_step
	if(!instance_exists(link)){raddrop = 0;instance_delete(self);exit;}
	
#define MeatBlob_death
	if(instance_exists(link)){instance_delete(link);}
	
	
#define Mutator_step
	x = xstart;
	y = ystart;
	
	if(sprite_index = sprProtoStatueDone and image_index >= sprite_get_number(sprite_index) - 1) {
		spr_idle = sprProtoStatueDoneIdle;
	}
	
	if(instance_exists(prompt)) {
		if(prompt.nearwep != noone and prompt.hover = 0) {
			sound_play(snd.StatuePrompt);
			prompt.hover = 1;
		}
		
		if(player_is_active(prompt.pick)) with(prompt.pick) {
			if(array_length(instances_matching_gt(Player, "maxhealth", 2)) = instance_number(Player)) {
				with(other) {
					spr_idle = sprProtoStatueDone;
					image_index = 0;
					spr_hurt = sprProtoStatueDoneHurt;
					with(prompt) instance_destroy();
				}
				
				with(GameCont) {
					skillpoints++;
				}
				
				with(Player) {
					projectile_hit_raw(self, min(2, my_health - 1), 3);
					maxhealth -= 2;
				}
				
				 // EFFECTS
				instance_create(x, y, LevelUp);
				
				sound_play(sndLevelUp);
				sound_play_pitch(sndUncurse, 1.4);
				sound_play_pitch(snd.StatueConfirm, 0.7);
				
				with(instances_matching(CustomProp, "name", "Shopkeep")) {
					sound_play_pitchvol(sndFlameCannonEnd, 1.5 + random(0.2), 0.4);
					spr_idle = global.sprMerchantPuff;
					image_index = 0;
				}
			}
			
			else {
				sound_play(snd.StatueAggro);
				sound_play(sndCursedReminder);
			}
		}
	}

#define MutRefresher_step
	if(instance_exists(Nothing) or instance_exists(Nothing2)) instance_delete(self);
	x = xstart;
	y = ystart;
	my_health = maxhealth;
	
	if(instance_exists(prompt) && player_is_active(prompt.pick)){
		my_health = 0;
	}

#define MutRefresher_death
	sound_play(sndStatueCharge);
	
	mod_script_call_nc('skill', 'criticalmass', 'skill_reset', 0);

#define MetaButton_step
	if(!instance_exists(Menu)) {
		instance_destroy();
		exit;
	}
	
	if(shift > 0) shift -= current_time_scale;
	if(shift < 0) shift = 0;
	
	var _hover = 0;
	
	for(var i = 0; i < maxp; i++) {
		if(lq_get(p_hover, `p${i}`)) {
			hover = 1;
			_hover++;
		}
	}
	
	if(_hover = 0) hover = 0;
	
	if(name != "MetaSettings") {
		if(hover or (name = "MetaProto" and !options_open and array_length(instances_matching(Loadout, "selected", 1)) = 0)) {
			if(splat < 3) {
				splat += current_time_scale;
				if(splat > 3) splat = sprite_get_number(sprMainMenuSplat);
			}
		}
		
		else if(splat > 0) {
			splat -= current_time_scale;
			if(splat < 0) splat = 0;
		}
		
		if(!options_open and name != "MetaProto") instance_destroy();
	}
	
#define MetaButton_click
	option_set(string_replace(setting[0], " ", "_"), !setting[1]);
	setting[1] = option_get(string_replace(setting[0], " ", "_"));
	shift += 1;
	sound_play_pitch(sndClick, 1 + random(0.2));

#define MetaPage_click
	with(instances_matching(CustomObject, "name", "MetaButton", "MetaMut")) instance_destroy();

	with(instances_matching(CustomObject, "name", "MetaSettings")) {
		splat = 0;
		other.shift = 1;
		switch(pages[other.index]) {
			case "options": 
				sound_play(sndMenuStats);
				options_create();
			break;
			
			case "mutations": 
				sound_play(sndMenuOptions); 
				
				mut_opts_create();
				
			break;
			
			case "stats": 
				sound_play(sndMenuCredits);
				
				stats_create();
			break;
		}
		
		page = other.index;
	}

#define MetaNone_step
	//if(next) 

#define MetaMut_end_step
	num = ceil((game_width - 120)/18);

#define MetaSettings_end_step
	with(instances_matching_gt(BackFromCharSelect, "depth", -1006)) depth = -1006;

	if(options_open) {
		with(Menu){
			mode      = 0;
			charsplat = 1;
			for(var i = 0; i < array_length(charx); i++){
				charx[i] = 0;
			}
			
			sound_volume(sndMenuCharSelect, 0);
		}
		with(Loadout) instance_destroy();
		with(loadbutton) instance_destroy();
		with(menubutton) instance_destroy();
		with(BackFromCharSelect) noinput = 10;
		
		if(splat < (sprite_get_number(sprUnlockPopupSplat) - 1)) {
			splat += current_time_scale;
			if(splat > (sprite_get_number(sprUnlockPopupSplat) - 1)) splat = sprite_get_number(sprUnlockPopupSplat);
		}
	}
	
	else if(splat > 0) {
		splat -= current_time_scale;
		if(splat < 0) splat = 0;
	}
	
#define MetaSettings_click
	if(options_open) {
		with(Menu) {
			mode = 0;
			event_perform(ev_step, ev_step_end);
			sound_volume(sndMenuCharSelect, 1);
			sound_stop(sndMenuCharSelect);
			with(CharSelect) alarm0 = 2;
		}
        sound_play(sndClickBack);
	}
	
	else {
		sound_play(sndClick);
		sound_play(sndMenuStats);
		options_create();
		
		var skill_list = mod_get_names("skill");
	
		page = 0;
		
		global.mutation_list = [];
		
		for(var m = 0; m < 29 + array_length(skill_list); m++) {
			if(m <= 29) array_push(global.mutation_list, string(m));
			else if(skill_get_avail(skill_list[m - 30]) or mod_script_exists("skill", skill_list[m - 30], "skill_cursed")) array_push(global.mutation_list, skill_list[m - 30]);
		}
	}

	mod_variable_set("mod", "metamorphosis_options", "option_open", !options_open);

#define MetaPrompt_begin_step
	with(nearwep) instance_delete(id);
	
#define MetaPrompt_end_step
	 // Follow Creator:
	var c = creator;
	if(c != noone){
		if(instance_exists(c)){
			if(instance_exists(nearwep)) with(nearwep){
				x += c.x - other.x;
				y += c.y - other.y;
				visible = true;
			}
			x = c.x;
			y = c.y;
			//image_angle = c.image_angle;
			//image_xscale = c.image_xscale;
			//image_yscale = c.image_yscale;
		}
		else instance_destroy();
	}
	
#define MetaPrompt_cleanup
	with(nearwep) instance_delete(id);

#define RichPickup_step
	if(instance_exists(creator)) {
		if(irandom(12/current_time_scale) == 0) {
			instance_create(x + random_range(sprite_get_width(creator.sprite_index)/2, -(sprite_get_width(creator.sprite_index)/2)), y + random_range(sprite_get_height(creator.sprite_index)/2, -(sprite_get_height(creator.sprite_index)/2)), CaveSparkle).depth = depth - 1;
		}
	}
	
	//var c = object_get_parent(creator);
	
	/*if(fork()) {
		wait 0;
		if(!instance_exists(self) and c = chestprop) with(instance_nearest(x, y, ChestOpen))
		exit;
	}*/

	AdrenalinePickup_step();
	
#define RichPickup_destroy
	var _player = instance_nearest(x, y, Player);
	if(instance_exists(_player) && place_meeting(x, y, _player)){
		with(_player){
			var _duration = (other.num * 50) * (skill_get("richtastes") + skill_get("magfingers"));
			haste(_duration, 0.4);
			
			 // Effects:
			sleep(30);
			
			sound_play(snd.GoldRush);
		}
	}
	
#define Shopkeep_step
	if(instance_exists(prompt)) {
		if(global.mut_quest = skill) with(prompt) {
			if(skill_get(other.skill)) text = `${metacolor}STORE@3(${skill_get_icon(other.skill)[0]}:${skill_get_icon(other.skill)[1]})?`;
			else text = `@qGO GET@3(${skill_get_icon(other.skill)[0]}:${skill_get_icon(other.skill)[1]})!`;
		}
		
		if(prompt.nearwep != noone and prompt.hover = 0) {
			sound_play(global.mut_quest = skill and !skill_get(other.skill) ? snd.PotRemind : snd.PotPrompt);
			prompt.hover = 1;
		}
		
		if(player_is_active(prompt.pick)){
			if(global.mut_quest = mut_none) {
				global.mut_quest = skill;
				spr_idle = global.sprMerchantPuff;
				image_index = 0;
				sound_play_pitchvol(sndFlameCannonEnd, 1.5 + random(0.2), 0.4);
				sound_play(snd.PotConfirm);
				
				with(instance_create(prompt.pick.x, prompt.pick.y, PopupText)) {
					mytext = `COME BACK WITH@3(${skill_get_icon(other.skill)[0]}:${skill_get_icon(other.skill)[1]})!`;
				}
				
				with(prompt) {
					instance_destroy();
				}
			}
			
			else if(global.mut_quest = skill and skill_get(skill)) {
				global.mut_quest = mut_none;
				skill_set(skill, 0);
				with(GameCont) skillpoints++;
				option_set("proto_mutation", skill);
				option_set("evolution_unlocked", true);
				var q = option_get("quests_completed");
				option_set("quests_completed", q = undefined ? 1 : (q + 1))
				
				metamorphosis_save();
				
				spr_idle = global.sprMerchantPuff;
				image_index = 0;
				
				 // EFFECTS
				with(instance_create(prompt.pick.x, prompt.pick.y, PopupText)) {
					mytext = `@3(${skill_get_icon(other.skill)[0]}:${skill_get_icon(other.skill)[1]})${metacolor} STORED!##@w+1 FREE MUTATION`
				}
				instance_create(prompt.pick.x, prompt.pick.y, LevelUp);
				
				sound_play_pitchvol(sndFlameCannonEnd, 1.5 + random(0.2), 0.4);
				sound_play(snd.PotTurnin);
				sound_play(sndLevelUp);
				sound_play_pitch(sndUncurse, 1.4);
				sound_play_pitch(sndBloodLauncherExplo, 0.7);
				
				with(prompt) instance_destroy();
			}
			
			else {
				sound_play_pitch(sndNoSelect, 1.2 + random(0.4));
				sound_play_pitch(sndCursedReminder, 1.4 + random(0.3));
			}
		}
		
		if((my_health < maxhealth or array_length(instances_matching(CustomProp, "name", "Mutator")) = 0)) {
			global.mut_quest = -1;
			with(prompt) instance_destroy();
			with(instances_matching(CustomProp, "name", "Mutator")) {
				with(prompt) instance_destroy();
			}
			with(instance_create(x, y, GreenExplosion)) {
				image_xscale = 0.5;
				image_yscale = 0.5;
				mask_index = mskNone;
			}
			sound_play_pitch(sndSwapCursed, 1.6 + random(0.2));
			if(instance_number(GuardianStatue)) {
				sound_play_pitch(sndHyperCrystalSpawn, 0.4 + random(0.4));
				sound_play_pitch(sndGuardianFire, 0.2 + random(0.6));
				sound_play(snd.PotAggro);
			}
			
			with(GuardianStatue) my_health = 0;
		}
	}
	
	if(sprite_index = global.sprMerchantPuff and image_index >= sprite_get_number(sprite_index) - 1) {
		spr_idle = global.sprMerchantIdle;
	}

#define prompt_create(_text)
	/*
		Creates an E key prompt with the given text that targets the current instance
	*/
	
	with(obj_create(x, y, "MetaPrompt")){
		text    = _text;
		creator = other;
		depth   = other.depth;
		
		return id;
	}
	
	return noone;

#define prompt_collision
	 // Prompt Collision:
	var _inst = instances_matching(CustomObject, "name", "MetaPrompt");
	with(_inst) pick = -1;
	_inst = instances_matching(_inst, "visible", true);
	if(array_length(_inst) > 0){
		with(Player) if(visible || variable_instance_get(id, "wading", 0) > 0){
			if(place_meeting(x, y, CustomObject) && !place_meeting(x, y, IceFlower) && !place_meeting(x, y, CarVenusFixed)){
				var _noVan = true;
				
				 // Van Check:
				if(place_meeting(x, y, Van)){
					with(instances_meeting(x, y, instances_matching(Van, "drawspr", sprVanOpenIdle))){
						if(place_meeting(x, y, other)){
							_noVan = false;
							break;
						}
					}
				}
				
				if(_noVan){
					// Find Nearest Touching Indicator:
					var	_nearest  = noone,
						_maxDis   = null,
						_maxDepth = null;
						
					if(instance_exists(nearwep)){
						_maxDis   = point_distance(x, y, nearwep.x, nearwep.y);
						_maxDepth = nearwep.depth;
					}
					
					with(instances_meeting(x, y, _inst)){
						if(place_meeting(x, y, other) && (!instance_exists(creator) || creator.visible || variable_instance_get(creator, "wading", 0) > 0)){
							var e = on_meet;
							if(!is_array(e) || mod_script_call(e[0], e[1], e[2])){
								if(_maxDepth == null || depth < _maxDepth){
									_maxDepth = depth;
									_maxDis   = null;
								}
								if(depth == _maxDepth){
									var _dis = point_distance(x, y, other.x, other.y);
									if(_maxDis == null || _dis < _maxDis){
										_maxDis  = _dis;
										_nearest = id;
									}
								}
							}
						}
					}
					
					 // Secret IceFlower:
					with(_nearest){
						nearwep = instance_create(x + xoff, y + yoff, IceFlower);
						with(nearwep){
							name         = other.text;
							x            = xstart;
							y            = ystart;
							xprevious    = x;
							yprevious    = y;
							visible      = false;
							mask_index   = mskNone;
							sprite_index = mskNone;
							spr_idle     = mskNone;
							spr_walk     = mskNone;
							spr_hurt     = mskNone;
							spr_dead     = mskNone;
							spr_shadow   = -1;
							snd_hurt     = -1;
							snd_dead     = -1;
							size         = 0;
							team         = 0;
							my_health    = 99999;
							nexthurt     = current_frame + 99999;
						}
						with(other){
							nearwep = other.nearwep;
							if(button_pressed(index, "pick")){
								other.pick = index;
							}
						}
					}
				}
			}
		}
	}
	
	instance_destroy();

	
  //				--- OTHER SCRIPTS ---			//
#define tip_generate
	var t = [];
	array_push(t, "SYNERGY");
	array_push(t, "THIS IS THE RUN");
	array_push(t, "TRY SOMETHING NEW");
	array_push(t, "@sTHE VAULTS HAVE " + metacolor + "VISITORS");
	array_push(t, "FIND NEW COMBINATIONS");
	array_push(t, "THE META ISN'T EVERYTHING");
	array_push(t, "TRY WITH @w" + choose("NT:TE", minicolor + "MINIMOD", "DEFPACK", "VAGABONDS") + "!");
	array_push(t, "THE AMMO ECONOMY IS IN SHAMBLES");
	array_push(t, "@sEVERY MUTANT HAS A NEW " + metacolor + "ULTRA");
	array_push(t, "SPECIALIZE");
	array_push(t, "SOMETHING SPECIAL");
	array_push(t, "ADAPT");
	array_push(t, "PARTS OF A WHOLE");
	array_push(t, "SUM OF ALL THE PARTS");
	array_push(t, "COMBINATORIAL EXPLOSION");
	array_push(t, "HOW DID WE GET HERE?");
	array_push(t, "INNOVATE");
	array_push(t, "STRANGE ANATOMY");
	array_push(t, "THANKS FOR PLAYING!");
	array_push(t, "ADVANCED PHYSIOLOGY");
	array_push(t, "WE CAN BECOME BETTER");
	array_push(t, "BECOME STRONGER");
	
	return metacolor + t[irandom(array_length(t) - 1)];

#define haste(amt, pow)
	if(amt > 0 and pow > 0) {
		if(hastened < amt) hastened = amt;
		
		if(hastened_power = 0) {
			hastened_power = pow;
			reloadspeed    += pow;
			maxspeed	   += pow;
		}
		
		else if(hastened_power < pow) {
			reloadspeed += pow - hastened_power;
			maxspeed    += pow - hastened_power;
			hastened_power = pow;
		}
	}

#define effigy_set_muts(first, second)
	option_set("effigy_mut_1", first);
	option_set("effigy_mut_2", second);

#define effigy_get_muts
	return [option_get("effigy_mut_1"), option_get("effigy_mut_2")];

#define skill_decide(_category)
	 // Stolen from NTTE, modified to fit our needs
	var _skillList = [],
		_skillMods = mod_get_names("skill"),
		_skillMax  = 30,
		_skillAll  = true; // Already have every available skill
		
	for(var i = 1; i < _skillMax + array_length(_skillMods); i++){
		var _skill = ((i < _skillMax) ? i : _skillMods[i - _skillMax]);
		
		if(
			skill_get_avail(_skill)
			&& _skill != mut_patience
			&& (_skill != mut_last_wish || skill_get(_skill) <= 0)
			&& array_length(instances_matching(SkillIcon, "skill", _skill)) = 0
			&& array_find_index(global.disabled_muts, _skill) = -1
			&& (_category = 0 or array_find_index(global.mut_category[_category], _skill) != -1)
		){
			array_push(_skillList, _skill);
			if(skill_get(_skill) == 0) _skillAll = false;
		}
	}
	
	with(array_shuffle(_skillList)){
		var _skill = self;
		if(_skillAll || skill_get(_skill) == 0) return _skill;
	}
	
	return mut_none;
	
#define skill_get_avail(_skill)
	/*
		Returns 'true' if the given skill can appear on the mutation selection screen, 'false' otherwise
	*/
	
	if(skill_get_active(_skill)){
		if(
			_skill != mut_heavy_heart
			|| skill_get(mut_heavy_heart) != 0
			|| (GameCont.wepmuts >= 3 && GameCont.wepmuted == false)
		){
			if(
				!is_string(_skill)
				|| !mod_script_exists("skill", _skill, "skill_avail")
				|| mod_script_call("skill", _skill, "skill_avail")
			){
				return true;
			}
		}
	}
	
	return false;

#define skill_get_category(mut)
	if(mut = "disciple") {
		return 6;
	}
	
	else for(var i = 1; i < array_length(categories); i++) {
		if(is_string(mut)){
			if(array_find_index(categories[i], string_replace(string_replace(string_lower(mut), " ", ""), "_", "")) != -1) {
				return i;
			}
		}
		
		else{
			if(array_find_index(categories[i], mut) != -1) {
				return i;
			}
		}
	}
	
	return 3;

#define current_cursed
	var c = 0;
	
	with(Player) {
		c += (curse + bcurse) * 20; 
	}
	
	if(crown_current != crwn_none) {
		c = (crown_current == crwn_curses) ? max(c, 6) * 3 : max(5, c);
	}
	
	c = random(100) < c;
	
	if(skill_get("repentance")) c = 0; // NO MORE CURSED MUTATIONS
	
	return c;

#define option_set(opt, val)
	var s = SETTING;
	lq_set(s, opt, val);
	mod_variable_set("mod", "metamorphosis_options", "settings", s);
	metamorphosis_save();

#define option_get(opt)
	var s = lq_get(SETTING, opt);
	if(s = undefined) return false;
	else return s;

#define options_create
	var s = "",
		v = "";
	
	if(fork()) {
		wait 4;
		
		for(var i = 0; i < 6; i++) {
		    if(!options_open or array_length(instances_matching(instances_matching(CustomObject, "name", "MetaSettings"), "splat", 0)) > 0) exit;
		    s = global.option_list[i];
		    v = lq_get(SETTING, string_replace(s, " ", "_"));
		    
		    with(obj_create(x, y, "MetaButton")) {
		    	setting = [s, v];
		    	index = array_length(instances_matching(CustomObject, "name", "MetaButton"));
		    	on_click = script_ref_create(MetaButton_click);
		    	right_off = 220;
		    	bottom_off = 10;
		    	shift = 2;
		    	sound_play_pitch(sndAppear, random_range(0.5, 1.5) + (index/10));
		    }
		    
		    if(array_length(instances_matching(CustomObject, "name", "MetaPage")) < 3 and i < 3) {
		    	with(obj_create(x, y, "MetaButton")) {
					name = "MetaPage";
					index = i;
					page = other.pages[i];
					left_off = string_length(page) * 8;
					bottom_off = 6;
					shift = 2;
					on_click = script_ref_create(MetaPage_click);
				}
		    }
		    
		    wait 1;
		}
		
		exit;
	}
	
	metamorphosis_save();

#define mut_opts_create
	var s = "",
		v = "";
	
	if(fork()) {
		wait 4;
		
		for(var i = 1; i < array_length(global.mutation_list); i++) {
		    if(!options_open or array_length(instances_matching(instances_matching(CustomObject, "name", "MetaSettings"), "splat", 0)) > 0) exit;
		    s = global.mutation_list[i];
		    v = lq_get(SETTING, `${string_replace(s, " ", "_")}_enabled`);
		    if(v = undefined) v = true;
		    
		    with(obj_create(x, y, "MetaButton")) {
		    	name = "MetaMut";
		    	setting = [s + "_enabled", v];
		    	index = array_length(instances_matching(CustomObject, "name", "MetaMut")) - 1;
		    	on_end_step = script_ref_create(MetaMut_end_step);
		    	on_click = script_ref_create(MetaButton_click);
		    	left_off = 8;
		    	right_off = 8;
		    	top_off = 8;
		    	bottom_off = 8;
		    	shift = 2;
		    	spr_icon = skill_get_icon(string_digits(s) != "" ? real(s) : s);
		    	num = round((game_width - 120)/18);
		    	sound_play_pitch(sndAppear, random_range(0.5, 1.5) + (index/10));
		    }
		    
		    wait 1;
		}
		
		exit;
	}
	
	metamorphosis_save();
	
#define stats_create
	var s = "",
		v = "";
	
	if(fork()) {
		wait 4;
		
		for(var i = 0; i < 4; i++) {
		    if(!options_open or array_length(instances_matching(instances_matching(CustomObject, "name", "MetaSettings"), "splat", 0)) > 0) exit;
		    s = global.stats_list[i];
		    v = lq_get(SETTING, string_replace(s, " ", "_"));
		    if(v = undefined) v = 0;
		    
		    with(obj_create(x, y, "MetaButton")) {
		    	setting = [s, v];
		    	index = array_length(instances_matching(CustomObject, "name", "MetaButton"));
		    	right_off = 220;
		    	bottom_off = 10;
		    	shift = 2;
		    	sound_play_pitch(sndAppear, random_range(0.5, 1.5) + (index/10));
		    }
		    
		    wait 1;
		}
		
		exit;
	}
	
	metamorphosis_save();

#define metamorphosis_save
	mod_script_call_nc("mod", "metamorphosis_options", "metamorphosis_save");

#define skill_get_icon(_skill)
	/*
		Returns an array containing the [sprite_index, image_index] of a mutation's HUD icon
	*/
	
	if(is_real(_skill)){
		return [sprSkillIconHUD, _skill];
	}
	
	if(is_string(_skill) && mod_script_exists("skill", _skill, "skill_icon")){
		return [mod_script_call("skill", _skill, "skill_icon"), 0];
	}
	
	return [sprEGIconHUD, 2];

#define orandom(_num) return irandom_range(-_num, _num);

#define instance_near(_x, _y, _obj, _dis)
	/*
		Returns the nearest instance of the given object that is within the given distance of the given position
		
		Args:
			x/y - The position to check
			obj - An object, instance, or array of instances
			dis - The distance to check, can be a single number for max distance or a 2-element array for [min, max]
			
		Ex:
			instance_near(x, y, Player, 96)
			instance_near(x, y, instances_matching(hitme, "team", 2), [32, 64])
	*/
	
	var	_inst   = noone,
		_disMin = (is_array(_dis) ? _dis[0] : 0),
		_disMax = (is_array(_dis) ? _dis[1] : _dis);
		
	with(
		(is_real(_obj) && object_exists(_obj) && _disMin <= 0)
		? instance_nearest(_x, _y, _obj)
		: _obj
	){
		var _d = point_distance(_x, _y, x, y);
		if(_d <= _disMax && _d >= _disMin){
			_disMax = _d;
			_inst = id;
		}
	}
	
	return _inst;

#define instance_seen(_x, _y, _obj)
	/*
		Returns the nearest instance of the given object that is seen by the given position (no walls between)
		
		Args:
			x/y - The position to check
			obj - An object, instance, or array of instances
	*/
	
	var	_inst   = noone,
		_disMax = infinity;
		
	with(_obj){
		if(!collision_line(_x, _y, x, y, Wall, false, false)){
			var _dis = point_distance(_x, _y, x, y);
			if(_dis < _disMax){
				_disMax = _dis;
				_inst = id;
			}
		}
	}
	
	return _inst;

#define instances_meeting(_x, _y, _obj)
	/*
		Returns all instances whose bounding boxes overlap the calling instance's bounding box at the given position
		Much better performance than manually performing 'place_meeting(x, y, other)' on every instance
	*/
	
	var	_tx = x,
		_ty = y;
		
	x = _x;
	y = _y;
	
	var _inst = instances_matching_ne(instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", bbox_left), "bbox_left", bbox_right), "bbox_bottom", bbox_top), "bbox_top", bbox_bottom), "id", id);
	
	x = _tx;
	y = _ty;
	
	return _inst;

#define instances_in_rectangle(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all instances of the given object whose positions overlap the given rectangle
		Much better performance than checking 'point_in_rectangle()' on every instance
		
		Args:
			x1/y1/x2/y2 - The rectangular area to search
			obj         - The object(s) to search
	*/
	
	return (
		instances_matching_le(
		instances_matching_le(
		instances_matching_ge(
		instances_matching_ge(
		_obj,
		"x", _x1),
		"y", _y1),
		"x", _x2),
		"y", _y2)
	);

#define instance_rectangle_bbox(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all given instances with their bounding box touching a given rectangle
		Much better performance than manually performing 'place_meeting()' on every instance
	*/
	
	return instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", _x1), "bbox_left", _x2), "bbox_bottom", _y1), "bbox_top", _y2);

#define floor_fill(_x, _y, w, h)
	for(ix = 0; ix < abs(w); ix++) {
		for(iy = 0; iy < abs(h); iy++) {
			instance_create(grid_lock(_x, 32) + (ix * (32 * sign(w))) + 16, grid_lock(_y, 32) + (iy * (32 * sign(h))) + 16, Floor);
		}
	}

#define grid_lock(value, grid)
	return floor(value/grid) * grid; // Returns the given value locked to the given grid size
	
#define array_shuffle(_array)
	var	_size = array_length(_array),
		j, t;
		
	for(var i = 0; i < _size; i++){
		j = irandom_range(i, _size - 1);
		if(i != j){
			t = _array[i];
			_array[@i] = _array[j];
			_array[@j] = t;
		}
	}
	
	return _array;

#define array_delete(_array, _index)
	/*
		Returns a new array with the value at the given index removed
		
		Ex:
			array_delete([1, 2, 3], 1) == [1, 3]
	*/
	
	var _new = array_slice(_array, 0, _index);
	
	array_copy(_new, array_length(_new), _array, _index + 1, array_length(_array) - (_index + 1));
	
	return _new;