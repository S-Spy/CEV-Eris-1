/obj/item/weapon/star
	name = "shuriken"
	desc = "A sharp, perfectly weighted piece of metal."
	icon_state = "star"
	flags = CONDUCT
	force = 5
	throw_speed = 10
	throwforce =  15
	throw_range = 15
	sharp = TRUE
	edge =  TRUE

/obj/item/weapon/star/New()
	..()
	pixel_x = rand(-12, 12)
	pixel_y = rand(-12, 12)

/obj/item/weapon/star/ninja
	color = "#007700"
	var/poisoned = TRUE

/obj/item/weapon/star/ninja/throw_impact(atom/hit_atom)
	..()
	if(poisoned && isliving(hit_atom))
		var/mob/living/M = hit_atom
		M.adjustToxLoss(rand(20,40))
		poisoned = FALSE
		color = null
