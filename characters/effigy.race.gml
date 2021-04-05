#define init

#macro metacolor `@(color:${make_color_rgb(110, 140, 110)})`;
#macro SETTING mod_variable_get("mod", "metamorphosis_options", "settings")

#define race_name              return "EFFIGY";
#define race_text              return "START WITH ???";
#define race_lock              return `${metacolor}STORE MUTATIONS`;
#define race_unlock            return `FOR ${metacolor}STORING MUTATIONS`;
//#define race_tb_text           return "@wPICKUPS @sGIVE @rFEATHERS@s";
//#define race_portrait(_p, _b)  return race_sprite_raw("Portrait", _b);
//#define race_mapicon(_p, _b)   return race_sprite_raw("Map",      _b);
#define race_avail             return lq_get(SETTING, "effigy_unlocked");