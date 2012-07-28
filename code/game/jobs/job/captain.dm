/datum/job/captain
	title = "Captain"
	flag = CAPTAIN
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Nanotrasen officials and Space law"
	selection_color = "#ccccff"
	idtype = /obj/item/weapon/card/id/gold


	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_if_possible(new /obj/item/device/radio/headset/heads/captain(H), H.slot_ears)
		if(H.backbag == 2) H.equip_if_possible(new /obj/item/weapon/storage/backpack(H), H.slot_back)
		if(H.backbag == 3) H.equip_if_possible(new /obj/item/weapon/storage/backpack/satchel(H), H.slot_back)
		if(H.backbag == 4) H.equip_if_possible(new /obj/item/weapon/storage/backpack/satchel_norm(H), H.slot_back)
		H.equip_if_possible(new /obj/item/clothing/under/rank/captain(H), H.slot_w_uniform)
		H.equip_if_possible(new /obj/item/device/pda/captain(H), H.slot_belt)
		H.equip_if_possible(new /obj/item/clothing/shoes/brown(H), H.slot_shoes)
		H.equip_if_possible(new /obj/item/clothing/head/caphat(H), H.slot_head)
		H.equip_if_possible(new /obj/item/clothing/glasses/sunglasses(H), H.slot_glasses)
		if(H.backbag == 1)
			H.equip_if_possible(new /obj/item/weapon/storage/id_kit(H), H.slot_r_hand)
		else
			H.equip_if_possible(new /obj/item/weapon/storage/id_kit(H.back), H.slot_in_backpack)
		world << "<b>[H.real_name] is the captain!</b>"
		return 1



/datum/job/hop
	title = "Head of Personnel"
	flag = HOP
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the captain"
	selection_color = "#ddddff"
	idtype = /obj/item/weapon/card/id/silver


	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_if_possible(new /obj/item/device/radio/headset/heads/hop(H), H.slot_ears)
		if(H.backbag == 2) H.equip_if_possible(new /obj/item/weapon/storage/backpack(H), H.slot_back)
		if(H.backbag == 3) H.equip_if_possible(new /obj/item/weapon/storage/backpack/satchel(H), H.slot_back)
		if(H.backbag == 4) H.equip_if_possible(new /obj/item/weapon/storage/backpack/satchel_norm(H), H.slot_back)
		H.equip_if_possible(new /obj/item/clothing/under/rank/head_of_personnel(H), H.slot_w_uniform)
		H.equip_if_possible(new /obj/item/clothing/shoes/brown(H), H.slot_shoes)
		H.equip_if_possible(new /obj/item/device/pda/heads/hop(H), H.slot_belt)
		H.equip_if_possible(new /obj/item/clothing/suit/armor/vest(H), H.slot_wear_suit)
		H.equip_if_possible(new /obj/item/clothing/head/helmet(H), H.slot_head)
		H.equip_if_possible(new /obj/item/clothing/gloves/blue(H), H.slot_gloves)
		if(H.backbag == 1)
			H.equip_if_possible(new /obj/item/weapon/storage/id_kit(H), H.slot_r_hand)
		else
			H.equip_if_possible(new /obj/item/weapon/storage/id_kit(H.back), H.slot_in_backpack)
		return 1

/datum/job/internalsecurity
	title = "Internal Security"
	flag = INTERNALSECURITY
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 2
	spawn_positions = 2


	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_if_possible(new /obj/item/weapon/storage/backpack/security (H), H.slot_back)
		H.equip_if_possible(new /obj/item/weapon/storage/box/survival(H.back), H.slot_in_backpack)
		H.equip_if_possible(new /obj/item/device/radio/headset/heads/captain(H), H.slot_ears)
		H.equip_if_possible(new /obj/item/clothing/under/internalsecurity(H), H.slot_w_uniform)
		H.equip_if_possible(new /obj/item/clothing/shoes/brown(H), H.slot_shoes)
		H.equip_if_possible(new /obj/item/device/pda/heads/hos(H), H.slot_belt)
		H.equip_if_possible(new /obj/item/clothing/suit/armor/internalsecurity(H), H.slot_wear_suit)
		H.equip_if_possible(new /obj/item/clothing/gloves/white(H), H.slot_gloves)
		H.equip_if_possible(new /obj/item/clothing/head/internalsecurity(H), H.slot_head)
		H.equip_if_possible(new /obj/item/clothing/glasses/sunglasses/sechud(H), H.slot_glasses)
		H.equip_if_possible(new /obj/item/weapon/handcuffs(H), H.slot_in_backpack)
		H.equip_if_possible(new /obj/item/weapon/chem_grenade/sleepsmoke(H), H.slot_in_backpack)
		H.equip_if_possible(new /obj/item/weapon/gun/energy/elitetaser(H), H.slot_s_store)
		H.equip_if_possible(new /obj/item/device/internalsecurityflash(H), H.slot_l_store)
		H.equip_if_possible(new /obj/item/weapon/pepperspray/elited(H.back), H.slot_in_backpack)
		var/obj/item/weapon/implant/loyalty/L = new/obj/item/weapon/implant/loyalty(H)
		L.imp_in = H
		L.implanted = 1
		return 1


//COMMISSAR WHITELIST
var/list/whitelist_internal_security

/proc/load_whitelist_internal_security()
	var/text = file2text("data/whitelist_internal_security.txt")
	if (!text)
		diary << "Failed to load whitelist_internal_security.txt\n"
	else
		whitelist_internal_security = dd_text2list(text, "\n")

/proc/check_whitelist_internal_security(mob/M)
	if(!whitelist_internal_security)
		return 0
	return ("[M.ckey]" in whitelist_internal_security)
