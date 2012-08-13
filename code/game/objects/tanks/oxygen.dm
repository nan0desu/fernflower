
/obj/item/weapon/tank/oxygen
	name = "Gas Tank (Oxygen)"
	desc = "A tank of oxygen"
	icon_state = "oxygen"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD


	New()
		..()
		air_contents.adjust((6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))
		return


	examine()
		set src in usr
		..()
		if(air_contents.oxygen < 10)
			usr << text("\red <B>The meter on the [src.name] indicates you are almost out of air!</B>")
			playsound(usr, 'alert.ogg', 50, 1)

	attack(mob/M as mob, mob/living/user as mob)

		src.add_fingerprint(user)

		M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been attacked with [src.name] by [user.name] ([user.ckey])</font>")
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [src.name] to attack [M.name] ([M.ckey])</font>")
		for(var/mob/O in viewers(M))
			if (O.client)	O.show_message("\red <B>[M] has been smashed with oxygen tank by [user]!</B>", 1, "\red You hear someone screams", 2)



/obj/item/weapon/tank/oxygen/yellow
	name = "Gas Tank (Oxygen)"
	desc = "A tank of oxygen, this one is yellow."
	icon_state = "oxygen_f"


/obj/item/weapon/tank/oxygen/red
	name = "Gas Tank (Oxygen)"
	desc = "A tank of oxygen, this one is red."
	icon_state = "oxygen_fr"
