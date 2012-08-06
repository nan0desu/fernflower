/obj/item/weapon/melee/gibstick
	name = "Gibber stick"
	desc = "."
	icon = 'weapon.dmi'
	icon_state = "stunbaton"
	var/mode
	New()
		message_admins("ADMIN: Gibstick has been spawned")
	attack_self (mob/user)
		mode ++
		if(mode == 4)
			mode = 0
		switch(mode)
			if(0)
				usr << "You off power stick"
			if(1)
				usr << "You turn gib mode"
			if(2)
				usr << "You turn stun mode"
			if(3)
				usr << "You turn heal mode"

	attack(var/mob/living/M as mob)
		switch(mode)
			if(0)
				..()
			if(1)
				M.gib()
			if(2)
				M.Stun(10)
				M.Weaken(10)
			if(3)
				M.revive()
		return