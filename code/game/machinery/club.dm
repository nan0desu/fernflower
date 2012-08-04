//var/global/list/hearers
//var/global/list/new_hearers

/obj/machinery/club/lightmusic
	name = "Light music"
	desc = "."
	icon = 'device.dmi'
	icon_state = "locator"
	var/on = 0
	var/error = 0
	var/speed = 0
	New()
		sleep(30)
		for(var/obj/effect/overlay/bluelight/T in world)
			T.icon_state = "invi"
		for(var/obj/effect/overlay/bluelight/T in world)
			if(T.icon_state == "lightblue")
				T.icon_state = "invi"
				if(!error)
					sleep(900)
					message_admins("ERROR: Bluelight overlays have bug, please, report to coders.")
					error = 1

/obj/machinery/club/lightmusic/attack_hand()
	var/dat = {"<B> Valve properties: </B>
	<BR> <B> Speed:</B>[speed != 0 ? "<A href='?src=\ref[src];speed_0=1'>0</A>" : "0"]
	<B> </B> [speed != 1 ? "<A href='?src=\ref[src];speed_1=1'>1</A>" : "1"]
	<B> </B> [speed != 2 ? "<A href='?src=\ref[src];speed_2=1'>2</A>" : "2"]
	<B> </B> [speed != 3 ? "<A href='?src=\ref[src];speed_3=1'>3</A>" : "3"]"}

	usr << browse(dat, "window=light_music;size=600x300")
	onclose(usr, "light_music")
	return

/obj/machinery/club/lightmusic/Topic(href, href_list)
	..()
	if ( usr.stat || usr.restrained() )
		return
	if(href_list["speed_0"])
		sleep(10)
		for(var/obj/effect/overlay/bluelight/T in world)
			T.icon_state = "invi"
			speed = 0
			return
	else if(href_list["speed_1"])
		usr << "Function is not alliwed for now."
		return
	else if(href_list["speed_2"])
		sleep(10)
		for(var/obj/effect/overlay/bluelight/T in world)
			T.icon_state = "blinkblue"
		sleep(3)
		for(var/obj/effect/overlay/bluelight/T in world)
			if(T.icon_state == "invi")
				T.icon_state = "blinkblue"
				if(error != 2)
					message_admins("ERROR: Bluelight overlays have bug, please, report to coders.")
					error = 2
		speed = 2
		return
	else if(href_list["speed_3"])
		usr << "Function is not alliwed for now."
		return
	return

/turf/simulated/floor/clubfloor
	icon_state = "bcircuitoff"

/*obj/machinery/club/player
	name = "Player"
	desc = "."
	icon = 'device.dmi'
	icon_state = "locator"
	var/on = 0
	var/playing_track = null
	var/list/playing = null
	process()
		playing = hearers - new_hearers
		for(var/mob/M in playing)
			M << playsound(null)
		if(playing_track)
			playing = new_hearers - hearers
			for(var/mob/M in playing)
				M << playsound(playing_track)
		else
			for(var/mob/C in new_hearers)
				C << playsound(null)
		hearers = new_hearers



/obj/machinery/club/player/attack_hand()
	playing_track = "Space Assgole.wma"
*/