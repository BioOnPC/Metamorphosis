#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "DISPLACEMENT";
#define skill_text    return "@pSPLIT YOURSELF IN TWO@s";
#define skill_tip     return choose("THIS CAN'T BE RIGHT", "TWO OF THEM");
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut); //sound_mutation_play();
#define skill_avail   return false;
#define skill_cursed  return true; // for metamorphosis

#define step
	with(Player){
		if("diswep" not in self) {
			diswep = wep;
			disbwep = bwep;
			disang = gunangle;
			disbang = bwepangle;
			disx = x;
			disy = y;
			
			my_health = ceil(my_health/2);
			maxhealth = ceil(maxhealth/2);
		}
		
		var prevwep = wep,
			prevbwep = bwep,
			prevang = gunangle,
			prevbang = bwepangle,
			prevx = x,
			prevy = y,
			auto = (race == "steroids" and weapon_get_auto(wep) >= 0) or weapon_get_auto(wep), // THIS WHOLE SHIT'S STOLEN FROM YOKIN, LET IT BE KNOWN
			prevfire = (can_shoot && canfire && (auto ? button_check(index, "fire") : (clicked || button_pressed(index, "fire"))) && (ammo[weapon_get_type(wep)] >= weapon_get_cost(wep) || infammo != 0)),
			prevbfire = (race == "steroids" && bcan_shoot && canspec && (auto ? button_check(index, "spec") : button_pressed(index, "spec")) && (ammo[weapon_get_type(bwep)] >= weapon_get_cost(bwep) || infammo != 0));
		
		if(fork()) {
			wait 30;
			
			if(instance_exists(self)) {
				 // Update all variables
				diswep = prevwep;
				disbwep = prevbwep;
				disang = prevang;
				disbang = prevbang;
				disx = prevx;
				disy = prevy;
				
				infammo += 1;
			    
			    if(prevfire) {
			        player_fire_ext_real(disang, diswep, disbwep, disx, disy, false);
			    }
			    
			    if(prevbfire){
			    	player_fire_ext_real(disang, diswep, disbwep, disx, disy, true);
			    }
			    
			    infammo -= 1;
			}
		}
	}
	
#define player_fire_ext_real(_ang, _wep, _bwep, _x, _y, offhand)
	with(instance_create(_x, _y,FireCont)){ // thank you gepsilon for letting me use your code
		owner = other;
		wep = _wep;
		maxspeed = owner.maxspeed;
		team = owner.team;
		accuracy = owner.accuracy;
		curse = owner.curse;
		ammo = owner.ammo;
		prevammo = owner.ammo;
		maxhealth = owner.maxhealth;
		my_health = owner.my_health;
		lsthealth = owner.lsthealth;
		reloadspeed = owner.reloadspeed;
		othervariables();
		index = owner.index;
		gunangle = _ang;
		creator = ("creator" in owner ? owner.creator : owner);
		specfiring = 0;
		reload = owner.reload;
		familiar = 1;
		wepflip = owner.wepflip;
		bwep = _bwep;
		b = bwep;
		var _wep = is_object(wep) ? wep.wep : wep;
		if(is_string(_wep) && mod_script_exists("weapon", _wep, "step")){
			mod_script_call("weapon", _wep, "step", 1);
		}
		var firewep = (offhand ? bwep : wep);
		player_fire_ext(gunangle, firewep, x, y, team, self);
		if(instance_exists(other)){
			if(is_real(bwep) && bwep == 0 && (!is_real(b) || b != 0)){
				other.wep = other.bwep;
				other.bwep = 0;
			}else if(is_real(wep) && wep == 0){
				other.wep = other.bwep;
				other.bwep = 0;
			}
		}
		time = current_time;
	}
	
#define othervariables()
if("owner" not in self){
	var owner = instance_nearest(x,y,Player);
}
footstep = owner.footstep;chickencorpse = owner.chickencorpse;frogcharge = owner.frogcharge;rogueammo = owner.rogueammo;canspec = owner.canspec;notoxic = owner.notoxic;spr_sit1 = owner.spr_sit1;horrornorad = owner.horrornorad;snd_hurt = owner.snd_hurt;swapmove = owner.swapmove;spr_idle = owner.spr_idle;spr_hurt = owner.spr_hurt;snd_cptn = owner.snd_cptn;bleed = owner.bleed;typ_amax = owner.typ_amax;sprite_angle = owner.sprite_angle;wkick = owner.wkick;spr_dead = owner.spr_dead;snd_spch = owner.snd_spch;joyx = owner.joyx;can_shoot = owner.can_shoot;gunshine = owner.gunshine;nearwep = owner.nearwep;roll = owner.roll;snd_dead = owner.snd_dead;joyaimx = owner.joyaimx;horrorstopsnd = owner.horrorstopsnd;hammering = owner.hammering;infammo = owner.infammo;wepflip = owner.wepflip;p = owner.p;race = owner.race;snd_lowa = owner.snd_lowa;spr_walk = owner.spr_walk;canswap = owner.canswap;interfacepop = owner.interfacepop;bwep = owner.bwep;hammerhead = owner.hammerhead;canwalk = owner.canwalk;drawlowhp = owner.drawlowhp;spr_shadow_y = owner.spr_shadow_y;lasthit = owner.lasthit;alias = owner.alias;clicked = owner.clicked;bwepangle = owner.bwepangle;snd_chst = owner.snd_chst;canspirit = owner.canspirit;snd_thrn = owner.snd_thrn;wave = owner.wave;spiriteffect = owner.spiriteffect;chickendeaths = owner.chickendeaths;canaim = owner.canaim;canscope = owner.canscope;usespec = owner.usespec;smoke = owner.smoke;wepangle = owner.wepangle;stream_submit = owner.stream_submit;canrogue = owner.canrogue;dogammo = owner.dogammo;size = owner.size;wepright = owner.wepright;bwepflip = owner.bwepflip;safeheadloss = owner.safeheadloss;prepareScoreGet = owner.prepareScoreGet;drawemptyb = owner.drawemptyb;joyaimy = owner.joyaimy;candie = owner.candie;binterfacepop = owner.binterfacepop;showhp = owner.showhp;canpick = owner.canpick;spr_sit2 = owner.spr_sit2;snd_crwn = owner.snd_crwn;turn = owner.turn;bcan_shoot = owner.bcan_shoot;breload = owner.breload;joyy = owner.joyy;typ_name = owner.typ_name;back = owner.back;snd_idpd = owner.snd_idpd;bwkick = owner.bwkick;footextra = owner.footextra;bskin = owner.bskin;spr_fire = owner.spr_fire;raddrop = owner.raddrop;snd_valt = owner.snd_valt;bcurse = owner.bcurse;footkind = owner.footkind;drawempty = owner.drawempty;boilcap = owner.boilcap;typ_ammo = owner.typ_ammo;right = owner.right;horrorcharge = owner.horrorcharge;race_id = owner.race_id;spr_shadow_x = owner.spr_shadow_x;snd_lowh = owner.snd_lowh;angle = owner.angle;nexthurt = owner.nexthurt;canfire = owner.canfire;canfeet = owner.canfeet;snd_wrld = owner.snd_wrld;spr_shadow = owner.spr_shadow;index = owner.index;