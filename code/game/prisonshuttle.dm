var/prison_shuttle_tickstomove = 10
var/prison_shuttle_moving = 0
var/prison_shuttle_location = 0 // 0 = station 13, 1 = mining station
var/arrival_shuttle_tickstomove = 10
var/arrival_shuttle_moving = 0
var/arrival_shuttle_location = 0
var/start_arrival_shuttle_location = 0

proc/move_prison_shuttle()
	if(prison_shuttle_moving)	return
	prison_shuttle_moving = 1
	spawn(prison_shuttle_tickstomove*10)
		var/area/fromArea
		var/area/toArea
		if (prison_shuttle_location == 1)
			fromArea = locate(/area/shuttle/prison/prison)
			toArea = locate(/area/shuttle/prison/station)
		else
			fromArea = locate(/area/shuttle/prison/station)
			toArea = locate(/area/shuttle/prison/prison)


		var/list/dstturfs = list()
		var/throwy = world.maxy

		for(var/turf/T in toArea)
			dstturfs += T
			if(T.y < throwy)
				throwy = T.y

		// hey you, get out of the way!
		for(var/turf/T in dstturfs)
			// find the turf to move things to
			var/turf/D = locate(T.x, throwy - 1, 1)
			//var/turf/E = get_step(D, SOUTH)
			for(var/atom/movable/AM as mob|obj in T)
				AM.Move(D)
				// NOTE: Commenting this out to avoid recreating mass driver glitch
				/*
				spawn(0)
					AM.throw_at(E, 1, 1)
					return
				*/

			if(istype(T, /turf/simulated))
				del(T)

		for(var/mob/living/carbon/bug in toArea) // If someone somehow is still in the shuttle's docking area...
			bug.gib()

		fromArea.move_contents_to(toArea)
		if (prison_shuttle_location)
			prison_shuttle_location = 0
		else
			prison_shuttle_location = 1
		prison_shuttle_moving = 0
	return

/obj/machinery/computer/prison_shuttle
	name = "Prison Shuttle Console"
	icon = 'computer.dmi'
	icon_state = "shuttle"
	req_access = list(ACCESS_SECURITY)
	var/hacked = 0
	var/allowedtocall = 0
	var/location = 0 //0 = station, 1 = mining base

/obj/machinery/computer/prison_shuttle/attack_hand(user as mob)
	src.add_fingerprint(usr)
	var/dat
	dat = text("<center>Prison shuttle:<br> <b><A href='?src=\ref[src];move=[1]'>Send</A></b></center>")
	user << browse("[dat]", "window=miningshuttle;size=200x100")

/obj/machinery/computer/prison_shuttle/Topic(href, href_list)
	if(..())
		return
	usr.machine = src
	src.add_fingerprint(usr)
	if(href_list["move"])
		if(ticker.mode.name == "blob")
			if(ticker.mode:declared)
				usr << "Under directive 7-10, [station_name()] is quarantined until further notice."
				return

		if (!prison_shuttle_moving)
			usr << "\blue Shuttle recieved message and will be sent shortly."
			move_prison_shuttle()
		else
			usr << "\blue Shuttle is already moving."

/obj/machinery/computer/prison_shuttle/attackby(obj/item/weapon/W as obj, mob/user as mob)

	if (istype(W, /obj/item/weapon/card/emag))
		src.req_access = list()
		hacked = 1
		usr << "You fried the consoles ID checking system. It's now available to everyone!"

/////////////////////////////////////////

/obj/machinery/computer/arrival_shuttle
	name = "Arrival Shuttle Console"
	icon = 'computer.dmi'
	icon_state = "shuttle"
	req_access = list(ACCESS_SECURITY)
	var/hacked = 0
	var/allowedtocall = 0
	var/location = 0 //0 = station, 1 = mining base

/obj/machinery/computer/arrival_shuttle/attack_hand(user as mob)
	src.add_fingerprint(usr)
	var/dat
	dat = text("<center>Arrival shuttle:<br> <b><A href='?src=\ref[src];move=[1]'>Send</A></b></center>")
	user << browse("[dat]", "window=miningshuttle;size=200x100")

/obj/machinery/computer/prison_shuttle/Topic(href, href_list)
	if(..())
		return
	usr.machine = src
	src.add_fingerprint(usr)
	if(href_list["move"])
		if (!arrival_shuttle_moving)
			usr << "\blue Shuttle recieved message and will be sent."
			move_arrival_shuttle()
		else
			usr << "\blue Shuttle is already moving."

proc/move_arrival_shuttle()
	if(arrival_shuttle_moving)	return
	arrival_shuttle_moving = 1
	start_arrival_shuttle_location = arrival_shuttle_location
	spawn(arrival_shuttle_tickstomove*15)  // 15 sec
		var/obj/item/device/radio/intercom/a = new /obj/item/device/radio/intercom(null)
		var/area/fromArea
		var/area/toArea
		if (arrival_shuttle_location == 1)
			fromArea = locate(/area/shuttle/arrival/pre_game)
			toArea = locate(/area/shuttle/arrival/spess)
			a.autosay("\"Ashenvale\" transport shuttle has started from the CentComm.", "Shuttle Autopilot")
		else
			fromArea = locate(/area/shuttle/prison/station)
			toArea = locate(/area/shuttle/arrival/spess)
			a.autosay("\"Ashenvale\" transport shuttle has started from the [station_name()].", "Shuttle Autopilot")

		var/list/dstturfs = list()
		var/throwy = world.maxy

		for(var/turf/T in toArea)
			dstturfs += T
			if(T.y < throwy)
				throwy = T.y

		// hey you, get out of the way!
		for(var/turf/T in dstturfs)
			// find the turf to move things to
			var/turf/D = locate(T.x, throwy - 1, 1)
			//var/turf/E = get_step(D, SOUTH)
			for(var/atom/movable/AM as mob|obj in T)
				AM.Move(D)
				// NOTE: Commenting this out to avoid recreating mass driver glitch
				/*
				spawn(0)
					AM.throw_at(E, 1, 1)
					return
				*/

			if(istype(T, /turf/simulated))
				del(T)

		for(var/mob/living/carbon/bug in toArea) // If someone somehow is still in the shuttle's docking area...
			bug.gib()

		fromArea.move_contents_to(toArea)
		arrival_shuttle_location = 2
		spawn(arrival_shuttle_tickstomove*60)   //60 sec
		if (start_arrival_shuttle_location == 1)
			fromArea = locate(/area/shuttle/arrival/spess)
			toArea = locate(/area/shuttle/arrival/station)
			a.autosay("\"Ashenvale\" transport shuttle has arrived to the [station_name()].", "Shuttle Autopilot")
		else
			fromArea = locate(/area/shuttle/arrival/spess)
			toArea = locate(/area/shuttle/arrival/pre_game)
			a.autosay("\"Ashenvale\" transport shuttle has arrived to the CentComm.", "Shuttle Autopilot")

		for(var/turf/T in toArea)
			dstturfs += T
			if(T.y < throwy)
				throwy = T.y

		// hey you, get out of the way!
		for(var/turf/T in dstturfs)
			// find the turf to move things to
			var/turf/D = locate(T.x, throwy - 1, 1)
			//var/turf/E = get_step(D, SOUTH)
			for(var/atom/movable/AM as mob|obj in T)
				AM.Move(D)
				// NOTE: Commenting this out to avoid recreating mass driver glitch
				/*
				spawn(0)
					AM.throw_at(E, 1, 1)
					return
				*/

			if(istype(T, /turf/simulated))
				del(T)

		for(var/mob/living/carbon/bug in toArea) // If someone somehow is still in the shuttle's docking area...
			bug.gib()
		if(start_arrival_shuttle_location)
			start_arrival_shuttle_location = 0
		else
			start_arrival_shuttle_location = 1
		arrival_shuttle_moving = 0
		del(a)