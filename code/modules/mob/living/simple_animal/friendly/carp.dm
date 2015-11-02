/* This space carp code is for a "friendly" version of the space carp.
I basically did what the community wanted me to and mashed together Ian's code and space carp code.
This space carp is going to be able to swim in water (but die outside of it)
Since there isn't water in space, the carp is going to die a tragic death in space.
Furthermore, since the fish can't survive in space, it won't be able to swim in space either!

Can we even call it a space carp anymore? (The answer is yes)
*/
/mob/living/simple_animal/friendly/carp
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

	var/max_oxygen = 10		//The maximum amount of oxygen the fish can store in its lungs
	var/oxygen_left = 10	//The amount of oxygen remaining in the space carp's fish lungs
	var/suffocation_damage = 5	//Amount of damage taken every second when suffocating

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

	//Turf or object containers the carp can breathe in.
	var/water_containers = list(/turf/unsimulated/beach/water,
								/turf/simulated/floor/beach/water,
								/turf/unsimulated/beach/coastline,	//The coastline is mostly covered by water
								/turf/simulated/floor/beach/coastline,
								/obj/item/weapon/watertank,
								/obj/structure/reagent_dispensers/watertank,
								/obj/structure/reagent_dispensers/water_cooler)

//Unlike other animals, the carp requires water to breathe. Or drink. Or something.
/mob/living/simple_animal/friendly/carp/Life()
	..()
	if(stat != DEAD)	//Reduces some unnecessary overhead in case someone decides to spawn 100 of these
		breathe()

/mob/living/simple_animal/friendly/carp/proc/breathe()
	if(in_water())
		reset_oxygen()
	else
		oxygen_left--
		if(oxygen_left < 0)
			adjustBruteLoss(suffocation_damage)
			if((health >= 0) && prob(50))	//Check to make sure the fish is still alive before we do the emote
				pick(emote("twitches weakly"), emote("breathes weakly"))
		else if(prob(30))
			emote("flops around gasping for water")

/mob/living/simple_animal/friendly/carp/proc/in_water()
	if(loc.type in water_containers)
		return 1
	else
		return 0

/mob/living/simple_animal/friendly/carp/proc/reset_oxygen()
	oxygen_left = max_oxygen

/mob/living/simple_animal/friendly/carp/Die()
	emote("exhales slowly as its eyes glass over")	//Carp can only emote right before they actually die.
	..()