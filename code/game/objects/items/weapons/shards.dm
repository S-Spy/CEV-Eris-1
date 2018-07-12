// Glass shards

/obj/item/weapon/shard
	name = "glass shard"
	icon = 'icons/obj/shards.dmi'
	icon_state = "large"
	sharp = 1
	edge = 1
	w_class = ITEM_SIZE_SMALL
	force = 5.0
	throwforce = 8.0
	item_state = "shard-glass"
	attack_verb = list("stabbed", "slashed", "sliced", "cut")
	gender = NEUTER

	var/sheet_type = /obj/item/stack/material/glass
	var/shard_icon = ""

/obj/item/weapon/shard/New()
	..()
	update_icon()
	desc = "A small piece of [name]. It looks sharp, you wouldn't want to step on it barefoot. Could probably be used as ... a throwing weapon?"

/obj/item/weapon/shard/update_icon()
	var/size = pick("large", "medium", "small")
	icon_state = "[shard_icon][size]"
	switch(size)
		if("small")
			pixel_x = rand(-12, 12)
			pixel_y = rand(-12, 12)
		if("medium")
			pixel_x = rand(-8, 8)
			pixel_y = rand(-8, 8)
		if("large")
			pixel_x = rand(-5, 5)
			pixel_y = rand(-5, 5)

/obj/item/weapon/shard/attackby(obj/item/I, mob/user)
	if(QUALITY_WELDING in I.tool_qualities)
		if(I.use_tool(user, src, WORKTIME_FAST, QUALITY_WELDING, FAILCHANCE_EASY, required_stat = STAT_COG))
			new sheet_type(loc)
			qdel(src)
			return
	return ..()

/obj/item/weapon/shard/Crossed(AM as mob|obj)
	..()
	if(isliving(AM))
		var/mob/M = AM

		if(M.buckled) //wheelchairs, office chairs, rollerbeds
			return

		playsound(src.loc, 'sound/effects/glass_step.ogg', 50, 1) // not sure how to handle metal shards with sounds
		if(ishuman(M))
			var/mob/living/carbon/human/H = M

			if(H.species.siemens_coefficient<0.5) //Thick skin.
				return

			if( H.shoes || ( H.wear_suit && (H.wear_suit.body_parts_covered & FEET) ) )
				return

			M << SPAN_DANGER("You step on \the [src]!")

			var/list/check = list(BP_L_FOOT, BP_R_FOOT)
			while(check.len)
				var/picked = pick(check)
				var/obj/item/organ/external/affecting = H.get_organ(picked)
				if(affecting)
					if(affecting.robotic >= ORGAN_ROBOT)
						return
					if(affecting.take_damage(5, 0))
						H.UpdateDamageIcon()
					H.updatehealth()
					if(!(H.species.flags & NO_PAIN))
						H.Weaken(3)
					return
				check -= picked
			return

/obj/item/weapon/shard/shrapnel
	name = "shrapnel"
	icon_state = "shrapnellarge"
	desc = "A bunch of tiny bits of shattered metal."
	sheet_type = /obj/item/stack/material/steel
	gender = PLURAL
	shard_icon = "shrapnel"

/obj/item/weapon/shard/plasma
	name = "plasma shard"
	icon_state = "plasmalarge"
	sheet_type = /obj/item/stack/material/glass/plasmaglass
	shard_icon = "plasma"
