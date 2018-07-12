/obj/item/weapon/kitchen
	icon = 'icons/obj/kitchen.dmi'

/*
 * Utensils
 */
/obj/item/weapon/kitchen/utensil
	force = 5
	w_class = ITEM_SIZE_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	flags = CONDUCT
	origin_tech = "materials=1"
	attack_verb = list("attacked", "stabbed", "poked")
	sharp = FALSE
	edge = TRUE

	var/loaded      //Descriptive string for currently loaded food object.
	var/scoop_food = 1

/obj/item/weapon/kitchen/utensil/New()
	..()
	if (prob(60))
		src.pixel_y = rand(0, 4)
	create_reagents(5)
	return

/obj/item/weapon/kitchen/utensil/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(!istype(M))
		return ..()

	if(user.a_intent != I_HELP)
		if(user.targeted_organ in list(BP_HEAD, O_EYES))
			if((CLUMSY in user.mutations) && prob(50))
				M = user
			return eyestab(M,user)
		else
			return ..()

	if (reagents.total_volume > 0)
		reagents.trans_to_mob(M, reagents.total_volume, CHEM_INGEST)
		if(M == user)
			if(!M.can_eat(loaded))
				return
			M.visible_message(SPAN_NOTICE("\The [user] eats some [loaded] from \the [src]."))
		else
			user.visible_message(SPAN_WARNING("\The [user] begins to feed \the [M]!"))
			if(!(M.can_force_feed(user, loaded) && do_mob(user, M, 5 SECONDS)))
				return
			M.visible_message(SPAN_NOTICE("\The [user] feeds some [loaded] to \the [M] with \the [src]."))
		playsound(M.loc,'sound/items/eatfood.ogg', rand(10,40), 1)
		overlays.Cut()
		return
	else
		user << SPAN_WARNING("You don't have anything on \the [src].")	//if we have help intent and no food scooped up DON'T STAB OURSELVES WITH THE FORK
		return

/obj/item/weapon/kitchen/utensil/fork
	name = "fork"
	desc = "It's a fork. Sure is pointy."
	icon_state = "fork"

/obj/item/weapon/kitchen/utensil/spoon
	name = "spoon"
	desc = "It's a spoon. You can see your own upside-down face in it."
	icon_state = "spoon"
	attack_verb = list("attacked", "poked")

/*
 * Rolling Pins
 */

/obj/item/weapon/kitchen/rollingpin
	name = "rolling pin"
	desc = "Used to knock out the Bartender."
	icon_state = "rolling_pin"
	force = 8
	throwforce = 10
	throw_speed = 2
	throw_range = 7
	w_class = ITEM_SIZE_NORMAL
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "whacked")

/obj/item/weapon/kitchen/rollingpin/attack(mob/living/M as mob, mob/living/user as mob)
	if ((CLUMSY in user.mutations) && prob(50))
		user << SPAN_WARNING("\The [src] slips out of your hand and hits your head.")
		user.drop_from_inventory(src)
		user.take_organ_damage(10)
		user.Paralyse(2)
		return
	return ..()
