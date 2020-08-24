#define init
	global.sprSkillIcon = sprite_add("sprites/Icons/sprSkill" + string_upper(string(mod_current)) + "Icon.png", 1,   12,  16);
	global.sprSkillHUD  = sprite_add("sprites/HUD/sprSkill" + string_upper(string(mod_current)) + "HUD.png",	 1,   8,   8);
	
	 // Projectile Effect Sprites:
	var p = "sprites/VFX/Selective Focus/";
	global.sprEnemyBullet1Delete	  = sprite_add(p + "sprEnemyBullet1Delete.png",			4,	8,	8);
	global.sprScorpionBulletDelete	  = sprite_add(p + "sprScorpionBulletDelete.png",		4,	8,	8);
	global.sprEBullet3Delete		  = sprite_add(p + "sprEBullet3Delete.png",				4,	8,	8);
	global.sprEnemyBullet4Delete	  = sprite_add(p + "sprEnemyBullet4Delete.png",			5,  10, 10);
	
	global.sprGuardianBulletDelete    = sprite_add(p + "sprGuardianBulletDelete.png",		5,	8,	8);
	global.sprBigGuardianBulletDelete = sprite_add(p + "sprBigGuardianBulletDelete.png",	6,	16,	16);
	
	global.sprIDPDBulletDelete		  = sprite_add(p + "sprIDPDBulletDelete.png",			4,  8,	8);
	global.sprLastBallDelete		  = sprite_add(p + "sprLastBallDelete.png",				6,	16,	16);
	
	global.sprEFlakDelete			  = sprite_add(p + "sprEFlakDelete.png",				5,	8,	8);
	global.sprFireBallDelete		  = sprite_add(p + "sprFireBallDelete.png",				5,	8,	8);
	
	 // Storing Data of Dead Enemies:
	global.enemyData = [];

#define skill_name    return "SELECTIVE FOCUS";
#define skill_text    return "@wKILLING ENEMIES @sDESTROYS @rBULLETS#@sFEWER ENEMY BULLETS";
#define skill_tip     return choose("NO MORE DISTRACIONS", "THE TASK AT HAND", "OUT OF SIGHT OUT OF MIND");
#define skill_icon    return global.sprSkillHUD;

#define skill_button  
	sprite_index = global.sprSkillIcon;
	
#define step
	script_bind_end_step(end_step, 0);
	
	 // Mark Bullets For Deletion:
	with(global.enemyData){
		if(!instance_exists(id)){
			var _projectiles = instances_matching(projectile, "creator", id);
			
			 // Find Projectiles Created On Death:
			with(
				instances_matching(
					instances_matching(
						instances_matching(
							projectile,
							"creator",
							noone
						),
						"xstart",
						x
					),
					"ystart",
					y
				)
			){
				array_push(_projectiles, id);
			}
			
			with(_projectiles){
				selectivefocus_destroy_time = random(8);
			}
		}
	}
	
	 // Decrement Timer and Delete Bullets:
	with(instances_matching_gt(projectile, "selectivefocus_destroy_time", 0)){
		selectivefocus_destroy_time -= current_time_scale;
		if(selectivefocus_destroy_time <= 0){
			selectivefocus_destroy();
		}
	}
	
	 // Store Data of Dead Enemies:
	var _enemyData = [],
		_enemyList = instances_matching_le(enemy, "my_health", 0);
		
	 // Weird Cases:
	with(instances_matching(FrogQueenDie, "", null)){
		array_push(_enemyList, id);
	}
		
	with(_enemyList){
		array_push(
			_enemyData,
			{
				id : id,
				x  : x,
				y  : y
			}
		);
	}
	global.enemyData = _enemyData;
	
#define end_step
	 // Fewer Enemy Bullets:
	with(instances_matching(projectile, "selectivefocus_initial_destroy", null)){
		selectivefocus_initial_destroy = 0;
		
		if(instance_is(creator, enemy) || (!instance_exists(creator) && team == 1)){
			if(random(power(5, 1 / skill_get(mod_current))) < 1){
				selectivefocus_destroy();
			}
		}
	}
	
	 // Goodbye:
	instance_destroy();
	
#define selectivefocus_destroy
	if(!instance_is(id, EnemyLaser) && !instance_is(id, EnemyLightning)){
		var s = null;
		
		 // Mod Support:
		if("spr_selectivefocus" in other){
			s = other.spr_selectivefocus;
		}
		else{
			
			 // Vanilla Sprites:
			switch(sprite_index){
				 // General:
				case sprEnemyBullet1:			s = global.sprEnemyBullet1Delete;			break;
				case sprScorpionBullet:			s = global.sprScorpionBulletDelete;			break;
				case sprEBullet3:				s = global.sprEBullet3Delete;				break;
				case sprEnemyBullet4:			s = global.sprEnemyBullet4Delete;			break;
				
				 // Guardians:
				case sprExploGuardianBullet:	s = sprScorpionBulletHit;					break;
				case sprGuardianBulletSpawn:
				case sprGuardianBullet:			s = global.sprGuardianBulletDelete;				break;
				case sprBigGuardianBulletSpawn:
				case sprBigGuardianBullet:		
				case sprThrone2Bullet:			s = global.sprBigGuardianBulletDelete;		break;
				
				 // IDPD:
				case sprIDPDBullet:				s = global.sprIDPDBulletDelete;				break;
				case sprPopoSlug:				s = sprPopoSlugDisappear;					break;
				case sprPopoPlasma:				s = sprIDPDBulletHit;						break;
				case sprLastBall:				s = global.sprLastBallDelete;				break;
				case sprPopoRocket:				s = sprPopoRocket;							break;
				case sprPopoNade:				s = sprPopoNade;							break;
				
				 // Misc:
				case sprEFlak:					s = global.sprEFlakDelete;					break;
				case sprFireBall:				s = global.sprFireBallDelete;				break;
				case sprJockRocket:				s = sprJockRocket;							break;
				case sprGoldRocket:				s = sprGoldRocket;							break;
			}
		}
		
		if(!is_undefined(s)){	
			with(instance_create(x, y, BulletHit)){
				sprite_index = s;
				image_speed  = random_range(0.6, 1);
				direction    = other.direction;
				image_angle  = other.image_angle;
				speed		 = other.speed / 3;
			}
		}
		
		with(instance_create(x, y, Dust)){
			sprite_index = sprSmoke;
			direction	 = other.direction;
			speed		 = other.speed;
		}
		
		 // Goodbye:
		instance_delete(id);
	}

