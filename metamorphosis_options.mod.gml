#define init
	 // LOGO //
	global.sprLogo = sprite_add("sprites/sprLogo.png", 1, 116, 12);
	
    global.settings = {
    	proto_mutation     : mut_none, // Figure out which mut is saved for proto mutations
    	use_proto          : true, // For the toggle to use the proto mutation on any given run
        shopkeeps		   : true, // Toggle vault shopkeepers
        evolution_unlocked : false, // Unlock the new crown. If you disable the vault shopkeepers, unlocking the crown is impossible without save editing
        allow_characters   : true, // Toggle the new characters
        cursed_mutations   : true, // Toggle whether or not cursed mutations show up
        custom_ultras      : true, // Toggle all custom ultras
        loop_mutations     : true, // Toggle gaining a mutation each loop past the first
        metamorphosis_tips : true // Toggle custom tips
    }
     // Remove reworked mutations here //
    lq_set(SETTING, "23_enabled", false);
    lq_set(SETTING, "28_enabled", false);
    
    metamorphosis_load();

	global.option_open = false;

#macro metacolor `@(color:${make_color_rgb(110, 140, 110)})`;
#macro options_open global.option_open
#macro options_avail instance_exists(Menu) and (Menu.mode = 1 or options_open)

#define step
	script_bind_draw(menu_draw, -1005); // you know the kind of lazy where you do the harder thing because getting everything ready to do the easy thing seems too hard? that is what this script is the culmination of
	
	if(options_open) {
		for(var i = 0; i < maxp; i++){
			with(BackFromCharSelect){
				if(position_meeting((mouse_x[i] - (view_xview[i] + xstart)) + x, (mouse_y[i] - (view_yview[i] + ystart)) + y, self)){
					if(button_pressed(i, "fire")){
						with(Menu) {
							mode = 0;
							event_perform(ev_step, ev_step_end);
							sound_volume(sndMenuCharSelect, 1);
							sound_stop(sndMenuCharSelect);
							with(CharSelect) alarm0 = 2;
						}
				        sound_play(sndClickBack);
				        with(instances_matching(CustomObject, "name", "MetaButton")) {
				        	instance_destroy();
				        }
				        
				        options_open = !options_open;
				        
						break;
					}
				}
			}
			
			if(button_pressed(i, "spec")) {
				with(Menu) {
					mode = 0;
					event_perform(ev_step, ev_step_end);
					sound_volume(sndMenuCharSelect, 1);
					sound_stop(sndMenuCharSelect);
					with(CharSelect) alarm0 = 2;
				}
		        sound_play(sndClickBack);
		        with(instances_matching(CustomObject, "name", "MetaButton", "MetaPage")) {
		        	instance_destroy();
		        }
		        
		        
				options_open = !options_open;
			}
		}
	}

#define menu_draw
	if(options_open) {
		var _color = draw_get_color();
		var _alpha = draw_get_alpha();
		
		draw_set_color(c_black);
		draw_set_alpha(0.75);
		
		draw_rectangle(view_xview_nonsync + 0, view_yview_nonsync + 0, view_xview_nonsync + game_width, view_yview_nonsync + game_height, false);
		
		draw_set_color(_color);
		draw_set_alpha(_alpha);
	}

	if(options_avail) {
		for(var i = 0; i < maxp; i++) {
			draw_set_visible_all(0);
			draw_set_visible(i, 1);
			
			if(player_is_active(i)) {
				var _x = 0,
					_y = 0;
				
				if(options_open) {
					with(instances_matching(CustomObject, "name", "MetaSettings")) {
						_x    = view_xview[i] + game_width;
						_y    = view_yview[i] + game_height - 26;
							
						draw_sprite_ext(sprCharSplat, splat, _x, _y, -1, 1, 0, c_black, 1);
						
						_x	  = view_xview[i] + (game_width/2);
						_y    = view_yview[i] + 30;
						
						draw_sprite(global.sprLogo, 0, _x, _y + splat);
					}
					
					with(instances_matching_gt(instances_matching(CustomObject, "name", "MetaButton"), "splat", 0)) {
						_x = view_xview[i] + (game_width/2) - 105;
						_y = view_yview[i] + (game_height/2) - 70 + (16 * index);
						
						draw_sprite(sprMainMenuSplat, splat, _x + 52, _y + 3);
					}
					
					with(instances_matching(CustomObject, "name", "MetaButton")) {
						_x = view_xview[i] + (game_width/2) - 105;
						_y = view_yview[i] + (game_height/2) - 70 + (16 * index);
						var text = "@s",
							opt = setting[1];
						
						option_vars(i, _x, _y);
						
						if(hover) {
							text += "@w";
						}
						
						text += setting[0];
						
						if(array_length(instances_matching(instances_matching(CustomObject, "name", "MetaSettings"), "page", 0))) opt = `${hover ? "@w" : "@s"}${opt = true ? "ON" : "OFF"}`;
						
						draw_set_halign(fa_left);
						draw_set_valign(fa_top);
						draw_text_nt(_x + splat, _y + shift, string_upper(text));
						
						draw_text_nt(_x + 200, _y + shift, string_upper(string(opt)));
					}
					
					with(instances_matching(CustomObject, "name", "MetaPage")) {
						_x = view_xview[i] + game_width - 6;
						_y = view_yview[i] + game_height - 42 + (12 * index);
						var text = "@d";
						
						option_vars(i, _x, _y);
						
						if(array_length(instances_matching(instances_matching(CustomObject, "name", "MetaSettings"), "page", index)) > 0) {
							text += "@w";
						} else if(hover) {
							text += "@s";
						}
						
						text += page;
						
						draw_set_halign(fa_right);
						draw_set_valign(fa_top);
						draw_text_nt(_x - splat, _y + shift, text);
						draw_set_halign(fa_left);
					}
					
					with(instances_matching(CustomObject, "name", "MetaMut")) {
						_x = view_xview[i] + 60 + (18 * (index mod num));
						_y = view_yview[i] + 60 + (18 * (index div num));
						
						option_vars(i, _x, _y);
						
						if(hover) {
							var xx = view_xview[i],
								yy = view_yview[i] + game_height - 26,
								s = string_replace(setting[0], "_enabled", ""),
								d = skill_get_text(string_digits(s) != "" ? real(s) : s);
						
							draw_sprite(sprCharSplat, splat, xx, yy);
							draw_text_nt(xx + 5, yy - 28 + splat + shift, skill_get_name(string_digits(s) != "" ? real(s) : s) + `#  @(color:${setting[1] ? c_dkgray : c_maroon})(${setting[1] ? "ENABLED" : "DISABLED"})`);
						
							
							if(d = "") {
								if(s = "5") d = "UPGRADES YOUR SPECIAL ABILITY";
								else if(s = "crowncranium") d = "UPGRADES YOUR PASSIVE ABILITY";
								else d = "VARIES";
							}
							
							draw_set_font(fntSmall);
							draw_text_nt(xx + 5 + splat, yy - 2, d);
							draw_set_font(fntM);
						}
						
						draw_sprite_ext(spr_icon[0], spr_icon[1], _x, _y + shift - (splat * 0.5), 1, 1, 0, hover ? (setting[1] ? c_white : c_red) : (setting[1] ? c_gray : c_maroon), 1);
					}
				}
				
				else if(SETTING.proto_mutation != mut_none) {
					with(instances_matching(CustomObject, "name", "MetaProto")) {
						_x    = view_xview[i] + game_width + 12;
						_y    = view_yview[i] + (game_height/2) - 10;
						
						option_vars(i, _x, _y);
						
						if(array_length(instances_matching(Loadout, "selected", 1)) = 0 or splat > 0) {
							draw_sprite_ext(sprGameOverCenterSplat, min(splat, 2), _x, _y, 1, 1, 90, c_white, 1);
							draw_sprite_ext(spr[0], spr[1], _x - 17 - splat - hover, _y - 5 - shift, 1, 1, 0, hover ? (setting[1] ? c_white : c_gray) : (setting[1] ? c_gray : c_dkgray), 1);
							draw_sprite(sprToggle, setting[1], _x - 19 - splat - hover, _y + 5 - shift);
						}
					}
				}
				
				with(instances_matching_gt(instances_matching(CustomObject, "name", "MetaButton", "MetaProto"), "hover", 0)) {
					var text = "";
					
					switch(setting[0]) {
						case "shopkeeps": text = `TOGGLE THE ${metacolor}VAULT VISITORS@w`; break;
						case "allow characters": text = "TOGGLE NEW CHARACTERS BEING PLAYABLE"; break;
						case "cursed mutations": text = "TOGGLE CURSED MUTATIONS"; break;
						case "custom ultras": text = "TOGGLE ALL CUSTOM ULTRAS#@d(AFFECTS OTHER MODS AS WELL)@w"; break;
						case "loop mutations": text = "TOGGLE GAINING FREE MUTATIONS#FOR EVERY LOOP PAST 1"; break;
						case "metamorphosis tips": text = `TOGGLE ${metacolor}THESE TIPS@w`; break;
						case "vault visits": text = "AMOUNT OF TIMES YOU'VE#VISITED THE CROWN VAULTS"; break;
						case "distance evolved": text = `HIGHEST AMOUNT OF AREAS VISITED#WITH THE ${metacolor}CROWN OF EVOLUTION@w`; break;
						case "quests completed": text = `AMOUNT OF TIMES#YOU'VE ${metacolor}STORED MUTATIONS@w`; break;
						case "times loaded": text = `AMOUNT OF TIMES YOU'VE LOADED THIS MOD#${metacolor}THANKS!@w :)`; break;
						case "use_proto": text = `${metacolor}${skill_get_name(SETTING.proto_mutation)}`; break;
					}
					
					if(text != "") draw_tooltip(mouse_x[i], mouse_y[i] - 6, text);
				}
				
				with(instances_matching(CustomObject, "name", "MetaSettings")) {
					_x    = view_xview[i] + 30;
					_y    = view_yview[i] + game_height - 6;
					var text  = "@g+";
					
					option_vars(i, _x, _y);
					
					if(options_open) {
						text = "@g-";
					}
					
					if(!hover) {
						text += "@w";
					}
					
					draw_set_font(fntSmall);
					draw_set_halign(fa_left);
					draw_set_valign(fa_top);
					draw_text_nt(_x, _y, `[${text}SETTINGS@w]`);
					draw_set_font(fntM);
				}
			}
			
			draw_set_visible_all(1);
		}
	}
	
	instance_destroy();

#define option_vars(index, drawx, drawy)
	if(visible) {
		if(array_length(mouse_in_rectangle(index, drawx - left_off, drawy - top_off, drawx + right_off, drawy + bottom_off, 0)) > 0) {
			if(button_pressed(index, "fire")) {
				click = 1;
				script_ref_call(on_click);
			}
			
			else click = 0;
			
			if(!lq_get(p_hover, `p${index}`)) sound_play(sndHover);
			lq_set(p_hover, `p${index}`, 1);
		}
		
		else {
			lq_set(p_hover, `p${index}`, 0);
		}
	}

#define mouse_in_rectangle(_p, _x1, _y1, _x2, _y2, _gui)
	 // Stolen from Squiddy's options API
	var _x = _x1;
	var _y = _y1;
	
	_x1 = min(_x, _x2);
	_y1 = min(_y, _y2);
	_x2 = max(_x, _x2);
	_y2 = max(_y, _y2);
	
	var _players = [];
	
	if (_p >= 0 && maxp > p){
		if (player_is_active(_p)){
			var _mx = mouse_x[_p] - (_gui ? view_xview[_p] : 0);
			var _my = mouse_y[_p] - (_gui ? view_yview[_p] : 0);
			
			if (_mx >= _x1 && _my >= _y1 && _mx <= _x2 && _my <= _y2){
				array_push(_players, _p);
			}
		}
	}
	
	else{
		for (var p = 0; maxp > p; p ++){
			if (player_is_active(p)){
				var _mx = mouse_x[p] - (_gui ? view_xview[p] : 0);
				var _my = mouse_y[p] - (_gui ? view_yview[p] : 0);
				
				if (_mx >= _x1 && _my >= _y1 && _mx <= _x2 && _my <= _y2){
					array_push(_players, p);
				}
			}
		}
	}
	
	return _players;

#define metamorphosis_load
    if(fork()) {
        var f = "metamorphosis.txt",
            s = "";
        wait file_load(f);
        if(file_exists(f)) {
            s = string_split(string_load(f), chr(10));
            for(i = 0; i < array_length(s); i++) {
                if(string_count("//", s[i]) = 0 and string_length(s[i]) > 0) {
                    s[@i] = string_replace(s[i], chr(13), "");
					s[@i] = string_replace(s[i], chr(9), "");
					s[@i] = string_split(s[i], ":");
					
					if(string_digits(s[i][1]) != "") lq_set(SETTING, s[i][0], real(s[i][1]));
					else if(s[i][1] = "false")		 lq_set(SETTING, s[i][0], 0); 
					else if(s[i][1] = "true")		 lq_set(SETTING, s[i][0], 1);
					else							 lq_set(SETTING, s[i][0], s[i][1]);
                }
            }
        }
        
        file_unload(f);
        metamorphosis_save();
        exit;
    }

#define metamorphosis_save
    if(fork()) {
        var f = "metamorphosis.txt",
            s = "// welcome to da metamorphosis save. most of this code is from sanisani go check out Wasteland Vagabonds mod" + chr(10),
            k = "", // key
            v = ""; // value
        wait file_load(f);
		for(var i = 0; i < lq_size(SETTING); i++) {
		    k = lq_get_key(SETTING, i);
		    v = lq_get_value(SETTING, i);
		    
		    s += chr(9) + string(k) + ":" + string(v) + chr(10);
		}
		
		string_save(s, f);
		file_unload(f);
		exit;
    }

#macro SETTING global.settings