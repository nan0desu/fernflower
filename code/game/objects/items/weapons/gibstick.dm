/obj/item/weapon/melee/gibstick
	name = "Centcomm Manipulation Device"
	desc = "Product of weird technology from deepest CentComm labs."
	icon = 'library.dmi'
	icon_state = "scanner"
	var/mode
	New()
		message_admins("ADMIN: Manipulation Device has been spawned")
	attack_self (mob/user)
		mode ++
		if(mode == 5)
			mode = 0
		switch(mode)
			if(0)
				usr << "You off manipulation device"
			if(1)
				usr << "You turn gib mode"
			if(2)
				usr << "You turn stun mode"
			if(3)
				usr << "You turn heal mode"
			if(4)
				usr << "You turn cuff mode"

	attack(var/mob/living/M as mob)
		switch(mode)
			if(0)
				..()
			if(1)
				M.gib()
			if(2)
				M.Stun(25)
				M.Weaken(25)
			if(3)
				M.revive()
			if(4)
				M.handcuffed()
		return