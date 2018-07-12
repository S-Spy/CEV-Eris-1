var/global/list/ashtray_cache = list()

/obj/item/ashtray
	name = "ashtray"
	icon = 'icons/obj/objects.dmi'
	icon_state = "ashtray"
	flags = CONDUCT
	var/max_butts = 10

/obj/item/ashtray/New()
	..()
	pixel_y = rand(-5, 5)
	pixel_x = rand(-6, 6)
	update_icon()
	return

/obj/item/ashtray/update_icon()
	overlays.Cut()

	if (contents.len == max_butts)
		overlays += "ashtray_full"
		desc = "It's stuffed full."
	else if (contents.len > max_butts/2)
		overlays += "ashtray_half"
		desc = "It's half-filled."
	else
		desc = ""

/obj/item/ashtray/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (health <= 0)
		return
	if (istype(W,/obj/item/weapon/cigbutt) || istype(W,/obj/item/clothing/mask/smokable/cigarette) || istype(W, /obj/item/weapon/flame/match))
		if (contents.len >= max_butts)
			user << "\The [src] is full."
			return
		user.remove_from_mob(W)
		W.loc = src

		if (istype(W,/obj/item/clothing/mask/smokable/cigarette))
			var/obj/item/clothing/mask/smokable/cigarette/cig = W
			if (cig.lit == 1)
				src.visible_message("[user] crushes [cig] in \the [src], putting it out.")
				STOP_PROCESSING(SSobj, cig)
				var/obj/item/butt = new cig.type_butt(src)
				cig.transfer_fingerprints_to(butt)
				qdel(cig)
				W = butt
				//spawn(1)
				//	TemperatureAct(150)
			else if (cig.lit == 0)
				user << "You place [cig] in [src] without even smoking it. Why would you do that?"

		src.visible_message("[user] places [W] in [src].")
		user.update_inv_l_hand()
		user.update_inv_r_hand()
		add_fingerprint(user)
		update_icon()
	else
		health = max(0,health - W.force)
		user << "You hit [src] with [W]."
		if (health < 1)
			shatter()
	return

/obj/item/ashtray/throw_impact(atom/hit_atom)
	if (health > 0)
		health = max(0,health - 3)
		if (contents.len)
			src.visible_message(SPAN_DANGER("\The [src] slams into [hit_atom], spilling its contents!"))
		for (var/obj/item/clothing/mask/smokable/cigarette/O in contents)
			O.loc = src.loc
		if (health < 1)
			shatter()
			return
		update_icon()
	return ..()

/obj/item/ashtray/proc/shatter()
	visible_message("\red [src] shatters spilling its contents!")
	for (var/obj/item/clothing/mask/smokable/cigarette/O in contents)
		O.loc = src.loc
	qdel(src)
