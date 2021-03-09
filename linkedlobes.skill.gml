#define init
	//global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	//global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);
	
	//first position is the name, others are the tags they set
	global.modifiers = [
		["Bouncy", "bouncer"],
		["Disc", "disc"],
		["Laser", "laser"],
		["Lightning", "lightning"],
		["Plasma", "plasma"],
		["Seeker", "seeker"],
		["Mini Grenade", "mininade"],
		["Ultra Grenade", "ultranade"],
		["Heavy Grenade", "heavynade"],
		["Toxic Grenade", "toxic", "nade"],
		["Blood Grenade", "bloodnade"],
		["Cluster Grenade", "cluster"],
		["Sticky Grenade", "stickynade"],
		["Grenade", "nade"],
		["Rocket", "rocket"],
		["Nuke", "nuke"],
		["Flare", "flare", "flame"],
		["Flame", "flame"],
		["Toxic", "Toxic"],
		["Flak", "flak"],
		["Hyper", "hyper"],
		["Ultra"],
		["Ultra Bow", "ultrabow"],
		["Flame", "flame"],
	];
	
#define skill_name    return "LINKED LOBES";
#define skill_text    return "@wMERGED WEAPONS@s HAVE AN#ADDITIONAL @wMODIFIER@s";
#define skill_tip     return "COALESCE";
//#define skill_icon    return global.sprSkillHUD;
//#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    if(array_length(instances_matching(mutbutton, "skill", mod_current)) > 0) sound_play(sndMut); //sound_mutation_play();
#define skill_avail   return mod_exists("mod", "telib");

#define step
	if(!mod_exists("mod", "telib")) {
		skill_set(mod_current, 0);
		if(instance_exists(GameCont)) GameCont.skillpoints++;
		exit;
	}
	with(instances_matching(WepPickup, "lobecheck", null)){
		lobecheck = 1;
		if(is_object(wep) && wep.wep == "merge" && "linkedlobe" not in wep){
			if("linkedlobe" not in wep){
				wep.linkedlobe = 1;
			}
			var modifier;
			var done = 0;
			while(!done){
				modifier = global.modifiers[irandom(array_length(global.modifiers)-1)];
				for(var i = 1; i < array_length(modifier); i++){
					if(lq_get(wep.base.proj, "nttemergeproj_" + modifier[i])){
						done = -1;
						break;
					}
				}
				done++;
			}
			//wep.linkedlobe += modifier[0];
			for(var i = 1; i < array_length(modifier); i++){
				lq_set(wep.base.proj, "nttemergeproj_" + modifier[i], null);
			}
		}
	}
	with(Player){
		if(is_object(wep) && wep.wep == "merge" && "linkedlobe" not in wep){
			if("linkedlobe" not in wep){
				wep.linkedlobe = 1;
			}
			var modifier;
			var done = 0;
			while(!done){
				modifier = global.modifiers[irandom(array_length(global.modifiers)-1)];
				for(var i = 1; i < array_length(modifier); i++){
					if(lq_get(wep.base.proj, "nttemergeproj_" + modifier[i])){
						done = -1;
						break;
					}
				}
				done++;
			}
			//wep.linkedlobe += modifier[0];
			for(var i = 1; i < array_length(modifier); i++){
				lq_set(wep.base.proj, "nttemergeproj_" + modifier[i], null);
			}
		}
	}