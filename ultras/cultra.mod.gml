/// By Yokin
/// https://yokin.itch.io/custom-ultras

#define init
	global.bind_end_step = noone;
	
#define step
	 // Bind Events:
	if(!instance_exists(global.bind_end_step)){
		global.bind_end_step = script_bind_end_step(end_step, 0);
		with(global.bind_end_step){
			persistent = true;
		}
	}
	
	 // Spawning Custom Skill Mod Ultras:
	if(instance_exists(EGSkillIcon) && instance_exists(LevCont)){
		var _inst = instances_matching(LevCont, "custom_ultra", null);
		if(array_length(_inst)){
			var	_scrt      = "skill_ultra",
				_skillList = mod_get_names("skill"),
				_skillNum  = array_length(_skillList);
				
			with(_inst){
				custom_ultra = true;
				for(var i = 0; i < _skillNum; i++){
					var _skill = _skillList[i];
					if(mod_script_exists("skill", _skill, _scrt)){
						var _race = race_get_name(mod_script_call("skill", _skill, _scrt));
						if(array_length(instances_matching(EGSkillIcon, "race", _race)) > 0){
							var	_name = mod_script_call("skill", _skill, "skill_name"),
								_text = mod_script_call("skill", _skill, "skill_text");
								
							maxselect++;
							
							with(instance_create(0, 0, SkillIcon)){
								custom_ultra = other.custom_ultra;
								num          = other.maxselect;
								creator      = other;
								race         = _race;
								skill        = _skill;
								alarm0       = num;
								if(!is_undefined(_name)) name = _name;
								if(!is_undefined(_text)) text = _text;
								mod_script_call("skill", skill, "skill_button");
							}
						}
					}
				}
			}
		}
	}
	
#define end_step
	if(instance_exists(EGSkillIcon)){
		var _inst = instances_matching_ne(EGSkillIcon, "creator", noone);
		if(array_length(_inst)){
			var _pick = false;
			
			 // Check if Custom Ultra Was Picked:
			with(_inst){
				if(!instance_exists(creator)){
					_pick = true;
					instance_destroy();
				}
			}
			
			 // Leave Ultra Screen:
			if(_pick){
				if(instance_exists(LevCont)){
					var _raceList = [];
					
					 // Determine Ultra Order:
					for(var i = 0; i < maxp; i++){
						var _race = player_get_race(i);
						if(_race != "" && array_find_index(_raceList, _race) < 0){
							array_push(_raceList, _race);
						}
					}
					var _racePick = _raceList[
						(GameCont.endcount > 0 && GameCont.endcount < array_length(_raceList))
						? GameCont.endcount
						: 0
					];
					
					 // Fixes:
					GameCont.skillpoints++;
					if(GameCont.endskill == 0){
						GameCont.endskill = real(string(race_get_id(_racePick)) + string(ultra_count(_racePick) + 1));
					}
					
					 // Next Ultra:
					GameCont.ultra_post = true;
					GameCont.endcount++;
					if(GameCont.endcount >= array_length(_raceList)){
						GameCont.endpoints--;
					}
					
					 // Next Screen:
					with(mutbutton){
						instance_destroy();
					}
					with(LevCont){
						instance_destroy();
					}
					if(GameCont.skillpoints > 0){
						instance_create(0, 0, LevCont);
					}
					else if(GameCont.endpoints > 0){
						var _lastUltra = 0;
						
						 // Temporarily Give Ultra:
						for(var i = ultra_count(_racePick); i >= 1; i--){
							_lastUltra = ultra_get(_racePick, i);
							if(_lastUltra != 0){
								break;
							}
						}
						if(_lastUltra == 0){
							game_deactivate();
							ultra_set(_racePick, 1, 1);
						}
						
						 // Spawn Ultra Screen:
						instance_create(0, 0, LevCont);
						var _letterbox = game_letterbox;
						
						 // Reset Ultra:
						if(_lastUltra == 0){
							ultra_set(_racePick, 1, _lastUltra);
							game_activate();
							game_letterbox = _letterbox;
						}
					}
					else if(!instance_exists(GenCont)){
						instance_create(0, 0, GenCont);
					}
				}
				else if(!instance_exists(GenCont)){
					instance_create(0, 0, GenCont);
				}
			}
		}
	}
	
	 // Crash Prevention:
	if(instance_exists(SkillIcon)){
		var _inst = instances_matching_ne(instances_matching(SkillIcon, "custom_ultra", true), "creator", noone);
		if(array_length(_inst)) with(_inst){
			if(!instance_exists(creator)){
				instance_destroy();
				with(LevCont){
					maxselect--;
				}
			}
		}
	}
	
#define game_activate()
	/*
		Reactivates all instances and unpauses the game
	*/
	
	with(UberCont) with(self){
		event_perform(ev_alarm, 2);
	}
	
#define game_deactivate()
	/*
		Deactivates all objects, except GmlMods & most controllers
	*/
	
	with(UberCont) with(self){
		var	_lastIntro = opt_bossintros,
			_lastLoops = GameCont.loops,
			_player    = noone;
			
		 // Ensure Boss Intro Plays:
		opt_bossintros = true;
		GameCont.loops = 0;
		if(!instance_exists(Player)){
			_player = instance_create(0, 0, GameObject);
			with(_player){
				instance_change(Player, false);
			}
		}
		
		 // Call Boss Intro:
		with(instance_create(0, 0, GameObject)){
			instance_change(BanditBoss, false);
			with(self){
				event_perform(ev_alarm, 6);
			}
			sound_stop(sndBigBanditIntro);
			instance_delete(id);
		}
		
		 // Reset:
		alarm2         = -1;
		opt_bossintros = _lastIntro;
		GameCont.loops = _lastLoops;
		with(_player){
			instance_delete(id);
		}
		
		 // Unpause Game, Then Deactivate Objects:
		event_perform(ev_alarm, 2);
		event_perform(ev_draw, ev_draw_post);
	}