/obj/item/weapon/butterflyconstruction
	name = "unfinished concealed knife"
	desc = "An unfinished concealed knife, it looks like the screws need to be tightened."
	icon = 'icons/obj/buildingobject.dmi'
	icon_state = "butterflystep1"

/obj/item/weapon/butterflyconstruction/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/tool/screwdriver))
		user << "You finish the concealed blade weapon."
		new /obj/item/weapon/butterfly(user.loc)
		qdel(src)
		return

/obj/item/weapon/butterflyblade
	name = "knife blade"
	desc = "A knife blade. Unusable as a weapon without a grip."
	icon = 'icons/obj/buildingobject.dmi'
	icon_state = "butterfly2"

/obj/item/weapon/butterflyhandle
	name = "concealed knife grip"
	desc = "A plasteel grip with screw fittings for a blade."
	icon = 'icons/obj/buildingobject.dmi'
	icon_state = "butterfly1"

/obj/item/weapon/butterflyhandle/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/butterflyblade))
		user << "You attach the two concealed blade parts."
		new /obj/item/weapon/butterflyconstruction(user.loc)
		qdel(W)
		qdel(src)
		return

/obj/item/weapon/wirerod
	name = "wired rod"
	desc = "A rod with some wire wrapped around the top. It'd be easy to attach something to the top bit."
	icon_state = "wiredrod"
	item_state = "rods"
	flags = CONDUCT
	force = 8
	throwforce = 10
	w_class = ITEM_SIZE_NORMAL
	attack_verb = list("hit", "bludgeoned", "whacked", "bonked")

/obj/item/weapon/wirerod/attackby(var/obj/item/I, mob/user as mob)
	..()
	var/obj/item/finished
	if(istype(I, /obj/item/weapon/shard))
		finished = new /obj/item/weapon/twohanded/spear(get_turf(user))
		user << SPAN_NOTICE("You fasten \the [I] to the top of the rod with the cable.")
	else if(QUALITY_CUTTING in I.tool_qualities || QUALITY_WIRE_CUTTING in I.tool_qualities)
		finished = new /obj/item/weapon/melee/baton/cattleprod(get_turf(user))
		user << SPAN_NOTICE("You fasten the wirecutters to the top of the rod with the cable, prongs outward.")
	if(finished)
		user.drop_from_inventory(src)
		user.drop_from_inventory(I)
		qdel(I)
		qdel(src)
		user.put_in_hands(finished)
	update_icon(user)
