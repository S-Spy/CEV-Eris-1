/obj/item/weapon/butterfly
	name = "butterfly knife"
	desc = "A basic metal blade concealed in a lightweight plasteel grip. Small enough when folded to fit in a pocket."
	icon_state = "butterflyknife"
	item_state = null
	hitsound = null
	var/active = FALSE
	w_class = ITEM_SIZE_SMALL
	force = 2
	sharp = FALSE
	edge = FALSE
	throw_speed = 3
	throw_range = 4
	throwforce = 7
	attack_verb = list("patted", "tapped")

/obj/item/weapon/butterfly/switchblade
	name = "switchblade"
	desc = "A classic switchblade with gold engraving. Just holding it makes you feel like a gangster."
	icon_state = "switchblade"

/obj/item/weapon/butterfly/attack_self(mob/user)
	active = !active
	if(active)
		user << SPAN_NOTICE("You flip out \the [src].")
		playsound(user, 'sound/weapons/flipblade.ogg', 15, 1)
		edge = TRUE
		sharp = TRUE
		force = 15
		throwforce = 12
		hitsound = 'sound/weapons/bladeslice.ogg'
		icon_state += "_open"
		w_class = ITEM_SIZE_NORMAL
		tool_qualities = list(QUALITY_CUTTING = 20, QUALITY_WIRE_CUTTING = 10)
		attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	else
		user << SPAN_NOTICE("\The [src] can now be concealed.")
		force = initial(force)
		edge = FALSE
		sharp = FALSE
		hitsound = initial(hitsound)
		icon_state = initial(icon_state)
		w_class = initial(w_class)
		tool_qualities = null
		attack_verb = initial(attack_verb)
	add_fingerprint(user)

/*
 * Kitchen knives
 */
/obj/item/weapon/knife
	name = "kitchen knife"
	icon = 'icons/obj/kitchen.dmi'
	icon_state = "knife"
	desc = "A general purpose Chef's Knife made by SpaceCook Incorporated. Guaranteed to stay sharp for years to come."
	flags = CONDUCT
	sharp = TRUE
	edge = TRUE
	force = 10
	w_class = ITEM_SIZE_NORMAL
	throwforce = 6
	throw_speed = 3
	throw_range = 6
	matter = list(MATERIAL_STEEL = 3)
	origin_tech = "materials=1"
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	slot_flags = SLOT_BELT
	tool_qualities = list(QUALITY_CUTTING = 20,  QUALITY_WIRE_CUTTING = 10)

/obj/item/weapon/knife/boot
	name = "boot knife"
	desc = "A small fixed-blade knife for putting inside a boot."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "tacknife"
	item_state = "knife"

/obj/item/weapon/knife/hook
	name = "meat hook"
	desc = "A sharp, metal hook what sticks into things."
	icon_state = "hook_knife"
	item_state = "hook_knife"

/obj/item/weapon/knife/ritual
	name = "ritual knife"
	desc = "The unearthly energies that once powered this blade are now dormant."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "render"

/obj/item/weapon/knife/butch
	name = "butcher's cleaver"
	icon_state = "butch"
	desc = "A huge thing used for chopping and chopping up meat. This includes clowns and clown-by-products."
	force = 15
	w_class = ITEM_SIZE_SMALL
	throwforce = 8
	attack_verb = list("cleaved", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/weapon/knife/neotritual
	name = "NeoTheology ritual knife"
	desc = "Cyberchristians priests use this for ending followers agony. When nothing can help, and only new body can bring salvation, use this."
	icon = 'icons/obj/weapons.dmi'
	icon_state = "neot-knife"
	item_state = "knife"
