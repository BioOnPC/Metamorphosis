#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1, 12, 16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",  1,  8,  8);

#define skill_name    return "ATOMIC PORES";
#define skill_text    return "@wENEMIES@s DROP MORE @gRADS#HIGHER @gRAD CAPACITY";
#define skill_tip     return "PUS FILLED";
#define skill_icon    return global.sprSkillHUD;
#define skill_button  sprite_index = global.sprSkillIcon;
#define skill_take    sound_play(sndMut); //sound_mutation_play();

#define step
    with(instances_matching(enemy, "atomicrads", null)) { // Find all unaffected enemies
        atomicrads = 1;
        raddrop += ceil(raddrop * (0.10 * skill_get("atomicpores"))); // Increase rads
    }

    with(instances_matching(instances_matching(GameCont, "level", 10), "atomicrads", null)) { // Check to see if the rad capacity was increased
    	atomicrads = 1;
    	radmaxextra += 200;
    }

     // VFX
    with(instances_matching_le(enemy, "my_health", 0)) {
    	repeat(sprite_get_width(sprite_index)/12) {
	    	with(instance_create(x + random_range(-sprite_get_width(sprite_index)/2, sprite_get_width(sprite_index)/2),
	    					     y + random_range(-sprite_get_width(sprite_index)/2, sprite_get_width(sprite_index)/2),
	    					     ScorpionBulletHit)) { // I KNOW THIS LOOKS WEIRD BUT ITS EASIER TO READ
	    		image_speed = 0.3;
			}
    	}
    }

#define sound_mutation_play()
	sound_play(sndMut);
	with instance_create(0, 0, CustomObject){
		lifetime = 0;
		stage = 0;
		pitch = 1;
		on_step = sound_step
		on_destroy = sound_destroy
	}

#define sound_step
	lifetime += current_time_scale;
	if lifetime >= 4 && stage = 0{
		stage++;
		sound_play_pitchvol(sndRadPickup, .9, 2)
		sound_play_pitchvol(sndRadMaggotDie, 1, 1.5)
	}if lifetime >= 6 && stage = 1{
		stage++;
		sound_play_pitchvol(sndRadMaggotDie, .95, 2)
	}if lifetime >= 8 && stage = 2{
		sound_play_pitchvol(sndScorpionHit, 1.05, .8)
		stage++;
		sound_play_pitchvol(sndRadPickup, 1, 2)
		sound_play_pitchvol(sndScorpionDie, 1,  .8)
	}if lifetime >= 10 && stage = 3{
		stage++;
		sound_play_pitchvol(sndRadPickup, 1.025, 2)
		sound_play_pitchvol(sndRadMaggotDie, 1.1, 1.5)
		sound_play(sndLevelUp)
	}if lifetime >= 12 && stage = 4{
		stage++;
	}if lifetime >= 14 && stage = 5{
		stage++;
		sound_play_pitchvol(sndRadPickup, 1.075, 2)
	}if lifetime >= 17 && stage = 6{
		stage++;
		sound_play_pitchvol(sndRadPickup, 1.1, 2)
		audio_sound_set_track_position(sndMutant4Spch, 14.2)
		sound_play_pitchvol(sndMutant4Spch, 1.2, .5)
	}if lifetime >= 20 && stage = 7{
		stage++;
		sound_play_pitchvol(sndRadPickup, 1.15, 2)
	}if lifetime >= 23 && stage = 8{
		stage++;
		sound_play_pitchvol(sndRadPickup, 1.2, 2)
	}if lifetime >= 27 && stage = 9{
		stage++;
		sound_play_pitchvol(sndRadPickup, 1.25, 2)
	}if lifetime >= 33 && stage = 10{
		stage++;
		sound_play_pitchvol(sndRadPickup, 1.35, 2)
	}if lifetime >= 40 && stage = 11{
		stage++;
		sound_play_pitchvol(sndRadPickup, 1.5, 2)
	}

	if lifetime >= 52 instance_destroy()

#define sound_destroy
	sound_stop(sndMutant4Spch)
	audio_sound_set_track_position(sndMutant4Spch, 1)
