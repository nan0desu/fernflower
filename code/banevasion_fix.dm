/client/New()
	var/isbanned = 1
	var/bypassing = 0
	if(src.address == src.address)
		bypassing = 1
	if (isbanned)
		log_access("Failed Login: Banned")
		message_admins("\blue Failed Login: Banned")
		alert(src,"You have been banned.","Ban","Ok")
	if(bypassing)
		log_access("Failed Login: Attempted ban evasion.")
		message_admins("\blue Failed Login: Attempted ban evasion.")
		alert(src,"You have been banned.","Attempted Ban Evasion","Ok")

/mob/Logout()
	var/bypassing = 0
	if(!bypassing)

