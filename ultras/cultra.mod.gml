/// By Yokin
/// https://yokin.itch.io/custom-ultras

#define step
    if(instance_exists(EGSkillIcon)){
        with(instances_matching(LevCont, "custom_ultra", null)){
            if(!player_is_active(GameCont.endcount)){
                instance_destroy();
                break;
            }
            custom_ultra = true;

            maxselect = -1;
            with(mutbutton) instance_destroy();

             // Manually Place Ultras:
            with(LevCont){
                var _race = player_get_race(GameCont.endcount);
                for(var i = 1; i <= ultra_count(_race) + (_race == "skeleton"); i++){
                    with(instance_create(0, 0, EGSkillIcon)){
                        num = instance_number(mutbutton) - 1;
                        race = _race;
                        skill = i;
                        name = ultra_get_name(_race, i);
                        text = ultra_get_text(_race, i);
                        result = real(`${race_get_id(_race)}${i}`);
                        creator = other;
                        alarm0 = num + 1;
                        ultra_button(_race, i);
                    }
                    maxselect++;
                }
            }

             // Custom Skill Mod Ultras:
            var _mod = mod_get_names("skill"),
                _scrt = "skill_ultra";

            for(var i = 0; i < array_length(_mod); i++){
                var _skill = _mod[i],
                    _race = race_get_name(mod_script_call("skill", _skill, _scrt));

                if(array_length(instances_matching(EGSkillIcon, "race", _race)) > 0){
                    var _num = instance_number(mutbutton),
                        _name = mod_script_call("skill", _skill, "skill_name"),
                        _text = mod_script_call("skill", _skill, "skill_text");

                    with(instance_create(0, 0, SkillIcon)){
                        num = _num;
                        race = _race;
                        skill = _skill;
                        if(!is_undefined(_name)) name = _name;
                        if(!is_undefined(_text)) text = _text;
                        creator = other;
                        alarm0 = num;
                        mod_script_call("skill", skill, "skill_button");
                    }
                    maxselect++;
                }
            }
        }
    }
    script_bind_end_step(end_step, 0);

#define end_step
    if(instance_exists(EGSkillIcon)){
        var _end = 0;
        with(instances_matching_ne(EGSkillIcon, "creator", noone)){
            if(!instance_exists(creator)){
                _end = 1;
                instance_destroy();
            }
        }

         // Leave Ultra Screen:
        if(_end){
            if(instance_exists(LevCont)){
                GameCont.endcount++;
                GameCont.skillpoints++;
    
                 // No More Players Need Ultras:
                if(!player_is_active(GameCont.endcount)){
                    GameCont.endpoints--;
                }
    
                 // Next Screen:
                with(mutbutton) instance_destroy();
                with(LevCont) instance_destroy();
                if(GameCont.skillpoints > 0 || GameCont.endpoints > 0){
                    instance_create(0, 0, LevCont);
                }
                else instance_create(0, 0, GenCont);
            }
            else if(!instance_exists(GenCont)){
                instance_create(0, 0, GenCont);
            }
        }
    }
    else with(instances_matching_ne(SkillIcon, "creator", noone)){
        if(!instance_exists(creator)) instance_destroy();
    }
    instance_destroy();

#define ultra_get_name(_race, _index)
    var _raceIndex = race_get_id(_race);
    if(_raceIndex <= 16){
        var _def = {
             "0:1" : "BLOOD BOND",
             "0:2" : "GUN BOND",
             "0:3" : "EXTRA LEVEL",
             "1:1" : "CONFISCATE",
             "1:2" : "GUN WARRANT",
             "2:1" : "FORTRESS",
             "2:2" : "JUGGERNAUT",
             "3:1" : "PROJECTILE STYLE",
             "3:2" : "MONSTER STYLE",
             "4:1" : "BRAIN CAPACITY",
             "4:2" : "DETACHMENT",
             "5:1" : "TRAPPER",
             "5:2" : "KILLER",
             "6:1" : "IMA GUN GOD",
             "6:2" : "BACK 2 BIZNIZ",
             "7:1" : "AMBIDEXTROUS",
             "7:2" : "GET LOADED",
             "8:1" : "REFINED TASTE",
             "8:2" : "REGURGITATE",
             "9:1" : "HARDER TO KILL",
             "9:2" : "DETERMINATION",
            "10:1" : "PERSONAL GUARD",
            "10:2" : "RIOT",
            "11:1" : "STALKER",
            "11:2" : "ANOMALY",
            "11:3" : "MELTDOWN",
            "12:1" : "SUPER PORTAL STRIKE",
            "12:2" : "SUPER BLAST ARMOR",
            "13:1" : "ULTRA SPIN",
            "13:2" : "ULTRA MISSILES",
            "14:1" : "REDEMPTION",
            "14:2" : "DAMNATION",
            "15:1" : "DISTANCE",
            "15:2" : "INTIMACY",
            "16:1" : "GAME GOD",
            "16:2" : "CAR GOD"
        }
    
        return loc(`${_raceIndex}:Ultra:${_index}:Name`, lq_defget(_def, `${_raceIndex}:${_index}`, ""));
    }

     // Custom Race:
    else{
        if(mod_script_exists("race", _race, "race_ultra_name")){
            return mod_script_call("race", _race, "race_ultra_name", _index);
        }
        return "";
    }

#define ultra_get_text(_race, _index)
    var _raceIndex = race_get_id(_race);
    if(_raceIndex <= 16){
        var _def = {
             "0:1" : "HP PICKUPS ARE SHARED",
             "0:2" : "AMMO PICKUPS ARE SHARED",
             "0:3" : "BECAUSE SOMEONE FORGOT#TO DEFINE ULTRA MUTATION(S)",
             "1:1" : "@wENEMIES@s SOMETIMES DROP @wCHESTS@s",
             "1:2" : "@yINFINITE AMMO@s THE FIRST 7 SECONDS#AFTER EXITING A @pPORTAL@s",
             "2:1" : "+6 MAX @rHP@s",
             "2:2" : "MOVE WHILE @wSHIELDED@s",
             "3:1" : "@wTELEKINESIS@s HOLDS YOUR @wPROJECTILES@s",
             "3:2" : "PUSH NEARBY @wENEMIES@s AWAY#WHEN NOT USING @wTELEKINESIS@s",
             "4:1" : "BLOW UP @rLOW HP @wENEMIES@s",
             "4:2" : "3 MORE @gMUTATIONS@s#LOSE HALF OF YOUR @rHP@s",
             "5:1" : "BIG @wSNARE@s",
             "5:2" : "@wENEMIES@s KILLED ON YOUR @wSNARE@s#SPAWN @wSAPLINGS@s",
             "6:1" : "HIGHER @wRATE OF FIRE@s",
             "6:2" : "FREE @wPOP POP@s UPGRADE",
             "7:1" : "DOUBLE @wWEAPONS@s FROM @wCHESTS@s",
             "7:2" : "@yAMMO CHESTS@s CONTAIN ALL @yAMMO TYPES@s",
             "8:1" : "HIGH TIER @wWEAPONS@s ONLY#AUTO EAT @wWEAPONS@s LEFT BEHIND",
             "8:2" : "EATING @wWEAPONS@s CAN DROP @wCHESTS@s#AUTO EAT @wWEAPONS@s LEFT BEHIND",
             "9:1" : "KILLS EXTEND BLEED TIME",
             "9:2" : "THROWN @wWEAPONS@s CAN TELEPORT BACK#TO YOUR SECONDARY SLOT",
            "10:1" : "START A LEVEL WITH 2 @wALLIES@s#ALL @wALLIES@s HAVE MORE @rHP@s",
            "10:2" : "DOUBLE @wALLY@s SPAWNS",
            "11:1" : "@wENEMIES@s EXPLODE IN @gRADIATION@s ON DEATH",
            "11:2" : "@pPORTALS@s APPEAR EARLIER",
            "11:3" : "DOUBLE @gRAD@s CAPACITY",
            "12:1" : "DOUBLE @bPORTAL STRIKE@s PICKUPS#AND CAPACITY",
            "12:2" : "SUPER BLAST ARMOR",
            "13:1" : "IMPROVED SPIN ATTACK",
            "13:2" : "MISSILES FIRE BULLETS",
            "14:1" : "BACK IN THE FLESH",
            "14:2" : "FAST RELOAD AFTER BLOOD GAMBLE",
            "15:1" : "RADS CAN SPAWN TOXIC GAS",
            "15:2" : "CONTINUOUSLY SPAWN TOXIC GAS",
            "16:1" : "PLAY HARD",
            "16:2" : "FAST LYFE"
        }
    
        return loc(`${_raceIndex}:Ultra:${_index}:Text`, lq_defget(_def, `${_raceIndex}:${_index}`, ""));
    }

     // Custom Race:
    else{
        if(mod_script_exists("race", _race, "race_ultra_text")){
            return mod_script_call("race", _race, "race_ultra_text", _index);
        }
        return "";
    }

#define ultra_button(_race, _index)
    sprite_index = sprEGSkillIcon;
    image_index = image_number - 1;

    var _raceIndex = race_get_id(_race);
    if(_raceIndex <= 16){
        image_index = ((_raceIndex - 1) * 3) + (_index - 1);
    }

     // Custom Race:
    else mod_script_call("race", _race, "race_ultra_button", _index);