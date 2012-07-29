//r2d2
/mob/living/simple_animal/r2d2
	name = "r2d2"
	desc = "Astro droid."
	icon = 'mob.dmi'
	icon_state = "r2d2"
	icon_living = "r2d2"
	icon_dead = "r2d2_dead"
	speak = list("breep-tiop!","peeep!","trip-poop!","pip-poop!")
	speak_emote = list("whizz", "beeps")
	emote_hear = list("whizz")
	emote_see = list("blink", "observing")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	meat_type = /obj/item/weapon/cable_coil/yellow
	response_help  = "knock the"
	response_disarm = "gently pushes aside the"
	response_harm   = "kicks the"