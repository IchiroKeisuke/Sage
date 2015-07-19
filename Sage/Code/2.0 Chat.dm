proc//Proclaims proc
	Overwrite_Text(msg as text, snippet as text, position as num, secposition)//This is a modifyed version of flicks proc called "Insert_Text"
		msg = copytext(msg, 1, position) + snippet + copytext(msg, secposition)//This is complicated, yet simple.
		return msg//This sends the message back what whatever called it.
mob
	var
		chat_type="local"
		list/ignore_list=list()
		list/party=list()
		mob/chat_respond
		emoticons=1
	proc
		emoticon_filter(var/x)
			if(emoticons)
				while(findtext(x,":)")!=0)
					x=Overwrite_Text(x,"\icon[icon('Smiley.dmi',":)")]",findtext(x,":)"),findtext(x,":)")+2)
				while(findtext(x,":D")!=0)
					x=Overwrite_Text(x,"\icon[icon('Smiley.dmi',":D")]",findtext(x,":D"),findtext(x,":D")+2)
				while(findtext(x,":(")!=0)
					x=Overwrite_Text(x,"\icon[icon('Smiley.dmi',":(")]",findtext(x,":("),findtext(x,":(")+2)
				while(findtext(x,":p")!=0)
					x=Overwrite_Text(x,"\icon[icon('Smiley.dmi',":p")]",findtext(x,":p"),findtext(x,":p")+2)
				while(findtext(x,";)")!=0)
					x=Overwrite_Text(x,"\icon[icon('Smiley.dmi',";)")]",findtext(x,";)"),findtext(x,";)")+2)
				while(findtext(x,":o")!=0)
					x=Overwrite_Text(x,"\icon[icon('Smiley.dmi',":o")]",findtext(x,":o"),findtext(x,":o")+2)

				return x
			else
				return x
	verb
		toggle_emoticons()
			set hidden=1
			switch(emoticons)
				if(1)
					emoticons=0
					usr << "<font color=yellow>Emoticons Disabled."
				else
					emoticons=1
					usr << "<font color=yellow>Emoticons Enabled."
		toggle_chat()
			set category=null
			switch(chat_type)
				if("local")
					chat_type="global"
				else
					chat_type="local"
			usr << output("<b><u>You are now chatting in [chat_type]","chat")
		respond()
			set category=null
			var/msg=input("Who would you like to whisper back?","Respond") as text
			var/mob/targ=chat_respond
			if(targ)
				if(usr.name in targ.ignore_list)
					usr << output("[targ] has put you on his ignore list.","Chat.chat")
					return
				targ << output("Whisper from [usr] : [msg]","Chat.chat")
				chat_respond=targ
				targ.chat_respond=usr
			else
				usr << output("Cannot find user : [targ]","Chat.chat")
		whisper()
			set category=null
			var/tar=input("Who would you like to whisper?","Target Character") as text
			var/mob/targ
			for(var/mob/M in world)
				if(M.name==tar)
					targ=M
				sleep(0)
			if(targ)
				var/msg=input("What would you like to whisper?","Whisper") as text
				if(usr.name in targ.ignore_list)
					usr << output("[targ] has put you on his ignore list.","Chat.chat")
					return
				targ << output("Whisper from [usr] : [msg]","Chat.chat")
				chat_respond=targ
				targ.chat_respond=usr
			else
				usr << output("Cannot find user : [tar]","Chat.chat")
		chat(t as text)
			set category=null
			t="[html_encode(t)]"
			t=emoticon_filter(t)
			switch(chat_type)
				if("local")
					for(var/mob/M in range(6))
						if(!(usr in M.ignore_list))M << output("<b>[usr] : [t]","chat")

				//	for(var/mob/M in range(6))
			//			chatmessage(M,"[src.name]: [html_encode(t)]","chatpanel")
					new/obj/effects/small_effects/chat_notification(loc,usr)
				else
					for(var/mob/MM in world)
						if(!(usr in MM.ignore_list))MM << output("<i>[usr] : [t]","chat")
				//	chatmessage(world,"[src.name]: [html_encode(t)]","chatpanel")
		party_chat(t as text)
			set category=null
			src << output("<b>[usr] : [html_encode(t)]","partychat")
			for(var/mob/M in src.party)
				if(!(usr in M.ignore_list))M << output("<b>[usr] : [t]","PartyChat.partychat")
mob
	var
		ignore_open=FALSE
		partychat_open=FALSE
		chat_open=FALSE
	proc
		refresh_ignore_list()
			src << output(null,"Ignore.IgnoreList")
			for(var/A in src.ignore_list)
				src << output("[A]","Ignore.IgnoreList")
	verb
		add_ignore()
			set category=null
			var/A=winget(src,"in","text")
			src << "You will no longer recieve any messages from [A]"
			if(A in src.ignore_list)
			else
				src.ignore_list+=A
			refresh_ignore_list()
		remove_ignore()
			set category=null
			var/A=winget(src,"in","text")
			src << "You have unignored [A], you can now recieve messages from this user again."
			if(A in src.ignore_list)
				src.ignore_list-=A
			refresh_ignore_list()
		clear_ignore()
			set category=null
			var/A=input("Are you sure you want to clear your ignore user(s) list?","Confirm","No","Yes")
			if(A=="Yes")
				src.ignore_list=list()
		toggle_chatwindow()
			set category=null
			if(chat_open)
				close_chat()
			else
				open_chat()
		open_chat()
			set category=null
			chat_open=TRUE
			winshow(src,"Chat",1)
		close_chat()
			set category=null
			chat_open=FALSE
			winshow(src,"Chat",0)
		toggle_partychat()
			set category=null
			if(partychat_open)
				close_partychat()
			else
				open_partychat()
		open_partychat()
			set category=null
			partychat_open=TRUE
			winshow(src,"PartyChat",1)
		close_partychat()
			set category=null
			partychat_open=FALSE
			winshow(src,"PartyChat",0)
		toggle_ignore()
			set category=null
			if(ignore_open)
				close_ignore()
			else
				open_ignore()
		open_ignore()
			set category=null
			ignore_open=TRUE
			refresh_ignore_list()
			winshow(src,"Ignore",1)
		close_ignore()
			set category=null
			ignore_open=FALSE
			winshow(src,"Ignore",0)