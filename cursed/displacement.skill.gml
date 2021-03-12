#define init
	global.sprSkillIcon = sprite_add("../sprites/Icons/Cursed/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("../sprites/HUD/Cursed/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#macro cursecolor `@(color:${make_color_rgb(136, 36, 174)})`

#define skill_name    return cursecolor + "DISPLACEMENT";
#define skill_text    return "@dSPLIT YOURSELF IN TWO@s";
#define skill_tip     return choose("THIS CAN'T BE RIGHT", "TWO OF THEM");
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    
	sound_play(sndMut); //sound_mutation_play();
	with(Player) {
		my_health = ceil(my_health/2);
		maxhealth = ceil(maxhealth/2);
	}
	
#define skill_avail   return false;
#define skill_cursed  return true; // for metamorphosis
#define skill_lose
	with(Player) {
		maxhealth *= 2;
		my_health *= 2;
	}


#define step
	script_bind_draw(displacement_draw, -4);

	with(Player){
		if("diswep" not in self) {
			diswep = wep;
			disbwep = bwep;
			disang = gunangle;
			disbang = bwepangle;
			diswepa = wepangle;
			diskick = wkick;
			disbkick = bwkick;
			disflip = wepflip;
			disbflip = bwepflip;
			dissprite = sprite_index;
			disindex = image_index;
			disright = right;
			disx = x;
			disy = y;
		}
		
		var prevwep = wep,
			prevbwep = bwep,
			prevang = gunangle,
			prevbang = bwepangle,
			prevwepa = wepangle,
			prevflip = wepflip,
			prevbflip = bwepflip,
			prevkick = wkick,
			prevbkick = bwkick,
			prevright = right,
			prevsprite = sprite_index,
			previndex = image_index,
			prevx = x,
			prevy = y,
			auto = (race == "steroids" and weapon_get_auto(wep) >= 0) or weapon_get_auto(wep), // THIS WHOLE SHIT'S STOLEN FROM YOKIN, LET IT BE KNOWN
			prevfire = (can_shoot && canfire && (auto ? button_check(index, "fire") : (clicked || button_pressed(index, "fire"))) && (ammo[weapon_get_type(wep)] >= weapon_get_cost(wep) || infammo != 0)),
			prevbfire = (race == "steroids" && bcan_shoot && canspec && (auto ? button_check(index, "spec") : button_pressed(index, "spec")) && (ammo[weapon_get_type(bwep)] >= weapon_get_cost(bwep) || infammo != 0));
		
		if(fork()) {
			wait 30;
			
			if(instance_exists(self) and !instance_exists(LevCont) and !instance_exists(GenCont)) {
				 // Update all variables
				diswep = prevwep;
				disbwep = prevbwep;
				disang = prevang;
				disbang = prevbang;
				diswepa = prevwepa;
				diskick = prevkick;
				disbkick = prevbkick;
				disflip = prevflip;
				disbflip = prevbflip;
				disright = prevright;
				dissprite = prevsprite;
				disindex = previndex;
				disx = prevx;
				disy = prevy;
				
				infammo += 1;
			    
			    if(prevfire) {
			        player_fire_ext_real(disang, diswep, disbwep, disx, disy, false);
			        repeat(6) {
				        with(instance_create(disx, disy, Smoke)) {
				        	motion_add(other.disang + (random_range(20, -20) * other.accuracy), random_range(2, 4));
				        	image_xscale = 0.4;
				        	image_yscale = 0.4;
				        	image_alpha = 0.4;
				        }
			        }
			    }
			    
			    if(prevbfire){
			    	player_fire_ext_real(disbang, diswep, disbwep, disx, disy, true);
			    }
			    
			    infammo -= 1;
			}
		}
	}

#define displacement_draw
	with(instances_matching_ne(Player, "diswep", null)) {
		draw_set_fog(true, c_black, 0, 0);
		
		var a = 0.4,
			sx = disx + (sin(current_frame/8) * 5),
			sy = disy + (sin((current_frame)/16) * 5);
		
		if(disbwep != 0){
	        var f = ((weapon_get_type(disbwep) == 0) ? disbflip : disright);
	
	         // Dual Wielding:
	        if(race == "steroids") draw_weapon(weapon_get_sprite(disbwep), sx, sy - (image_yscale * 4), image_yscale * disang, image_yscale * disbang, disbkick, sign(-image_yscale) * f, 0, a);
	
	         // Back Weapon:
	        else draw_sprite_ext(weapon_get_sprite(disbwep), 0, sx - (disright * 2), sy, 1, f, 90 + (15 * disright), 0, a);
	    }
	
	     // Self & Wep:
	    draw_weapon(weapon_get_sprite(diswep), sx, sy, disang, diswepa, diskick, image_yscale * ((weapon_get_type(diswep) == 0) ? disflip : disright), 0, a);
	    draw_sprite_ext(dissprite, disindex, sx, sy, image_xscale * disright, image_yscale, image_angle, 0, a);
	    
	    draw_set_fog(false, c_white, 0, 0);
	}
	
	instance_destroy();

#define draw_weapon(_sprite, _x, _y, _ang, _meleeAng, _wkick, _flip, _blend, _alpha)
	draw_sprite_ext(_sprite, 0, _x - lengthdir_x(_wkick, _ang), _y - lengthdir_y(_wkick, _ang), 1, _flip, _ang + (_meleeAng * (1 - (_wkick / 20))), _blend, _alpha);
	
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