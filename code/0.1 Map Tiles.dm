obj
	tree
		icon='icons/Trees.dmi'
		layer=40
		pixel_x=-46
		density=1
		tree1
turf
	nature
		grass
			icon='icons/Grass.dmi'
			grass1
				icon_state="grass1 a"
				layer=2
				New()
					..()
					icon_state=pick("grass1 a","grass1 b")
			grass2
				icon_state="grass2"
				edge_state="grass2 edge"
				edge_corner_state="grass2 edge2"
				edge_all_state="grass2 all"
				edge_corners=TRUE
				layer=3
				New()
					..()
					create_edging(src)
		dirt
			icon='icons/Dirt.dmi'
			New()
				..()
				if(edge_state!="")create_edging(src)
			dirt1
				layer=4
				icon_state="dirt1"
				edge_state="dirt1 edge"
			dirt2
				layer=5
				icon_state="dirt2"
				edge_state="dirt2 edge"
			dirt3
				layer=6
				icon_state="dirt3"
				edge_state="dirt3 edge"