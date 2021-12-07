 //				--- BASE NTT SCRIPTS ---			//
#define init
	if(fork()) {
		global.libLoaded = false;
		
		while(!mod_exists("mod", "lib")){wait(1);}
		var _l = ["libMenu", "libMuts", "libStats", "libAutoUpdate", "libSaves"];
		
		with(_l) call(["mod", "lib", "import"], self);
		
		if(fork()) {
    		while(!mod_sideload() and !global.libLoaded) wait 1;
			mod_loadtext("main3.txt");
			
			if(fork()) {
		    	wait 3;
		    	
		    	repeat(17) trace("");
		    	trace_color("Thanks for playing Metamorphosis!", c_green);
		    	trace_color("Be sure to report any bugs to tildebee in the official Nuclear Throne discord (discord.gg/nt)", c_aqua);
		    	
		    	 // Update the stats //
		    	var t = call(scr.save_get, mod_current, "times_loaded", 0);
			    call(scr.save_set, mod_current, "times_loaded", t + 1);
		    	
		    	exit;
		    }
			
			exit;
    	}
		
		global.libLoaded = true;
		
		call(["mod", "lib", "getRef"], "mod", mod_current, "scr");
		call(scr.obj_setup, mod_current, ["AdrenalinePickup", "BeamChild", "CheekPouch", "CrystallineEffect", "CrystallinePickup", "CustomBeam", "EffigyOrbital", "MutRefresher", "MetaButton", "Shopkeep", "Mutator"]);
		
		call(scr.save_load, mod_current, {
			proto_mutation      : mut_none, // Figure out which mut is saved for proto mutations
	    	use_proto           : true, // For the toggle to use the proto mutation on any given run
	        shopkeeps		    : true, // Toggle vault shopkeepers
	        evolution_unlocked  : false, // Unlock the new crown. If you disable the vault shopkeepers, unlocking the crown is impossible without save editing
	        allow_characters    : true, // Toggle the new characters
	        cursed_mutations    : true, // Toggle whether or not cursed mutations show up
	        custom_ultras       : true, // Toggle all custom ultras
	        loop_mutations      : true, // Toggle gaining a mutation each loop past the first
	        metamorphosis_tips  : true, // Toggle custom tips
	        become_ungovernable : true, // ?
	        effigy_unlocked     : 1, 
	        effigy_tokens		: 0,    // Amount of tokens you have to play Effigy
	        effigy_mut			: [call(scr.skill_decide), call(scr.skill_decide)], // Effigy's starting mutations
	        disabled_muts		: [mut_open_mind, mut_trigger_fingers]
		});
	    
	    call(scr.skill_set_category,
    	[
    		["dividedelbows", "linkedlobes", "pyromania", "racingthoughts", "richtastes", "blastbile", "ignitionpoint", "thunderclap", "compoundelbow", "concentration", "excitedneurons", "powderedgums", "flamingpalms", "Brain Transfer", "Compressing Fist", "Confidence", "Double Vision", "Energized Intestines", "Fractured Fingers", "Neural Network", "Deep Convolutional Network", "Deep Residual Network", "Echo State Network", "Feed Forward Network", "Generative Adversarial Network", "Markov Chain", "Recurrent Neural Network", "Support Vector Machines", "Rocket Casings", "Shattered Skull", "Shocked Skin", "Sloppy Fingers", "Staked Chest", "Waste Gland", "Muscle Memory", "prismaticiris", "decayingflesh", "displacement", "blastingcaps"],
    	
	    	["crystallinegrowths", "turtleshell", "perfectfreeze", "condensedmeat", "Garment Regenerator", "Sadism", "Steel Nerves", "tougherstuff", "scartissue", "vacuumvacuoles"],
	    	
	    	["atomicpores", "camoflauge", "crowncranium", "grace", "insurgency", "leadeyelids", "secretstash", "selectivefocus", "gluttony", "Dynamic Calves", "Filtering Teeth", "Mimicry", "Pressurized Lungs", "Thick Head", "Toxic Thoughts", "Unstable DNA", "floweringfolicles", "compassion", "falseprayer", "impatience", "portalinstability", "weirdscience"],
	    	
	    	["cheekpouch", "magfingers", "thinktank", "Duplicators", "Scrap Arms", "brassblood", "silvertongue", "adrenaline"]
    	],
    	
    	[
			"offensive",
	    	"defensive",
	    	"utility",
	    	"ammo"
    	]
    	);
	}

	//#region SOUNDS
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
		}
	//#endregion
	
	//#region SPRITES
		 // MUTATION EFFECTS //
		global.sprMedpack		= sprite_add("sprites/VFX/sprFatHP.png",  7,  6,  6);
		global.sprFatPizza		= sprite_add_weapon("sprites/VFX/sprFatPizza.png",  10,  10);
		global.sprHPCrystalline    = sprite_add("sprites/VFX/sprCrystalHP.png", 7, 6, 7);
		global.sprFatHPCrystalline = sprite_add("sprites/VFX/sprFatCrystalHP.png", 7, 9, 10);
		global.sprCrizza		= sprite_add_weapon("sprites/VFX/sprCrizza.png",  8,  8);
		global.sprFatCrizza		= sprite_add_weapon("sprites/VFX/sprFatCrizza.png",  10,  10);
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
	
		 // CROWN CRANIUM
		global.sprMeatBlob			   = sprite_add("sprites/Props/sprMeatBlob.png",	       1, 11, 12);
		global.sprFriendlyRevive	   = sprite_add("sprites/VFX/sprFriendlyRevive.png",       8, 24, 24);
		global.sprFriendlyReviveCircle = sprite_add("sprites/VFX/sprFriendlyReviveCircle.png", 4, 40, 40);
		global.sprFriendlyFreakIdle    = sprite_add("sprites/VFX/sprFriendlyFreakIdle.png",    6, 12, 12);
		global.sprFriendlyFreakWalk    = sprite_add("sprites/VFX/sprFriendlyFreakWalk.png",    6, 12, 12);
	//#endregion

	 // ? //
	global.sprLegume = sprite_add("sprites/sprLegume.png", 1, 9, 9);
	
	 // VARIOUS USEFUL VARIABLES //
	global.begin_step    = script_bind_begin_step(begin_step, 0);
	global.option_list   = ["shopkeeps", "allow characters", "cursed mutations", "custom ultras", "loop mutations", "metamorphosis tips", "become ungovernable"];
	global.stats_list    = ["vault visits", "distance evolved", "quests completed", "times loaded"];
	global.mutation_list = [];
	
	global.current_muts  = [];
    
	 // GET EM //
	global.mut_quest = mut_none;
	
	 // STATUS EFFECTS //
	global.asleep     = [];
	global.ignited    = [];
	global.steel_wool = [];
	
	//#region BEAM CONTROLLER
		var _surface = surface_create(1, 4);
	
		if (surface_exists(_surface)){
			surface_set_target(_surface);
			
			draw_clear_alpha(c_white, 1);
			
			surface_reset_target();
			
			surface_save(_surface, "1x4 white pixels.png");
			
			surface_free(_surface);
		}
		
		global.mask = sprite_add("1x4 white pixels.png", 1, 0, 2);
		
		// array that all beams get added to
		global.beams = [];
		
		global.debug_draw = false;
		
		// make the list of beams persist in case someone reloads the mod while one's being used for whatever reason
		var _persist = instances_matching(CustomObject, CONTROLLER, mod_current);
		
		if (array_length(_persist) > 0){
			var _restored = false;
			
			with(_persist){
				if (!_restored){
					_restored = true;
					
					global.beams = beams;
				}
				
				instance_delete(self);
			}
		}
		
		global.beta = false;
		
		try{
			global.beta = !null;
		}
		
		catch(_error){
			global.beta = false;
		};
	//#endregion
	
	
	with(Menu) {
		mode = 0;
		event_perform(ev_step, ev_step_end);
		sound_volume(sndMenuCharSelect, 1);
		sound_stop(sndMenuCharSelect);
		with(CharSelect) alarm0 = 2;
	}
	
	with(GameCont) if(area = 100 and array_length(instances_matching(Player, "race", "effigy")) and audio_is_playing(mus100) and !audio_is_playing(snd.Artificing)) sound_play_music(snd.Artificing);

 // General Use Macros:
#macro mod_current_type script_ref_create(0)[0]
#macro bbox_center_x (bbox_left + bbox_right + 1) / 2
#macro bbox_center_y (bbox_top + bbox_bottom + 1) / 2
#macro infinity (global.beta ? 1 / 0 : 1000000)
#macro negative_infinity (global.beta ? -1 / 0 : -1000000)
#macro  snd                                                                                     global.snd
#macro  mus																						snd.mus
#macro  scr																						global.scr
#macro  call																					script_ref_call

 // Mod Macros:
#macro metacolor `@(color:${make_color_rgb(110, 140, 110)})`;
#macro minicolor `@(color:${make_color_rgb(183, 195, 204)})`;
#macro SETTING mod_variable_get("mod", "metamorphosis_options", "settings")
#macro options_open mod_variable_get("mod", "metamorphosis_options", "option_open")
#macro options_avail instance_exists(Menu) and (Menu.mode = 1 or options_open)
#macro quest global.mut_quest
#macro categories global.mut_category
#macro CONTROLLER mod_current + "." + mod_current_type + " controller"

 // Custom Instance Macros:
#macro CrystallineEffect instances_matching(CustomObject, "name", "CrystallineEffect")
#macro CrystallinePickup instances_matching(CustomObject, "name", "CrystallinePickup")

#define game_start
	 // Gives you your proto mutation, if you have it enabled //
	if(call(scr.save_get, mod_current, "use_proto") = true and call(scr.save_get, mod_current, "proto_mutation") != mut_none) {
		skill_set(call(scr.save_get, mod_current, "proto_mutation"), 1);
		call(scr.save_set, mod_current, "proto_mutation", mut_none);
	}
	
	global.disabled_muts = [];
	
	var skill_list = mod_get_names("skill"),
    		c = 0;
	
	with(call(scr.save_get, mod_current, "disabled_muts")) {
		skill_set_active(self, false);
	}
	
	global.mut_quest = mut_none; // Make sure the shopkeep doesn't have a quest active //
	
	with(instances_matching_lt(instances_matching(CustomObject, "name", "MetaUnlock"), "id", GameCont.id)){
		instance_delete(self);
	}

#define level_start
	 // For powerup mutations:
	var _t = 0; 
	
	 // Find the total HP of the stage:
	with(enemy) {
		_t += my_health;
	}
	
	if(skill_get("richtastes")) {
		var _m = min(ceil(_t * 0.1), 75 * max(GameCont.loops, 1)),
			_e = instances_matching(enemy, "", undefined);
			
		
		while(_m > 0) {
			with(_e[irandom(array_length(_e) - 1)]) {
				_m -= my_health;
				richtastes_select = true;
			}
		}
	}
	
	if(skill_get("leadeyelids")) {
		with(enemy) {
			fall_asleep(100 + 50 * skill_get("leadeyelids") + random(30));
		}
	}

#define update(_newID)
	if(skill_get("steelwool")) {
		with(instances_matching(instances_matching_gt(projectile, "id", _newID), "object_index", Laser, EnergySlash, EnergyShank, EnergyHammerSlash, PlasmaBall, PlasmaBig, PlasmaHuge, PlasmaImpact, Lightning, LightningBall, LightningSlash, LightningSpawn)) {
			array_push(global.steel_wool, self);
		}
		
		with(instances_matching(instances_matching_gt(CustomProjectile, "id", _newID), "ammo_typ", 5)) {
			array_push(global.steel_wool, self);
		}
		
		with(instances_matching(instances_matching_gt(CustomProjectile, "id", _newID), "name", "Plasmite", "Lightning Bolt", "Lightning Bullet", "Laser Flak", "Vector", "Lightning Bullak", "Vector Beam")) {
			array_push(global.steel_wool, self);
		}
	}

#define step
	if(!global.libLoaded){exit;}

	if(!instance_exists(global.begin_step)) global.begin_step = script_bind_begin_step(begin_step, 0);
	script_bind_draw(skill_effects, -1001);
	script_bind_draw(effigy_token_draw, -1005);
	
	 // Setting setup:
	/*with(instances_matching(Menu, "metamorphosis", null)) {
		metamorphosis = 1;
		
		if(call(scr.save_get, mod_current, "proto_mutation") = -1) call(scr.save_set, mod_current, "proto_mutation", mut_none);
		
		with(call(scr.obj_create, x, y, "MetaButton")) {
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
		
		with(call(scr.obj_create, x, y, "MetaButton")) {
			name = "MetaProto";
			setting = ["use_proto", call(scr.save_get, mod_current, "use_proto")];
			left_off = 36;
			right_off = 0;
			top_off = 28;
			bottom_off = 28;
			on_click = script_ref_create(MetaButton_click);
		}
	}*/
	
	 // Character Selection Sound:
	if(instance_exists(CharSelect) and instance_exists(Menu)) {
    	var _race = [];
		for(var i = 0; i < maxp; i++){
		    _race[i] = player_get_race(i);
		    if(fork()) {
		    	wait 1;
		    	
				var r = player_get_race(i);
				if(instance_exists(CharSelect) and instance_exists(Menu) and _race[i] != r and r = "effigy") {
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
		if(area = 100 and array_length(instances_matching(Player, "race", "effigy")) and audio_is_playing(mus100) and !audio_is_playing(snd.Artificing)) sound_play_music(snd.Artificing);
	}
	
    with(instances_matching(HPPickup, "meta_hp", null)) {
    	meta_hp = true;
        if(skill_get(mut_second_stomach)) {
        	sprite_index = (sprite_index = sprSlice ? global.sprFatPizza : global.sprMedpack);
        }
        
        if(skill_get("crystallinegrowths")) {
        	sprite_index = (sprite_index = sprSlice ? global.sprCrizza : 
        					sprite_index = global.sprFatPizza ? global.sprFatCrizza :
        					sprite_index = global.sprMedpack ? global.sprFatHPCrystalline :
        					global.sprHPCrystalline);
        }
    }
    
    with(instances_matching_gt(GameCont, "loops", 0)) { // Free mutation for every loop past the first
		if(!variable_instance_exists(self, "lstloop") or lstloop != loops) {
			lstloop = loops;
			if(call(scr.save_get, mod_current, "loop_mutations") and loops > 1) {
	    		skillpoints++;
				sound_play(sndLevelUp);
		    }
		    
		    if(array_length(instances_matching(Player, "race", "effigy"))) {
		    	mod_variable_set("race", "effigy", "rerolls", 3);
		    	 // Update the stats //
		    	var t = call(scr.save_get, mod_current, "effigy_tokens", 0);
			    call(scr.save_set, mod_current, "effigy_tokens", min(t + 1, 99));
	    		
	    		call(scr.unlock_splat, "", `+1 ${metacolor}EFFIGY TOKEN@s` + (random(1000) < 1 ? `  @(${global.sprLegume})  ` : ""), -1, -1);
		    }
		}
    }
    
    with(instances_matching(mutbutton, "object_index", SkillIcon, EGSkillIcon)) { 
    	 // For the mutation options screen
    	if(instance_exists(self) and object_index = SkillIcon and "seen" not in self) {
    		seen = true;
    		call(scr.save_set, mod_current, `${skill}_seen`, 1);
    	}
    	
		if(instance_exists(self) and ((object_index = EGSkillIcon) or (is_string(skill) and mod_script_exists("skill", skill, "skill_ultra")))) { // Handler for redundant ultras
			if((!is_string(skill) and ultra_get(race, skill)) or (object_index != EGSkillIcon and is_string(skill) and skill_get(skill))) {
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
    	if("crystallinegrowth" not in self) {
    		crystallinegrowth = 0;
    	}
    	
    	if(crystallinegrowth > 0) {
    		var _curhp = my_health;
    		if(fork()) {
    			wait 0;
    			if(instance_exists(self) and _curhp > my_health) call(scr.change_health, self, _curhp - my_health);
    			exit;
    		}
    		crystallinegrowth -= current_time_scale;
    	}
    	
    	var m = 0;
		global.current_muts = [];

		while(skill_get_at(m) != undefined) {
			if(!mod_script_exists("skill", string(skill_get_at(m)), "skill_ultra")) array_push(global.current_muts, skill_get_at(m));
			m++;
		}
    	
    	if(fork()) {
    		wait 0;
    		
    		if(array_length(instances_matching(Player, "race", "effigy")) and m >= 13 and !call(scr.save_get, mod_current, "effigy_skin_1")) {
				call(scr.save_set, mod_current, "effigy_skin_1", 1);
				metamorphosis_save();
				with(call(scr.unlock_splat, "EFFIGY B-SKIN UNLOCKED", `FOR OBTAINING 13 MUTATIONS`, mod_variable_get("race", "effigy", "sprPortrait")[1], sndCharUnlock)) nam[1] = "EFFIGY B";
    		}
    		
    		if(instance_number(Player) = 0 and array_length(global.current_muts) > 0) {
				/*var l = array_length(global.current_muts);
				if(l = 1) {
					var emuts = effigy_get_muts();
					effigy_set_muts(global.current_muts[l - 1], (emuts[0] != global.current_muts[l - 1] ? emuts[0] : emuts[1]));
				}
				
				else {
					effigy_set_muts(global.current_muts[l - 1], global.current_muts[l - 2]);
				}*/
    			
    		}
    		
    		exit;
    	}
    }
    
     // LEVEL GEN BULLSHIT
    if(instance_exists(GenCont) and GenCont.alarm0 > 0 and GenCont.alarm0 <= room_speed) { // this checks to make sure the level is *mostly* generated, save for *most* props. for example, this will find the Crown Pedestal in the Vaults, but won't find any torches.
    
    	 // for horror's ultra
    	if(skill_get("criticalmass") > 0) {
			 // Place down the mutation reselector
			if((GameCont.hard - mod_variable_get("skill", "criticalmass", "diff")) mod 3 = 0 and array_length(instances_matching(CustomProp, "name", "MutRefresher")) <= 0) {
				var ffloor = instance_furthest(0, 0, Floor);
				with(ffloor) call(scr.obj_create, bbox_center_x, bbox_center_y, "MutRefresher");
			}
		}
    	
    	
    	 // place the shop area in the crown vault
    	with(instances_matching(CrownPed, "shopping", null)) {
    		shopping = "i be";
    		
    		 // Update the stats //
	    	var v = call(scr.save_get, mod_current, "vault_visits", 0);
		    call(scr.save_set, mod_current, "vault_visits", v + 1);
    		
	    	if(call(scr.save_get, mod_current, "shopkeeps") and (!mod_exists("mod", "vagabonds_master") or !mod_variable_exists("mod", "vagabonds_master", "settings") or !mod_variable_get("mod", "vagabonds_master", "settings").setting_newvault)) {
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
						call(scr.obj_create, ffloor.x + lengthdir_x(128, shop_dir) - 4, ffloor.y + lengthdir_y(128, shop_dir), "Shopkeep");
						call(scr.obj_create, ffloor.x + lengthdir_x(128, shop_dir) + 36, ffloor.y + lengthdir_y(128, shop_dir), "Mutator");
					}
				}
	    	}
    	}
    	
    	with(Player) { // Chicken ultra
    		haste(210 * skill_get("strengthindeath"), 0.5);
    	}
    }
	
	with(global.ignited) {
		 // If they're already ignited, do stuff!
		if("metamorphosis_ignited" in self and metamorphosis_ignited > 0) {
			 // This looks weird, but it's to mitigate how often it spawns fire. Should be once every 3 frames!
			if((metamorphosis_ignited mod 5) = 0) {
				var nplayer = instance_nearest(x, y, Player);

				with(instance_create(x + random_range(8, -8), y + random_range(8, -8), Flame)) {
					 // Makes sure there's a player that exists. No errors!
					if(nplayer > 0) {
						creator = nplayer;
						team = creator.team;
					}
				}

				 // Set the direction of the smoke, for visual reasons
				var dir = ((direction > 90 and direction < 270) ? -30 : 30);

				with(instance_create(x + random_range(6, -6), y + random_range(6, -6), SmokeOLD)) {
					depth = -10;
					motion_add(90 + (dir * speed), 5);
					mask_index = mskNone;
				}

				sound_play_pitchvol(sndFiretrap, 1 + random(0.4), 1.4);
			}

			metamorphosis_ignited -= current_time_scale;

			if(metamorphosis_ignited <= 0) {
				 // SOFTLOCK PREVENTION
				if(alarm_get(0) > -1) {
					metamorphosis_ignited++;
				}

				else {
					for(var i = 0; i < 360; i += 40/("size" in self ? size : 1)) {
						with(instance_create(x + random_range(6, -6), y + random_range(6, -6), SmokeOLD)) {
							motion_add(i, 3 * (("size" in other ? other.size : 1)/2));
							friction = ("size" in other ? other.size : 1) * 0.2;
						}
					}
					
					global.ignited = call(scr.array_delete_value, global.ignited, self);
					
					if(instance_is(self, Corpse)) instance_destroy();
				}
			}
		}
	}
	
	with(instances_matching(Corpse, "sprite_index", -5)){
		instance_destroy();
	}

#define begin_step
	if(!global.libLoaded){exit;}

	with(instances_matching(CharSelect, "race", "effigy")) {
		if(!call(scr.save_get, mod_current, "effigy_tokens")){
			noinput = 10;
		}
	}

	if(array_length(instances_matching(Player, "race", "effigy")) > 0) with(instances_matching(LevCont, "effigy_mut", null)) {
		effigy_mut = 0;
	
		for(var e = 0; e < maxp; e++) {
			if(effigy_mut = 0) {
				with(instances_matching(Player, "index", e)) {
					if("effigy_sacrificed" in self and array_length(effigy_sacrificed) > 0) {
						other.effigy_mut = effigy_sacrificed[0];
						effigy_sacrificed = call(scr.array_delete, effigy_sacrificed, 0);
					}
				}
			}
		}
    	
    	if(GameCont.crownpoints <= 0 and effigy_mut != 0) {
    		 // Clear:
			var _inst = instances_matching(mutbutton, "creator", self);
			if(array_length(_inst)){
				with(_inst){
					if(instance_is(self, SkillIcon) and (call(scr.skill_get_avail, skill, 0, 0) or mod_script_exists("mod", string(skill), "skill_cursed"))){
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
				
				sacrifice = true;
				
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
					
					skill   = call(scr.skill_decide, 0, call(scr.skill_get_category, _skill));
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
    			if(!call(scr.skill_get_avail, skill)) unavail++;
    		}
    		
    		if(unavail < instance_number(SkillIcon)) {
    			maxselect++;
    			with(instance_create(0, 0, SkillIcon)){
					creator = other;
					num     = other.maxselect;
					alarm0	= num + 1;
					skill   = "effigyreroll";
					
					var _n = irandom(3),
						_c = mod_variable_get("skill", "effigyreroll", "category");
					name    = `${skill_get_name(skill)} @g(${mod_variable_get("race", "effigy", "rerolls")} USES LEFT)`;
					mod_variable_set("skill", "effigyreroll", "cur_category", _c[_n]);
					text    = `REROLL THESE MUTATIONS#INTO ${_c[_n]} MUTATIONS`;
					mod_script_call("skill", skill, "skill_button");
					image_index = _n;
    			}
    		}
    	}
    }
    
    
     /* HORROR CROWN CRANIUM */
    with(instances_matching(LevCont, "hcc", null)) {
    	hcc = true;
	    var hnum = array_length(instances_matching(Player, "race", "horror"));
	    if(!instance_exists(CrownIcon) and !instance_exists(EGSkillIcon) and skill_get("crowncranium") and hnum) {
	    	with(LevCont) maxselect += hnum * skill_get("crowncranium");
	    	with(SkillIcon) {
	    		num += hnum;
	    		alarm0 = num + 1;
	    	}
	    	
	    	var ind = 0;
	    	repeat(hnum * skill_get("crowncranium")) {
	    		with(instance_create(0, 0, SkillIcon)){
					creator = other;
					num     = ind;
					alarm0	= num + 1;
					skill   = call(scr.skill_decide);
					name    = skill_get_name(skill);
					text    = skill_get_text(skill);
					if(is_string(skill)) mod_script_call("skill", skill, "skill_button");
					else {
						sprite_index = sprSkillIcon;
						image_index = skill;
					}
				}
				ind++;
	    	}
	    }
    }
    
    if(call(scr.save_get, mod_current, "cursed_mutations") and !instance_exists(EGSkillIcon) and array_length(instances_matching_ne(SkillIcon, "curseified", null)) = 0) {
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
					
					if(skill_get_active(skill) and call(scr.skill_get_avail, skill) and skill != mut_heavy_heart and ((_repent) or current_cursed())) {
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
	
#define end_step
	if(call(scr.save_get, mod_current, "metamorphosis_tips")) {
	     // tip moment
	    with(instances_matching(GenCont, "metamorphosistip", null)) {
	    	metamorphosistip = random(10);
	    	
	    	if(metamorphosistip < 1) {
	    		tip = tip_generate();
	    	}
	    }
    }
    
    with(instances_matching_ne(Player, "hastened", null)) {
        if(array_length(hastened)) {
            if(speed > 0 and (current_frame mod (current_time_scale * 2)) = 0) { 
				with(instance_create(x - (hspeed * 3) + orandom(3), y - (vspeed * 3) + orandom(3), BoltTrail)) {
					creator = other; 
					image_angle = other.direction;
				    image_yscale = 1.4;
				    image_xscale = other.speed * 4;
				}
			}
        }
        
        with(hastened) {
            duration -= current_time_scale;
            if(duration <= 0) {
				other.maxspeed -= increase;
		        other.reloadspeed -= increase;
				
				other.hastened = call(scr.array_delete, other.hastened, array_find_index(other.hastened, self));
				
				if(array_length(other.hastened) = 0) {
	                sound_play_pitch(sndLabsTubeBreak, 1.4 + random(0.2));
					sound_play_pitch(sndSwapGold, 0.8 + random(0.1));
				}
            }
        }
    }
    
    with(global.asleep) {
    	if(instance_exists(self)) {
	    	if(object_index != Van) alarm1 += current_time_scale;
	    	if("alrm1" in self) alrm1 += current_time_scale;
	    	
	    	metamorphosis_sleep -= current_time_scale;
	    	
	    	if(metamorphosis_sleep <= 0) {
				instance_create(x, y, AssassinNotice).depth = depth - 1;
				sound_play_pitchvol(sndImpWristHit, 1.4 + random(0.4), 1);
				sound_play_pitchvol(sndDragonStart, 2 + random(0.4), 0.4);
			}
			
			if(!instance_exists(self) or metamorphosis_sleep <= 0) {
				global.asleep = call(scr.array_delete_value, global.asleep, self);
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
								 global.asleep)) {
		var vis = 1;
		if(metamorphosis_sleep <= room_speed) vis = metamorphosis_sleep mod (4 * metamorphosis_sleep);
		
		draw_sprite_ext(global.sprSleep, 1, x + 6, y - 8 - (sprite_get_height(sprite_index)/2) + sin((metamorphosis_sleep + 20) * 0.1), 1, 1, sin((metamorphosis_sleep + 20) * 0.1) * 10, c_white, vis);
		
		draw_sprite_ext(global.sprSleep, 1, x, y - 4 - (sprite_get_height(sprite_index)/2) + sin((metamorphosis_sleep + 10) * 0.1), 1, 1, sin((metamorphosis_sleep + 10) * 0.1) * 10, c_white, vis);
		
		draw_sprite_ext(global.sprSleep, 1, x - 6, y - (sprite_get_height(sprite_index)/2) + sin(metamorphosis_sleep * 0.1), 1, 1, sin(metamorphosis_sleep * 0.1) * 10, c_white, vis);
	}
	
#define effigy_token_draw
	if(!global.libLoaded){exit;}
	with(instances_matching(CharSelect, "race", "effigy")) {
		var t = string(call(scr.save_get, mod_current, "effigy_tokens"));
		if(t) for(var i = 0; i < maxp; i++) {
			draw_set_visible_all(0);
			draw_set_visible(i, 1);
			if(player_is_active(i)) {
				var _x = view_xview[i] + xstart - 3,
					_y = view_yview[i] + ystart;
				
				draw_set_color(make_color_rgb(190, 253, 8));
				draw_roundrect(_x - 1, _y - 3, _x + (string_length(t) * 4) + 1, _y + 6, 0);
				draw_set_color(c_white);
				
				draw_set_font(fntSmall);
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
				draw_text_nt(_x + 1, _y, t);
				draw_set_font(fntM);
				
				draw_set_visible_all(1);
			}
		}
	}
	
	instance_destroy();

#define skill_effects
	with(SkillIcon) {
		if("counter" not in self){
			counter = 0;
		}
		if(counter <= num){
			counter++;
			continue;
		}
		
		var hover = 0;
		for(i = 0; i <= maxp; i++) {
			if(point_in_rectangle(mouse_x[i], mouse_y[i], x - (sprite_width/2), y - (sprite_height/2), x + floor(sprite_width/2), y + floor(sprite_height/2))) {
				hover = 1;
			}
		}
		
		if(mod_script_exists("skill", string(skill), "skill_cursed") and mod_script_call("skill", string(skill), "skill_cursed") = true) {
			var _x = x + sprite_xoffset;
			var _y = y + sprite_yoffset;
			
			draw_sprite(global.sprCursedOutline, (current_frame * (0.4/current_time_scale)) mod 4, x, y - hover);
			if(depth != -1002) depth = -1002;
			if(current_frame * (0.2/current_time_scale)) {
				with instance_create(x - 12 + 6 * ((current_frame * (0.2/current_time_scale)) mod 4), y - 16 - hover, Curse) {
					depth = other.depth;
				}
			}
		}
		
		if("sacrifice" in self) {
			draw_set_colour(make_color_rgb(68, 197, 22));
			draw_rectangle(x - 1 - (sprite_width/2), y - 1 - (sprite_height/2) - hover, x + (sprite_width/2), y + (sprite_height/2) - hover, 0);
			draw_set_color(c_white);
		}
	}
	
	instance_destroy();

#define draw_dark
	draw_set_color($808080);
	with(instances_matching(CustomProp, "name", "Shopkeep")) draw_circle(x, y, 30 + random(2), false);
	with(instances_matching(CustomProp, "name", "Mutator")) draw_circle(x, y, 60 + random(2), false);
	with(instances_matching(CustomHitme, "name", "FreakFriend")) draw_circle(x, y, 30 + random(2), false);
	if(array_length(instances_matching(CustomObject, "name", "CustomBeam"))) with(instances_matching(CustomObject, "name", "CustomBeam")) draw_custombeam(c_gray, 1, 1, 128 + sin(current_frame) * 3, false, true);

#define draw_dark_end
	draw_set_color($000000);
	with(instances_matching(CustomHitme, "name", "EffigyOrbital")) draw_circle(x, y, 10 + random(2), false);	
	with(instances_matching(CustomProp, "name", "Shopkeep")) draw_circle(x, y, 20 + random(2), false);	
	with(instances_matching(CustomProp, "name", "Mutator")) draw_circle(x, y, 40 + random(2), false);
	with(instances_matching(CustomHitme, "name", "FreakFriend")) draw_circle(x, y, 15 + random(2), false);
	if(array_length(instances_matching(CustomObject, "name", "CustomBeam"))) with(instances_matching(CustomObject, "name", "CustomBeam")) draw_custombeam(c_black, 1, 1, 48 + sin(current_frame) * 3, false, true);

#define draw_bloom
	with(instances_matching(CustomHitme, "name", "EffigyOrbital")) {
		var hp = (my_health/maxhealth);
		draw_sprite_ext(spr_glow, image_index, x, y, (image_xscale * 1.5) * right, image_yscale * 1.5, image_angle, image_blend, 0.2 * hp);
	}
	
	if(array_length(instances_matching(CustomObject, "name", "CustomBeam"))) with(instances_matching(CustomObject, "name", "CustomBeam")) draw_custombeam(image_blend, image_alpha * 0.1, 1.5);
	
	 // Blasting Caps:
	with(instances_matching(CustomSlash, "name", "BlastingCap")){
		draw_sprite_ext(sprite_index, image_index, x, y, 2 * image_xscale, 2 * image_yscale, image_angle, image_blend, 0.1 * image_alpha);
	}

#define cleanup
	with(global.begin_step) instance_destroy();

	with(instance_create(0, 0, CustomObject)){
		variable_instance_set(self, CONTROLLER, mod_current);
		persistent = true;
		
		beams = global.beams;
	}
	
	if (sprite_exists(global.mask)){
		sprite_delete(global.mask);
	}
	
 //				--- OBJECT SCRIPTS ---			//
#define AdrenalinePickup_create(_x, _y)
	with(call(scr.obj_create, _x, _y, "CrystallinePickup")){
		return self;
	}

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

#define BeamChild_create(_x, _y)
	with(instance_create(_x, _y, CustomSlash)){
		depth = object_get_depth(NothingBeam);
		sprite_index = global.mask;
		mask_index = global.mask;
		
		team = other.team;
		creator = other.creator;
		on_anim = script_ref_create(CustomBeam_anim);
		on_wall = script_ref_create(CustomBeam_wall);
		on_hit = script_ref_create(CustomBeam_hit);
		on_projectile = script_ref_create(CustomBeam_projectile);
		on_grenade = script_ref_create(CustomBeam_grenade);
		
		return self;
	}

#define BeamChild_draw
	if (global.debug_draw){
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	}

#define CheekPouch_create(_x, _y)
	with(call(scr.obj_create, _x, _y, "CrystallineEffect")){
		colors  = [make_color_rgb(54, 121, 255), make_color_rgb(0, 255, 255)];
		
		return self;
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

#define CrystallineEffect_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		 // Vars:
		scale	= 2;
		blink   = true;
		colors  = [make_color_rgb(173, 80, 185), make_color_rgb(250, 138, 0)];
		creator = noone;
		
		return self;
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

#define CrystallinePickup_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		 // Vars:
		mask_index = mskPickup;
		creator    = noone;
		num		   = 1;
		
		return self;
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
			crystallinegrowth = _duration;
			
			 // Effects:
			sleep(30);
			
			 // Player Effect:
			with(instances_matching(CrystallineEffect, "creator", id)){
				instance_destroy(); // prevent overlapping effects
			}
			with(call(scr.obj_create, x, y, "CrystallineEffect")){
				creator = other;
				time	= _duration;
			}
		}
	}

#define CustomBeam_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		depth = object_get_depth(NothingBeam);
		mask_index = global.mask;
		
		array_push(global.beams, self);
		
		sprite_index = sprNothingBeamStretch;
		sprite_start = sprNothingBeam;
		sprite_end = -1;
		sprite_particle = sprNothingBeamParticle;
		
		// false if the sprites go vertically (throne beam), true if they're horizontal (laser)
		transpose = false;
		
		// maximum distance for hitscan, alarm to activate hitscan
		// currently the alarm runs itself again every frame because it changes angle when its creator aims
		max_dist = 512;
		alarm0 = 1;
		
		// some weird timer I made that increases faster the longer it's there, subtracts from image_yscale
		existed = 0.01;
		
		team = ("team" in other ? other.team : id);
		creator = (instance_is(other, FireCont) && "creator" in other ? other.creator : other);
		
		// damage gets scaled by image_yscale / (sprite_index size / 2)
		damage = 2;
		
		// point array override, for when you want a shape or something instead of a hitscan beam
		points = [];
		
		// acts as [_x2, _y2] in bezier_curve if length of >= 2
		// use this to make the beam curve without specifying the points array
		control_point = [];
		curve_step = 0.2;
		
		// beam children, for more accurate hitboxes
		children = [];
		
		return self;
	}	

#define CustomBeam_begin_step
	if (!"texture_width" in self){
		exit;
	}
	
	var end_x = x + lengthdir_x(image_xscale, image_angle);
	var end_y = y + lengthdir_y(image_xscale, image_angle);
	
	var _points = points;
	var point_count = array_length(_points);
	
	children = instances_matching_ne(children, "id");
	
	if (point_count < 2){
		_points = [[x, y], [end_x, end_y]];
		
		if (array_length(control_point) >= 2){
			_points = bezier_curve(x, y, control_point[0], control_point[1], end_x, end_y, curve_step);
		}
		
		point_count = array_length(_points);
	}
	
	var child_count = array_length(children);
	
	if (child_count < point_count - 1){
		repeat(point_count - 1 - child_count){
			array_push(children, call(scr.obj_create, 0, 0, "BeamChild"));
		}
	}
	
	var _scale = image_yscale;
	var _extra = texture_width;
	var _damage = damage;
	
	for (var i = 0; point_count - 1 > i; i ++){
		var _child = children[i];
		var _point1 = _points[i];
		var _point2 = _points[i + 1];
		
		var _px1 = _point1[0];
		var _py1 = _point1[1];
		var _px2 = _point2[0];
		var _py2 = _point2[1];
		
		var _dir = point_direction(_px1, _py1, _px2, _py2);
		
		with(_child){
			image_yscale = _scale;
			image_angle = _dir;
			
			var _x = lengthdir_x(_extra, _dir);
			var _y = lengthdir_y(_extra, _dir);
			
			x = _px1 - _x * sign(i);
			y = _py1 - _y * sign(i);
			xprevious = x;
			yprevious = y;
			
			image_xscale = point_distance(x, y, _px2 + _x * sign(i), _py2 + _y * sign(i));
			damage = _damage * (_scale / (_extra / 4));
		}
	}

#define CustomBeam_step
	// adjust angle and position with creator
	if (instance_exists(creator)){
		if ("gunangle" in creator){
			direction += clamp(angle_difference(creator.gunangle, direction) * 0.1, -3, 3);
			direction = ((direction % 360) + 360) % 360;
			image_angle = direction;
		}
		
		x = creator.x;
		y = creator.y;
	}
	
	else{
		direction = current_frame % 360;
		image_angle = direction;
	}
	
	// remove sprite, multiply image_yscale to make collisions accurate, store texture
	if (!"last_texture" in self){
		texture = sprite_get_texture(sprite_index, floor(image_index));
		last_texture = texture;
		texture_width = (transpose ? sprite_height : sprite_width);
		image_yscale *= (texture_width / 4);
		sprite_index = -1;
		
		// particles
		// they seemed better with the random translation being half of below
		repeat(12){
			var _add = choose(-90, 90);
			var _pos = translate_rotate(x, y, random(image_yscale), 0, image_angle + _add);
			var beam_scale = max(2, image_yscale / (texture_width / 4));
			
			with(instance_create(_pos[0], _pos[1], NothingBeamParticle)){
				motion_add(other.image_angle + random(35) * sign(_add), 18);
				sprite_index = other.sprite_particle;
				image_angle = direction;
				image_xscale = beam_scale / 2;
				image_yscale = beam_scale / 2;
				depth = other.depth - 1;
			}
		}
		
		CustomBeam_begin_step();
	}
	
	// detect sprite changes
	if (sprite_index != -1){
		texture = sprite_get_texture(sprite_index, floor(image_index));
		texture_width = (transpose ? sprite_height : sprite_width);
		last_texture = texture;
		image_yscale *= (texture_width / 4);
		sprite_index = -1;
	}
	
	// if the user changes the texture instead, validate and use a default value when invalid
	if (texture != last_texture){
		if (texture_get_width(texture) <= 0 || texture_get_height(texture) <= 0){
			texture = sprite_get_texture(sprNothingBeamStretch, 0);
		}
		
		last_texture = texture;
	}
	
	var _scale = max(0, image_yscale - existed);
	
	if (random(2) < current_time_scale){
		var _pos = translate_rotate(x, y, random(image_yscale * 2), 0, choose(image_angle - 90, image_angle + 90));
		var beam_scale = max(2, image_yscale / (texture_width / 4));
		
		// more particles
		with(instance_create(_pos[0], _pos[1], NothingBeamParticle)){
			motion_add(other.image_angle, 18);
			sprite_index = other.sprite_particle;
			image_angle = direction;
			image_xscale = beam_scale / 2;
			image_yscale = beam_scale / 2;
			depth = other.depth - 1;
		}
	}
	
	// if beam really small, beam go bye
	if (image_yscale <= texture_width * 0.05){
		instance_destroy();
		exit;
	}
	
	// hitscan but it auto-repeats
	if (alarm0 && !--alarm0 && !--alarm0){
		CustomBeam_alrm0();
		
		alarm0 = 1;
		image_yscale = _scale;
		existed *= 1.03;
		
		exit;
	}

// binary-search hitscan
// see collision_line_first
#define CustomBeam_alrm0
	image_xscale = max_dist;
	
	var _yscale = image_yscale;
	image_yscale = min(_yscale, 2);
	
	if (place_meeting(x, y, Wall)){
		var _sx = lengthdir_x(image_xscale, image_angle);
		var _sy = lengthdir_y(image_xscale, image_angle);
		
		while (abs(_sx) >= 1 || abs(_sy) >= 1){
			_sx /= 2;
			_sy /= 2;
			
			if (place_meeting(x, y, Wall)){
				image_xscale -= point_distance(0, 0, _sx, _sy);
			}
			
			else{
				image_xscale += point_distance(0, 0, _sx, _sy);
			}
		}
	}
	
	image_yscale = _yscale;

// it's a slash, try not to get stuck on walls
#define CustomBeam_wall
	xprevious = x;
	yprevious = y;
	
	if (random(2) < current_time_scale && instance_is(other, Wall)){
		with(other){
			instance_create(x, y, FloorExplo);
			instance_destroy();
		}
	}

#define CustomBeam_hit
	if (projectile_canhit(other)){
		projectile_hit(other, damage);
	}
	
	// do some effects here so it looks better
#define CustomBeam_projectile
	if (other.team != team){
	    with(other) mod_script_call("skill", "selectivefocus", "selectivefocus_destroy");
	}
	
#define CustomBeam_grenade
	with(other) mod_script_call("skill", "selectivefocus", "selectivefocus_destroy");
	
#define CustomBeam_anim
	
	
#define CustomBeam_draw
	draw_custombeam();
	
#define CustomBeam_destroy
	var _index = array_find_index(global.beams, self);
	
	if (_index >= 0){
		var _new = array_slice(global.beams, 0, _index);
		array_copy(_new, _index, global.beams, _index + 1, array_length(global.beams) - (_index + 1));
		global.beams = _new;
	}
	
	with(instances_matching_ne(children, "id")){
		instance_delete(self);
	}

#define EffigyOrbital_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		 // Visual:
		spr_idle = mod_variable_get("race", "effigy", "sprOrbitalutility");
		spr_glow = mod_variable_get("race", "effigy", "sprOrbitalGlowutility");
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
		
		return self;
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
	if(instance_exists(creator)) {
		x = lerp(x, 
				 creator.x + lengthdir_x(16, (GameCont.timer * 2) + (360 * (index/array_length(creator.effigy_orbital)))), 
				 max(creator.speed/creator.maxspeed, 0.2) * current_time_scale);
		y = lerp(y, 
				 creator.y + lengthdir_y(16, (GameCont.timer * 2) + (360 * (index/array_length(creator.effigy_orbital)))), 
				 max(creator.speed/creator.maxspeed, 0.2) * current_time_scale);
		
		right = creator.right;
		
		switch(type) {
			case "offensive":
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
			
			case "defensive":
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
			
			case "ammo":
				with(creator) infammo = max(infammo, current_time_scale * 2);
			break;
			
			case "ultra":
				gunangle = creator.gunangle;
			
				if("beam" in self and instance_exists(beam)) with(beam) {
					var goalx = other.x + lengthdir_x(96, other.gunangle),
						goaly = other.y + lengthdir_y(96, other.gunangle),
						angdiff = angle_difference(point_direction(x, y, goalx, goaly),
												   point_direction(x, y, x + lengthdir_x(96, direction), y + lengthdir_y(96, direction)));
						ang = (array_length(control_point) ? 
						       min(abs(angdiff), 8) * sign(angdiff) : 
						       point_direction(x, y, goalx, goaly));
					control_point[0] = (array_length(control_point) ? other.x + lengthdir_x(96, direction + ang) : goalx);
					control_point[1] = (array_length(control_point) > 1 ? other.y + lengthdir_y(96, direction + ang) : goaly);
				}
			break;
			
			default:
				with(creator) haste(current_time_scale, 0.8);
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
		case "offensive":
			sound_play_pitch(sndHorrorEmpty, 0.7 + random(0.2));
			sound_play_pitch(sndUltraEmpty, 0.7 + random(0.2));
			sound_play_pitch(sndUltraGrenadeSuck, 1.4 + random(0.2));
		break;
		
		case "defensive":
			sound_play_pitch(sndHyperCrystalRelease, 0.8 + random(0.2));
			sound_play_pitchvol(sndMutant11Dead, 1.2 + random(0.2), 0.6);
			sound_play_pitch(sndEliteShielderTeleport, 1.6 + random(0.2));
		break;
		
		case "ammo":
			sound_play_pitch(sndFishWarrantEnd, 1.4 + random(0.4));
			sound_play_pitch(sndSwapShotgun, 0.5 + random(0.1));
			sound_play_pitch(sndFlamerStop, 0.4 + random(0.2));
		break;
		
		case "ultra":
			sound_play_pitchvol(sndBecomeNothingStartup, 0.4 + random(0.2), 0.6);
			sound_play_pitchvol(sndNothing2DeadStart, 0.4 + random(0.2), 0.6);
			
			if("beam" in self and instance_exists(beam)) with(beam) instance_destroy();
		break;
		
		default:
			sound_play_pitch(sndDogGuardianDead, 0.6 + random(0.2));
			sound_play_pitch(sndDiscDie, 0.8 + random(0.4));
			sound_play_pitch(sndChickenThrow, 0.6 + random(0.2));
			sound_play_pitch(sndDiscBounce, 1.2 + random(0.3));
		break;
	}
	
	
	with(creator) {
		effigy_orbital = call(scr.array_delete, effigy_orbital, index);
	}
	
	with(instances_matching_gt(instances_matching(CustomProp, "name", name), "index", index)) {
		index--;
	}

#define EffigyOrbital_draw
	var hp = (my_health/maxhealth);
	draw_sprite_ext(spr_idle, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha);
	draw_sprite_ext(spr_glow, image_index, x, y, image_xscale * right, image_yscale, image_angle, image_blend, image_alpha * hp);

#define FriendlyNecro_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		image_index = 1;
		image_speed = 0.4;
		sprite_index = global.sprFriendlyReviveCircle;
		mask_index = mskPlayer;
		image_xscale = 0.5;
		image_yscale = 0.5;
		
		return self;
	}

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
		with(call(scr.obj_create, x,y,"FreakFriend")){
			team = _t;
			creator = _c;
			
			with(instance_create(x, y, ReviveFX)) {
				sprite_index = global.sprFriendlyRevive;
				image_xscale = 0.5;
				image_yscale = 0.5;
				depth = other.depth - 1;
			}
		}
		
		sound_play_pitch(sndFreakPopoReviveArea, 1.5 + random(0.3));
		sound_play_pitch(sndNecromancerRevive, 1.7 + random(0.2));
		instance_destroy();
	}
	
	 // Secret.
	with(instances_meeting(x, y, Revive)) {
		with(instance_create(x, y, CustomHitme)) {
			my_health = 999;
			with(other) {
				var ind = p;
				event_perform(ev_collision, Player);
				if(fork()) {
					wait 0;
					with(instances_matching(Player, "index", p)) {
						if(race = "melting") race = "skeleton"; 
					}
					exit;
				}
				sound_play_pitch(sndUncurse, 0.8);
				sound_play(sndLevelUp);
				sound_play_pitch(sndSwapCursed, 0.7);
			}
			instance_destroy();
		}
	}

#define FreakFriend_create(_x, _y)
	with(instance_create(_x, _y, CustomHitme)){
		my_health = 12;
		while(place_meeting(x, y, Wall)){
			x = other.x+random(12)-6;
			y = other.y+random(12)-6;
		}
		image_speed = 0.4;
		walk = 0;
		walkspeed = 0.4;
		maxspeed = 3.5;
		
		spr_idle = global.sprFriendlyFreakIdle;
		spr_walk = global.sprFriendlyFreakWalk;
		spr_hurt = sprFreak1Hurt;
		spr_dead = sprFreak1Dead;
		spr_shadow = shd24;
		sprite_index = spr_idle;
		
		snd_hurt = sndFreakHurt;
		right = 1;
		alarm0 = 20 + irandom(10);
		
		return self;
	}

#define FreakFriend_step
	if(alarm0 && !--alarm0 && !--alarm0 && (script_ref_call(on_alrm0) || !instance_exists(self))) exit;
	if(!instance_exists(creator)) my_health = 0;
	
	 // Movement:
	if(walk > 0){
		walk -= current_time_scale;
		speed += walkspeed * current_time_scale;
	}
	
	if(speed > maxspeed){
		speed = maxspeed;
	}
	
	if place_meeting(x + hspeed, y + vspeed, Wall) move_bounce_solid(true);
	
	 // Animate:
	sprite_index = (sprite_index != spr_hurt || (image_index + image_speed >= image_number) || (image_index + image_speed < 0)) ? ((speed == 0) ? spr_idle : spr_walk) : sprite_index;
	
	enemy_face(direction);
	
	 // Handle enemies:
	with(instances_meeting(x, y, enemy)){
		if(projectile_canhit_melee(other) && "canmelee" in self && canmelee && meleedamage > 0){
			projectile_hit(other, meleedamage);
		}
		
		with(other){
			if(projectile_canhit_melee(other)){
				projectile_hit(other, 3);
				sound_play_pitch(sndFreakMelee, 1.2 + random(0.4));
			}
		}
	}
	
	 // Die:
	if(my_health <= 0) instance_destroy();

#define FreakFriend_alrm0
	alarm0 = 20 + irandom(10);
	
	var target = instance_nearest(x, y, enemy);
	if(!instance_exists(target) or point_distance(target.x, target.y, creator.x, creator.y) > 128) {
		target = creator;
	}
	
	else {
		alarm0 -= 5;
	}
	
	direction = point_direction(x, y, target.x, target.y);
	if(target.object_index != creator or point_distance(x, y, target.x, target.y) > 48) walk = alarm0;

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
	with(instance_create(x, y, Corpse)) {
		size = 1;
		sprite_index = other.spr_dead;
		image_xscale = other.right;
		speed = min((other.speed + max(0, -other.my_health / 5)) * (8 * skill_get(mut_impact_wrists)), 16);
		direction = other.direction;
	}
	
	sound_play(sndFreakDead);

#define MeatBlob_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
		my_health = 12;
		raddrop = 4;
		link = -4;
		sprite_index = global.sprMeatBlob;
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
		
		return self;
	}

#define MeatBlob_step
	if(!instance_exists(link)){raddrop = 0;instance_delete(self);exit;}
	
#define MeatBlob_death
	if(instance_exists(link)){instance_delete(link);}
	
#define Mutator_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
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
		
		prompt = call(scr.prompt_create, "+1 @gMUTATION@w#-2 @rMAX HP@s");
		with(prompt){
			mask_index = mskReviveArea;
			yoff = -4;
			hover = 0;
		}
		
		return self;
	}

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

#define MutRefresher_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
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
		
		prompt = call(scr.prompt_create, "RESELECT");
		with(prompt){
			mask_index = mskBandit;
			yoff       = -2;
		}
		
		return self;
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

#define MetaButton_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)) {
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
		setting = ["test", true];
		page = "test";
		
		on_click   = null;
		on_release = null;
		
		depth = -1002;
		
		return self;
	}

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
	call(scr.save_set, mod_current, string_replace(setting[0], " ", "_"), !setting[1]);
	setting[1] = call(scr.save_get, mod_current, string_replace(setting[0], " ", "_"));
	shift += 1;
	sound_play_pitch(sndClick, 1 + random(0.2));

#define MetaPage_click
	with(instances_matching(CustomObject, "name", "MetaButton", "MetaMut")) if(name != "MetaSettings") instance_destroy();

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
	
	//with(instances_matching(CustomObject, "name", "MetaSettings")) instance_destroy();

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
		
		page = 0;
		
		options_create();
		
		var skill_list = mod_get_names("skill");
		
		global.mutation_list = [];
		
		for(var m = 0; m < 29 + array_length(skill_list); m++) {
			if(m <= 29) array_push(global.mutation_list, string(m));
			else if(call(scr.skill_get_avail, skill_list[m - 30]) or mod_script_exists("skill", skill_list[m - 30], "skill_cursed")) array_push(global.mutation_list, skill_list[m - 30]);
		}
	}

	mod_variable_set("mod", "metamorphosis_options", "option_open", !options_open);

#define Shopkeep_create(_x, _y)
	with(instance_create(_x, _y, CustomProp)){
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
		team	   = 1; // Make sure they aren't killed by corrupted vaults
		
		var m = 0;
			
		var shopkeep_eligible = [],
			s = skill_get_at(m);
		
		prompt = noone;
		
		while(s != undefined) {
			if(call(scr.skill_get_avail, s, 1) and !array_length(instances_matching(instances_matching(CustomObject, "name", "OrchidSkill"), "skill", s))) {
				array_push(shopkeep_eligible, s);
			}
			m++;
			s = skill_get_at(m);
		}
		
		skill	   = array_length(shopkeep_eligible) ? shopkeep_eligible[irandom(array_length(shopkeep_eligible) - 1)] : mut_none;
		
		
		if(skill != mut_none or global.mut_quest = 1) {
			prompt = call(scr.prompt_create, 
						  global.mut_quest = 0 ?
						  `${metacolor}STORE@3(${call(scr.skill_get_icon, skill)[0]}:${call(scr.skill_get_icon, skill)[1]})?`
						  : "THANKS!#+1 FREE @gMUTATION");
			with(prompt){
				mask_index = mskReviveArea;
				yoff = -4;
				hover = 0;
			}
		}
		
		return self;
	}

#define Shopkeep_step
	if(instance_exists(prompt)) {
		if(prompt.nearwep != noone and prompt.hover = 0) {
			sound_play(global.mut_quest = skill and !skill_get(other.skill) ? snd.PotRemind : snd.PotPrompt);
			prompt.hover = 1;
		}
		
		if(player_is_active(prompt.pick)){
			if(global.mut_quest = 0) {
				skill_set(skill, 0);
				call(scr.save_set, mod_current, "proto_mutation", skill);
				var q = call(scr.save_get, mod_current, "quests_completed");
				call(scr.save_set, mod_current, "quests_completed", q = undefined ? 1 : (q + 1))
				var t = call(scr.save_get, mod_current, "effigy_tokens");
	    		call(scr.save_set, mod_current, "effigy_tokens", t = undefined ? 1 : min(t + 1, 99));
				
				if(!call(scr.save_get, mod_current, "effigy_unlocked")) {
	    			with(call(scr.unlock_splat, "MUTATION STORED", `EFFIGY UNLOCKED`, mod_variable_get("race", "effigy", "sprPortrait")[0], sndCharUnlock)) nam[1] = "EFFIGY";
	    			call(scr.save_set, mod_current, "effigy_unlocked", true);
	    		}
	    		else call(scr.unlock_splat, "MUTATION STORED", `+1 EFFIGY TOKEN`, -1, -1);
				
				global.mut_quest = 1;
				spr_idle = global.sprMerchantPuff;
				image_index = 0;
				sound_play_pitchvol(sndFlameCannonEnd, 1.5 + random(0.2), 0.4);
				sound_play(snd.PotConfirm);
				
				with(instance_create(prompt.pick.x, prompt.pick.y, PopupText)) {
					mytext = `COME BACK LATER!`;
				}
				
				with(prompt) {
					instance_destroy();
				}
			}
			
			else if(global.mut_quest = 1) {
				global.mut_quest = 2;
				with(GameCont) skillpoints++;
				
				spr_idle = global.sprMerchantPuff;
				image_index = 0;
				
				 // EFFECTS
				with(instance_create(prompt.pick.x, prompt.pick.y, PopupText)) {
					mytext = `LEVEL UP!`
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

	
  //				--- OTHER SCRIPTS ---			//
#define tip_generate
	var t = ["SYNERGY", "THIS IS THE RUN", "TRY SOMETHING NEW", `@sTHE VAULTS HAVE ${metacolor}VISITORS`, "FIND NEW COMBINATIONS", "THE META ISN'T EVERYTHING", `TRY WITH @w${choose("NT:TE", minicolor + "MINIMOD", "DEFPACK", "VAGABONDS", "VARIA ADDONS")}!`, "THE AMMO ECONOMY IS IN SHAMBLES", `@sEVERY MUTANT HAS A NEW ${metacolor}ULTRA`, "SPECIALIZE", "SOMETHING SPECIAL", "ADAPT", "PARTS OF A WHOLE", "SUM OF ALL THE PARTS", "COMBINATORIAL EXPLOSION", "HOW DID WE GET HERE?", "INNOVATE", "STRANGE ANATOMY", "THANKS FOR PLAYING!", "ADVANCED PHYSIOLOGY", "WE CAN BECOME BETTER", "BECOME STRONGER"];
	
	return metacolor + t[irandom(array_length(t) - 1)];

#define alight(_time)
	metamorphosis_ignited = "metamorphosis_ignited" in self ? metamorphosis_ignited + _time : _time;
	array_push(global.ignited, self);

#define haste(amt, pow)
	if(amt > 0 and pow > 0) {
		if("hastened" not in self) hastened = [];
		maxspeed += pow;
		reloadspeed += pow;
		array_push(hastened, {duration : amt, increase : pow});
		with(hastened[array_length(hastened) - 1]) {
		    return self;
		}
	}

#define fall_asleep(_time)
	metamorphosis_sleep = "metamorphosis_sleep" in self ? metamorphosis_sleep + _time : _time;
	array_push(global.asleep, self);

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

#define options_create
	var s = "",
		v = "";
	
	if(fork()) {
		wait 4;
		
		for(var i = 0; i < 7; i++) {
		    if(!options_open or array_length(instances_matching(instances_matching(CustomObject, "name", "MetaSettings"), "splat", 0)) > 0) exit;
		    s = global.option_list[i];
		    v = call(scr.save_get, mod_current, string_replace(s, " ", "_"));
		    
		    with(call(scr.obj_create, 0, 0, "MetaButton")) {
		    	setting = [s, v];
		    	index = array_length(instances_matching(CustomObject, "name", "MetaButton"));
		    	on_click = script_ref_create(MetaButton_click);
		    	right_off = 220;
		    	bottom_off = 10;
		    	shift = 2;
		    	sound_play_pitch(sndAppear, random_range(0.5, 1.5) + (index/10));
		    }
		    
		    if(array_length(instances_matching(CustomObject, "name", "MetaPage")) < 3 and i < 3) {
		    	with(call(scr.obj_create, 0, 0, "MetaButton")) {
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
		    v = call(scr.save_get, mod_current, `${string_replace(s, " ", "_")}_enabled`);
		    if(v = undefined) v = true;
		    
		    with(call(scr.obj_create, x, y, "MetaButton")) {
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
		    	spr_icon = call(scr.skill_get_icon, string_digits(s) != "" ? real(s) : s);
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
		    v = call(scr.save_get, mod_current, string_replace(s, " ", "_"));
		    if(v = undefined) v = 0;
		    
		    with(call(scr.obj_create, x, y, "MetaButton")) {
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
	
#define enemy_face(_dir)                                                                        _dir = ((_dir % 360) + 360) % 360; if(_dir < 90 || _dir > 270) right = 1; else if(_dir > 90 && _dir < 270) right = -1;


 // ALL OF THESE SHITS ARE FOR EFFIGY'S ULTRA C LASER
#define draw_custombeam
	/// draw_custombeam(_blend = image_blend, _alpha = image_alpha, _mul = 1, _add = 0, _texture = true, _round = false)
	var _blend = argument_count > 0 ? argument[0] : image_blend;
var _alpha = argument_count > 1 ? argument[1] : image_alpha;
var _mul = argument_count > 2 ? argument[2] : 1;
var _add = argument_count > 3 ? argument[3] : 0;
var _texture = argument_count > 4 ? argument[4] : true;
var _round = argument_count > 5 ? argument[5] : false;
	var _scale = image_yscale / (texture_width / 4) * _mul;
	var start_dist = (transpose ? sprite_get_width(sprite_start) : sprite_get_height(sprite_start)) * _scale;
	var end_dist = (transpose ? sprite_get_width(sprite_end) : sprite_get_height(sprite_end)) * _scale;
	
	// laser starts here
	// sprite_start gets drawn here
	// you need to adjust offsets for whatever sprite you choose
	// however, I tested with sprNothingBeam and sprNothingBeamStretch and it just works
	var visual_x = x + lengthdir_x(start_dist, image_angle);
	var visual_y = y + lengthdir_y(start_dist, image_angle);
	
	var transposed_angle = image_angle + (!transpose ? 90 : 0);
	
	if (!global.debug_draw){
		draw_sprite_ext(sprite_start, 0, visual_x, visual_y, _scale, _scale, transposed_angle, _blend, _alpha);
	}
	
	var _length = (global.debug_draw ? 0 : max(0, image_xscale - start_dist - end_dist));
	var beam_end_x = visual_x + lengthdir_x(_length, image_angle);
	var beam_end_y = visual_y + lengthdir_y(_length, image_angle);
	
	if (_length > 0){
		var _points = points;
		
		if (array_length(_points) >= 2){
			BeamShape_draw(_points, texture_width / 2, _add, _scale, _blend, _alpha, true, (_texture ? texture : null), transpose);
		}
		
		else{
			_points = [[visual_x, visual_y], [beam_end_x, beam_end_y]];
			
			if (array_length(control_point) >= 2){
				_points = bezier_curve(visual_x, visual_y, control_point[0], control_point[1], beam_end_x, beam_end_y, curve_step);
			}
			
			BeamShape_draw(_points, texture_width / 2, _add, _scale, _blend, _alpha, false, (_texture ? texture : null), transpose);
		}
		
		var point_count = array_length(_points);
		
		var second_to_last = _points[point_count - 2];
		var final_point = _points[point_count - 1];
		
		var _dir = point_direction(second_to_last[0], second_to_last[1], final_point[0], final_point[1]);
		
		beam_end_x = final_point[0] + lengthdir_x(end_dist, _dir);
		beam_end_y = final_point[1] + lengthdir_y(end_dist, _dir);
		
		transposed_angle = _dir + (!transpose ? 90 : 0);
		
		if (_round){
			for (var i = 0; point_count > i; i ++){
				var _point = _points[i];
				draw_circle_color(_point[0], _point[1], (texture_width / 2) * _scale + _add, _blend, _blend, false);
			}
		}
	}
	
	if (!global.debug_draw){
		draw_sprite_ext(sprite_end, 0, beam_end_x, beam_end_y, _scale, _scale, transposed_angle, _blend, _alpha);
	}

#define bezier_curve(_x1, _y1, _x2, _y2, _x3, _y3, _step)
	var _points = [];
	
	for (var i = 0; 1 >= i; i += _step){
		var _lx1 = lerp(_x1, _x2, i);
		var _ly1 = lerp(_y1, _y2, i);
		var _lx2 = lerp(_x2, _x3, i);
		var _ly2 = lerp(_y2, _y3, i);
		
		var _cx = lerp(_lx1, _lx2, i);
		var _cy = lerp(_ly1, _ly2, i);
		
		array_push(_points, [_cx, _cy]);
	}
	
	return _points;
	
	// draws lines of width _radius * 2 * _scale connected by _points
	// _points can be any length >= 2
	// ...
	// texture can be provided instead of drawing a solid line (_texture)
	// _transpose should be true if your sprite faces horizontally instead of vertically
#define BeamShape_draw
	/// BeamShape_draw(_points, _radius, _addr, _scale, _blend, _alpha, _loop = true, ?_texture = undefined, _transpose = false)
	var _points = argument[0], _radius = argument[1], _addr = argument[2], _scale = argument[3], _blend = argument[4], _alpha = argument[5];
var _loop = argument_count > 6 ? argument[6] : true;
var _texture = argument_count > 7 ? argument[7] : undefined;
var _transpose = argument_count > 8 ? argument[8] : false;
	var real_texture = (!is_undefined(_texture));
	
	if ((real_texture && (texture_get_width(_texture) <= 0 || texture_get_height(_texture) <= 0)) || !is_real(_radius)){
		return false;
	}
	
	var point_count = array_length(_points);
	
	if (point_count <= 0){
		return false;
	}
	
	if (real_texture){
		draw_primitive_begin_texture(pr_trianglestrip, _texture);
	}
	
	else{
		draw_primitive_begin(pr_trianglestrip);
	}
	
	var _uvs = (_transpose ? 
		[[0, 0],
		[0, 1]]
		:
		[[0, 0],
		[1, 0]]
	);
	
	var uv_left = _uvs[0];
	var uv_right = _uvs[1];
	
	var uv_x1 = uv_left[0];
	var uv_y1 = uv_left[1];
	var uv_x2 = uv_right[0];
	var uv_y2 = uv_right[1];
	
	var _max = (_loop ? point_count : point_count - 1);
	
	// >= because the shape should be closed
	for (var i = 0; _max >= i; i ++){
		var _point1 = _points[(((i - 1) % point_count) + point_count) % point_count];
		var _point2 = _points[((i % point_count) + point_count) % point_count];
		var _point3 = _points[(((i + 1) % point_count) + point_count) % point_count];
		
		var _px1 = _point1[0];
		var _py1 = _point1[1];
		var _px2 = _point2[0];
		var _py2 = _point2[1];
		var _px3 = _point3[0];
		var _py3 = _point3[1];
		
		// add _radius
		var _dir1 = point_direction(_px1, _py1, _px2, _py2);
		
		var _right1 = _dir1 + 90;
		var _left1 = _dir1 - 90;
		var _right2 = _dir2 + 90;
		var _left2 = _dir2 - 90;
		
		var _ox1 = lengthdir_x(_radius, _right1) * _scale + lengthdir_x(_addr, _right1);
		var _oy1 = lengthdir_y(_radius, _right1) * _scale + lengthdir_y(_addr, _right1);
		var _nx1 = lengthdir_x(_radius, _left1) * _scale + lengthdir_x(_addr, _left1);
		var _ny1 = lengthdir_y(_radius, _left1) * _scale + lengthdir_y(_addr, _left1);
		
		var _dir2 = point_direction(_px2, _py2, _px3, _py3);
		
		var _ox2 = lengthdir_x(_radius, _right2) * _scale + lengthdir_x(_addr, _right2);
		var _oy2 = lengthdir_y(_radius, _right2) * _scale + lengthdir_y(_addr, _right2);
		var _nx2 = lengthdir_x(_radius, _left2) * _scale + lengthdir_x(_addr, _left2);
		var _ny2 = lengthdir_y(_radius, _left2) * _scale + lengthdir_y(_addr, _left2);
		
		var _ii = [false];
		var _oi = [false];
		
		if (i){
			// calculate intersections so draws look nice and don't overlap (expensive?)
			_ii = line_segment_intersection(_px1 + _ox1, _py1 + _oy1, _px2 + _ox1, _py2 + _oy1, _px3 + _ox2, _py3 + _oy2, _px2 + _ox2, _py2 + _oy2);
			_oi = line_segment_intersection(_px1 + _nx1, _py1 + _ny1, _px2 + _nx1, _py2 + _ny1, _px3 + _nx2, _py3 + _ny2, _px2 + _nx2, _py2 + _ny2);
		}
		
		if (!_ii[0]){
			_ii = [false, _px2 + _ox1, _py2 + _oy1];
		}
		
		if (!_oi[0]){
			_oi = [false, _px2 + _nx1, _py2 + _ny1];
		}
		
		var _first = (i ? _ii : _oi);
		var _second = (i ? _oi : _ii);
		
		if (real_texture){
			draw_vertex_texture_color(_first[1], _first[2], uv_x1, uv_y1, _blend, _alpha);
			// draw_sprite_ext(sprPopoNade, 0, _first[1], _first[2], 1, 1, 0, c_black, 1);
			draw_vertex_texture_color(_second[1], _second[2], uv_x2, uv_y2, _blend, _alpha);
			// draw_sprite_ext(sprPopoNade, 0, _second[1], _second[2], 1, 1, 0, c_white, 1);
		}
		
		else{
			draw_vertex_color(_first[1], _first[2], _blend, _alpha);
			// draw_sprite_ext(sprPopoNade, 0, _first[1], _first[2], 1, 1, 0, c_black, 1);
			draw_vertex_color(_second[1], _second[2], _blend, _alpha);
			// draw_sprite_ext(sprPopoNade, 0, _second[1], _second[2], 1, 1, 0, c_white, 1);
		}
	}
	
	draw_primitive_end();
	
	return true;

// https://en.wikipedia.org/wiki/Line%E2%80%93line_intersection
#define line_intersection(_x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4)
	var _d = (_x1 - _x2) * (_y3 - _y4) - (_y1 - _y2) * (_x3 - _x4);
	
	if (_d == 0){
		return [false];
	}
	
	return [
		true,
		((_x1 * _y2 - _y1 * _x2) * (_x3 - _x4) - (_x1 - _x2) * (_x3 * _y4 - _y3 * _x4)) / _d,
		((_x1 * _y2 - _y1 * _x2) * (_y3 - _y4) - (_y1 - _y2) * (_x3 * _y4 - _y3 * _x4)) / _d
	];

#define line_segment_intersection(_x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4)
	var _d = (_x1 - _x2) * (_y3 - _y4) - (_y1 - _y2) * (_x3 - _x4);
	var _t = ((_x1 - _x3) * (_y3 - _y4) - (_y1 - _y3) * (_x3 - _x4)) / _d;
	var _u = ((_x2 - _x1) * (_y1 - _y3) - (_y2 - _y1) * (_x1 - _x3)) / _d;
	
	if (0 > _t || _t > 1 || 0 > _u || _u > 1){
		return [false];
	}
	
	return [
		true,
		(_x1 + _t * (_x2 - _x1)),
		(_y1 + _t * (_y2 - _y1))
	];

// https://yal.cc/2d-pivot-points/
#define translate_rotate(_x, _y, _xlength, _ylength, _dir)
	var new_x = _x + lengthdir_x(_xlength, _dir) + lengthdir_x(_ylength, _dir - 90);
	var new_y = _y + lengthdir_y(_xlength, _dir) + lengthdir_y(_ylength, _dir - 90);
	return [new_x, new_y];

#define deathtips_add
	if(mod_exists("mod", "deathtips")) {
		add_tip("race", "effigy", ["lamb to the slaughter", "wasted resources", "valuable intel", "be back soon"]);
	}
	
#define add_tip(tiptype, tipsource, tipoutput)
	return mod_script_call("mod", "deathtips", "add_tip", tiptype, tipsource, tipoutput);	
