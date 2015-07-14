obj
	collectable_spawner
		var/obj/inventory/items/collectables/spawn_obj
		var obj/inventory/items/collectables/spawn_obj_ref
		var min_respawn_time=200
		var max_respawn_time=500
		herb_spawner
			icon='Herbs.dmi'
			icon_state="lemon grass"
			spawn_obj=/obj/inventory/items/collectables/herbs/lemon_grass
		New()
			..()
			spawn(0)spawn_obj()
		proc
			spawn_obj()
				spawn_obj_ref=new spawn_obj(src.loc)
				spawn_obj_ref.spawner_ref=src
			respawn_obj()
				spawn(rand(min_respawn_time,max_respawn_time))spawn_obj()