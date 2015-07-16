var/gibberish={"There is a place where the sidewalk ends
And before the street begins,
And there the grass grows soft and white,
And there the sun burns crimson bright,
And there the moon-bird rests from his flight
To cool in the peppermint wind.

Let us leave this place where the smoke blows black
And the dark street winds and bends.
Past the pits where the asphalt flowers grow
We shall walk with a walk that is measured and slow,
And watch where the chalk-white arrows go
To the place where the sidewalk ends.

Yes we'll walk with a walk that is measured and slow,
And we'll go where the chalk-white arrows go,
For the children, they mark, and the children, they know
The place where the sidewalk ends. "}
mob
	verb
		save()
			set category=null
			if(src.logged)
				src.test_save()
				alert("Save successful","Save Game")
			else
				alert("Save unsuccessful","Save Game")
	proc
		save_resources()
			var/savefile/F=new(client.Import())
			if(F)
				F["[pc("rsc")]"]<<(src.wood+src.clay+src.stone+src.ore)
				F["[pc("wood")]"]<<src.wood
				F["[pc("clay")]"]<<src.clay
				F["[pc("stone")]"]<<src.stone
				F["[pc("ore")]"]<<src.ore
			client.Export(F)
		set_name2()
			var/A=input("name")as text
			usr.name=A
		test_save()
			var/savefile/F=new("Players/[src.ckey]")
			src.export_values(F)
			//client.Export(F)
		test_load()
			//var/loca=src.loc
			var/savefile/F=new("Players/[src.ckey]")
			if(F)
				if(src.compare_values(F))
					src.import_values(F)
				else
					alert(src,"Save file is corrupt or outdated","Error")
					return 0
			//	src.loc=loca
				return 1
			else
				alert(src,"Save file not found","Error")
			return 0
	proc
		pc(var/t="")
			return md5(md5(t))
		compare_values(var/savefile/F)
			var/mob/M=new/mob()
			M.import_values(F)
			var/A
			var/B
			F["[pc("hash1")]"]>>A
			F["[pc("hash2")]"]>>B
			if(pc(M.name)!=A)
				del M
				return 0
			if((M.level+M.exp+M.max_exp+M.str+M.str_exp+M.str_max_exp+M.int+M.int_exp+M.int_max_exp+M.agi+M.agi_exp+M.agi_max_exp+M.wil+M.wil_exp+M.wil_max_exp+M.end+M.end_exp+M.end_max_exp)!=B)
				del M
				return 0

			var/C
			F["[pc("rsc")]"]>>C
			if(C!=(M.wood+M.clay+M.stone+M.ore))
				del M
				return 0
			del M
			return 1
		import_values(var/savefile/F)
			F["[pc("name")]"]>>src.name
			F["[pc("lx")]"]>>src.x
			F["[pc("ly")]"]>>src.y
			F["[pc("lz")]"]>>src.z
			F["[pc("hair")]"]>>src.hair
			F["[pc("haircolor")]"]>>src.hair_color
			F["[pc("class")]"]>>src.class
			var/list/L=list()
			F["[pc("contents")]"]>>L
			contents=L
		//	F["[pc(location"]>>src.loc
			F["[pc("icon")]"]>>src.icon
			F["[pc("overlays")]"]>>src.overlays
			F["[pc("wood")]"]>>src.wood
			F["[pc("clay")]"]>>src.clay
			F["[pc("stone")]"]>>src.stone
			F["[pc("ore")]"]>>src.ore

			F["[pc("level")]"]>>src.level
			F["[pc("exp")]"]>>src.exp
			F["[pc("max_exp")]"]>>src.max_exp

			F["[pc("str")]"]>>src.str
			F["[pc("str_exp")]"]>>src.str_exp
			F["[pc("str_max_exp")]"]>>src.str_max_exp

			F["[pc("int")]"]>>src.int
			F["[pc("int_exp")]"]>>src.int_exp
			F["[pc("int_max_exp")]"]>>src.int_max_exp

			F["[pc("agi")]"]>>src.agi
			F["[pc("agi_exp")]"]>>src.agi_exp
			F["[pc("agi_max_exp")]"]>>src.agi_max_exp

			F["[pc("wil")]"]>>src.wil
			F["[pc("wil_exp")]"]>>src.wil_exp
			F["[pc("wil_max_exp")]"]>>src.wil_max_exp

			F["[pc("end")]"]>>src.end
			F["[pc("end_exp")]"]>>src.end_exp
			F["[pc("end_max_exp")]"]>>src.end_max_exp






			F["[pc("death_time")]"]>>src.death_time



		export_values(var/savefile/F)
			F["[md5("pure_gibberish")]"]<<"[gibberish][gibberish][gibberish]"
			F["[pc("hash1")]"]<<pc(src.name)
			F["[pc("name")]"]<<src.name
			F["[pc("lx")]"]<<src.x
			F["[pc("ly")]"]<<src.y
			F["[pc("lz")]"]<<src.z
			F["[pc("hair")]"]<<src.hair
			F["[pc("haircolor")]"]<<src.hair_color
			F["[pc("contents")]"]<<src.contents
			F["[pc("class")]"]<<src.class
		//	F["[pc(location"]>>src.loc
			F["[pc("icon")]"]<<src.icon
			F["[pc("overlays")]"]<<src.overlays

			F["[pc("rsc")]"]<<(src.wood+src.clay+src.stone+src.ore)
			F["[pc("wood")]"]<<src.wood
			F["[pc("clay")]"]<<src.clay
			F["[pc("stone")]"]<<src.stone
			F["[pc("ore")]"]<<src.ore


			F["[pc("level")]"]<<src.level
			F["[pc("exp")]"]<<src.exp
			F["[pc("max_exp")]"]<<src.max_exp

			F["[pc("str")]"]<<src.str
			F["[pc("str_exp")]"]<<src.str_exp
			F["[pc("str_max_exp")]"]<<src.str_max_exp

			F["[pc("int")]"]<<src.int
			F["[pc("int_exp")]"]<<src.int_exp
			F["[pc("int_max_exp")]"]<<src.int_max_exp

			F["[pc("agi")]"]<<src.agi
			F["[pc("agi_exp")]"]<<src.agi_exp
			F["[pc("agi_max_exp")]"]<<src.agi_max_exp

			F["[pc("wil")]"]<<src.wil
			F["[pc("wil_exp")]"]<<src.wil_exp
			F["[pc("wil_max_exp")]"]<<src.wil_max_exp

			F["[pc("end")]"]<<src.end
			F["[pc("end_exp")]"]<<src.end_exp
			F["[pc("end_max_exp")]"]<<src.end_max_exp




			F["[pc("death_time")]"]<<src.death_time
			F["[pc("hash2")]"]<<(src.level+src.exp+src.max_exp+src.str+src.str_exp+src.str_max_exp+src.int+src.int_exp+src.int_max_exp+src.agi+src.agi_exp+src.agi_max_exp+src.wil+src.wil_exp+src.wil_max_exp+src.end+src.end_exp+src.end_max_exp)
