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

/obj/machinery/computer/arrival_shuttle/Topic(href, href_list)
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
	if (arrival_shuttle_moving)
		return
	var/area/fromArea
	var/area/toArea
	var/obj/item/device/radio/intercom/a = new /obj/item/device/radio/intercom(null)
	if (arrival_shuttle_location == 1)
		fromArea = locate(/area/shuttle/arrival/pre_game)
		a.autosay("\"\"Ashenvale\" transport shuttle has started from the CentComm in 30 seconds.\"", "Shuttle Autopilot")
	else
		fromArea = locate(/area/shuttle/arrival/station)
		a.autosay("\"\"Ashenvale\" transport shuttle has started from the [station_name()] in 30 seconds.\"", "Shuttle Autopilot")
	toArea = locate(/area/shuttle/arrival/spess)
	start_arrival_shuttle_location = arrival_shuttle_location
	sleep(arrival_shuttle_tickstomove*30)
	fromArea.move_contents_to(toArea)
	for(var/mob/M in toArea)
		if(M.client)
			spawn()
				if(M.buckled)
					shake_camera(M, 4, 1)
				else
					shake_camera(M, 10, 2)
					M.stunned += 5
	arrival_shuttle_location = 0
	if (start_arrival_shuttle_location == 1)
		toArea = locate(/area/shuttle/arrival/station)
		a.autosay("\"\"Ashenvale\" transport shuttle has escape from the CentComm.\"", "Shuttle Autopilot")
	else
		toArea = locate(/area/shuttle/arrival/pre_game)
		a.autosay("\"\"Ashenvale\" transport shuttle has escape from the [station_name()].\"", "Shuttle Autopilot")
	fromArea = locate(/area/shuttle/arrival/spess)
	arrival_shuttle_location = 0
	sleep(arrival_shuttle_tickstomove*60)
	fromArea.move_contents_to(toArea)
	for(var/mob/M in toArea)
		if(M.client)
			spawn()
				if(M.buckled)
					shake_camera(M, 4, 1)
				else
					shake_camera(M, 10, 2)
					M.stunned += 5
	if(start_arrival_shuttle_location == 1)
		arrival_shuttle_location = 2
		a.autosay("\"\"Ashenvale\" transport shuttle has arrived to the [station_name()].\"", "Shuttle Autopilot")
	else
		arrival_shuttle_location = 1
		a.autosay("\"\"Ashenvale\" transport shuttle has arrived to the CentComm.\"", "Shuttle Autopilot")
	arrival_shuttle_moving = 0
	del(a)
	return

