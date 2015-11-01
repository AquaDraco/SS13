/* This space carp code is for a "friendly" version of the space carp.
I basically did what the community wanted me to and mashed together Ian's code and space carp code.
*/
/mob/living/simple_animal/carp
	name = "space carp"		//Note to self, get community to pick a name.
	desc = "A friendly, bubble-blowing creature that resembles a fish."
	icon_state = "carp"
	icon_living = "carp"
	icon_dead = "carp_dead"
	icon_gib = "carp_gib"
	speak = list("Blub-blub", "Blub", "Blub?", "Blub!")
	speak_emote = list("blubs")
	emote_hear = list("blubs")
	emote_see = list("blows bubbles softly into the air")
	speak_chance = 1
	turns_per_move = 10
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/carpmeat
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "hits"
	friendly = "blows bubbles at"
	see_in_dark = 5
	speed = 0
	maxHealth = 25	//Keeping health low to keep carp from being used as shield
	health = 25

	//Space carp aren't affected by cold.
	min_oxy = 0
	max_oxy = 0
	min_tox = 0
	max_tox = 0
	min_co2 = 0
	max_co2 = 0
	min_n2 = 0
	max_n2 = 0
	minbodytemp = 0
	maxbodytemp = 1500

	faction = "carp"	//This is to keep hostile space carp from attacking their domesticated cousins

//This proc was copied from the original space carp code, including the comments.
//I wonder if this counts as stealing comments?
/mob/living/simple_animal/carp/Process_Spacemove(var/check_drift = 0)
	return 1	//No drifting in space for space carp!	//original comments do not steal