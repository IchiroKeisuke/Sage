client
	Topic(href,href_list[])
		if(href_list["action"])
			usr.response=href_list["action"]
		if(href_list["action2"])
			usr.response2=href_list["action2"]
		..()
mob
	var
		response=null
		responding=0
		response2=null
		responding2=0
	proc
		popup_response()
			while(!response)
				sleep(5)
			var/A=response
			response=null
			return A//background-image: url("btn_bg.dmi");
		popup(var/title,var/message,var/list/buttons=list("Ok"))
			usr << browse_rsc(icon('btn_bg.dmi'))
			usr << browse_rsc(icon('win_bg.dmi'))
			var/style={"<STYLE>BODY { color: white}INPUT{font-weight: bold;width:92px;height=46px;background-image:url('btn_bg.dmi');background-size: 100% 100%;border:1;background-color:black;color:white;o}</STYLE>"}
			var/header="<center><u><b>[title]</b></u></center>"
			var/body="<p width=100%>[message]</p>"
			var/forms=""
			for(var/B in buttons)
				forms+={"<td><form name="ButtonForm" action="byond://" method="get"><input border=1 style="background-color:black;color:white;background-image:url('btn_bg.dmi');background-size: 100% 100%;" type="hidden" name="action" value="[B]" /><input type="submit" value="[B]" /></form></td>"}
			var/window={"[style]<body><img style="position:absolute;z-index:-1;"width="100%" height="100%" src="win_bg.dmi"></img>
			<table height=75% width=100%>
			<tr height=10%><td><div style="margin-left: 20px;margin-right:20px;margin-top:15px;">[header]</div></td></tr>
			<tr><td><div style="margin-left: 20px;margin-right:20px;">[body]</div></td></tr>
			<center><table height="25%" width="100">[forms]</table></center>
			</table>
			</body>"}
			return window
		popwindow_response()
			while(!response2)
				sleep(5)
			var/A=response2
			response2=null
			return A//background-image: url("btn_bg.dmi");
		popwindow(var/title,var/message,var/list/buttons=list("Ok"))
			usr << browse_rsc(icon('btn_bg.dmi'))
			//usr << browse_rsc(icon('win_bg.dmi'))
			var/style={"<STYLE>BODY { background:black;color: white}INPUT{font-weight: bold;width:92px;height=46px;background-image:url('btn_bg.dmi');background-size: 100% 100%;border:1;background-color:black;color:white;o}</STYLE>"}
			var/header="<center><u><b>[title]</b></u></center>"
			var/body="<p width=100%>[message]</p>"
			var/forms=""
			for(var/B in buttons)
				forms+={"<td><form name="ButtonForm" action="byond://" method="get"><input border=1 style="background-color:black;color:white;background-image:url('btn_bg.dmi');background-size: 100% 100%;" type="hidden" name="action2" value="[B]" /><input type="submit" value="[B]" /></form></td>"}
			var/window={"[style]<body>
			<table height=75% width=100%>
			<tr height=10%><td><div style="margin-left: 20px;margin-right:20px;margin-top:15px;">[header]</div></td></tr>
			<tr><td><div style="margin-left: 20px;margin-right:20px;">[body]</div></td></tr>
			<center><table height="25%" width="100">[forms]</table></center>
			</table>
			</body>"}
			return window