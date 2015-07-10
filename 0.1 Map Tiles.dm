obj
	tree
		icon='Trees.dmi'
		layer=40
		pixel_x=-46
		density=1
		tree1
turf
	nature
		grass
			icon='Grass.dmi'
			grass1
				icon_state="grass1 a"
				layer=2
				New()
					..()
					icon_state=pick("grass1 a","grass1 b")
		dirt
			icon='Dirt.dmi'
			New()
				..()
				if(edge_state!="")create_edging(src)
			dirt1
				layer=3
				icon_state="dirt1"
				edge_state="dirt1 edge"