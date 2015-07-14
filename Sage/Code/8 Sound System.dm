mob
	var
		sound/song
		toggle_music=1
		toggle_sound=1
		sound_volume=100
		music_volume=100
	verb
		toggle_sound()
			set category=null
			switch(toggle_sound)
				if(1)
					toggle_sound=0
					alert(usr,"Sound FX has been turned off.","Sound FX")
				if(0)
					toggle_sound=1
					alert(usr,"Sound FX has been turned on.","Sound FX")
		toggle_music()
			set category=null
			switch(toggle_music)
				if(1)
					src.song.volume=0
					src.refresh_music()
					toggle_music=0
					alert(usr,"Background Music has been turned off.","Sound FX")
				if(0)
					src.song.volume=src.music_volume
					src.refresh_music()
					toggle_music=1
					alert(usr,"Background Music has been turned on.","Sound FX")
		set_sound_volume()
			set category=null
			var/X=input(usr,"What would you like to set sound FX volume to?(%)","Sound FX Volume") as num
			if(X<0)
				sound_volume=0
			else if(X>100)
				sound_volume=100
			else
				sound_volume=X
			alert("Sound FX Volume has been set to [src.sound_volume]","Sound FX Volume")
		set_music_volume()
			set category=null
			var/X=input("What would you like to set music volume to?(%)","Music Volume")as num
			if(X==music_volume)
				alert("Music volume is already set to [src.music_volume]%","Music Volume")
			if(X<0)
				music_volume=0
			else if(X>100)
				music_volume=100
			else
				music_volume=X
			src.song.volume=music_volume
			src.refresh_music()
			alert("Music Volume has been set to [src.music_volume]","Music Volume")
	proc
		play_sound(var/A)
			if(src.toggle_sound)
				var/sound/B=sound(A,volume=src.sound_volume)
				src << B
		play_music(var/A)
			src << sound(null)
			var/sound/S=sound(A,repeat=1,volume=src.music_volume,channel=1)
			src.song=S
			if(toggle_music)
				src << song
		fadeout_music()
			var/x=10
			while(x>0)
				x-=1
				song.volume-=10*(src.music_volume/100)
				refresh_music()
				sleep(2)
			song.volume=0
			refresh_music()
		fadein_music()
			var/x=20
			if(toggle_music)
				while(x>0)
					x-=1
					song.volume+=5*(src.music_volume/100)
					refresh_music()
					sleep(2)
			song.volume=src.music_volume
			refresh_music()
		refresh_music()
			song.status|=SOUND_UPDATE
			if(toggle_music)
				src << song