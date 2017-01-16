-- TODO: Add special status effects for raw flesh

minetest.register_craftitem("mcl_mobitems:rotten_flesh", {
	description = "Rotten Flesh",
	inventory_image = "mcl_mobitems_rotten_flesh.png",
	wield_image = "mcl_mobitems_rotten_flesh.png",
	-- TODO: Raise to 4
	on_use = minetest.item_eat(1),
	groups = { food = 2, eatable = 1 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:mutton", {
	description = "Raw Mutton",
	inventory_image = "mcl_mobitems_mutton_raw.png",
	wield_image = "mcl_mobitems_mutton_raw.png",
	on_use = minetest.item_eat(2),
	groups = { food = 2, eatable = 2 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:cooked_mutton", {
	description = "Cooked Mutton",
	inventory_image = "mcl_mobitems_mutton_cooked.png",
	wield_image = "mcl_mobitems_mutton_cooked.png",
	on_use = minetest.item_eat(6),
	groups = { food = 2, eatable = 6 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:beef", {
	description = "Raw Beef",
	inventory_image = "mcl_mobitems_beef_raw.png",
	wield_image = "mcl_mobitems_beef_raw.png",
	on_use = minetest.item_eat(3),
	groups = { food = 2, eatable = 3 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:cooked_beef", {
	description = "Steak",
	inventory_image = "mcl_mobitems_beef_cooked.png",
	wield_image = "mcl_mobitems_beef_cooked.png",
	on_use = minetest.item_eat(8),
	groups = { food = 2, eatable = 8 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:chicken", {
	description = "Raw Chicken",
	inventory_image = "mcl_mobitems_chicken_raw.png",
	wield_image = "mcl_mobitems_chicken_raw.png",
	on_use = minetest.item_eat(2),
	groups = { food = 2, eatable = 2 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:cooked_chicken", {
	description = "Cooked Chicken",
	inventory_image = "mcl_mobitems_chicken_cooked.png",
	wield_image = "mcl_mobitems_chicken_cooked.png",
	on_use = minetest.item_eat(6),
	groups = { food = 2, eatable = 6 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:porkchop", {
	description = "Raw Porkchop",
	inventory_image = "mcl_mobitems_porkchop_raw.png",
	wield_image = "mcl_mobitems_porkchop.png",
	on_use = minetest.item_eat(3),
	groups = { food = 2, eatable = 3 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:cooked_porkchop", {
	description = "Cooked Porkchop",
	inventory_image = "mcl_mobitems_porkchop_cooked.png",
	wield_image = "mcl_mobitems_porkchop_cooked.png",
	on_use = minetest.item_eat(8),
	groups = { food = 2, eatable = 8 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:rabbit", {
	description = "Raw Rabbit",
	inventory_image = "mcl_mobitems_rabbit_raw.png",
	wield_image = "mcl_mobitems_rabbit_raw.png",
	on_use = minetest.item_eat(3),
	groups = { food = 2, eatable = 3 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:cooked_rabbit", {
	description = "Cooked Rabbit",
	inventory_image = "mcl_mobitems_rabbit_cooked.png",
	wield_image = "mcl_mobitems_rabbit_cooked.png",
	on_use = minetest.item_eat(5),
	groups = { food = 2, eatable = 5 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:spider_eye", {
	description = "Spider Eye",
	inventory_image = "mcl_mobitems_spider_eye.png",
	wield_image = "mcl_mobitems_spider_eye.png",
	on_use = minetest.item_eat(2),
	groups = { food = 2, eatable = 2 },
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:blaze_rod", {
	description = "Blaze Rod",
	wield_image = "mcl_mobitems_blaze_rod.png",
	inventory_image = "mcl_mobitems_blaze_rod.png",
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:blaze_powder", {
	description = "Blaze Powder",
	wield_image = "mcl_mobitems_blaze_powder.png",
	inventory_image = "mcl_mobitems_blaze_powder.png",
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:magma_cream", {
	description = "Magma Cream",
	wield_image = "mcl_mobitems_magma_cream.png",
	inventory_image = "mcl_mobitems_magma_cream.png",
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:ghast_tear", {
	description = "Ghast Tear",
	wield_image = "mcl_mobitems_ghast_tear.png",
	inventory_image = "mcl_mobitems_ghast_tear.png",
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:nether_star", {
	description = "Nether Star",
	wield_image = "mcl_mobitems_nether_star.png",
	inventory_image = "mcl_mobitems_nether_star.png",
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:leather", {
	description = "Leather",
	wield_image = "mcl_mobitems_leather.png",
	inventory_image = "mcl_mobitems_leather.png",
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:egg", {
	description = "Egg",
	inventory_image = "mcl_mobitems_rotten_flesh.png",
	wield_image = "mcl_mobitems_rotten_flesh.png",
	stack_max = 16,
	
})

minetest.register_craftitem("mcl_mobitems:feather", {
	description = "Feather",
	wield_image = "mcl_mobitems_feather.png",
	inventory_image = "mcl_mobitems_feather.png",
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:rabbit_hide", {
	description = "Rabbit Hide",
	wield_image = "mcl_mobitems_rabbit_hide.png",
	inventory_image = "mcl_mobitems_rabbit_hide.png",
	stack_max = 64,
})

minetest.register_craftitem("mcl_mobitems:rabbit_foot", {
	description = "Rabbit's Foot",
	wield_image = "mcl_mobitems_rabbit_foot.png",
	inventory_image = "mcl_mobitems_rabbit_foot.png",
	stack_max = 64,
})

-----------
-- Crafting
-----------

minetest.register_craft({
	output = "mcl_mobitems:leather",
	recipe = {
		{ "mcl_mobitems:rabbit_hide", "mcl_mobitems:rabbit_hide" },
		{ "mcl_mobitems:rabbit_hide", "mcl_mobitems:rabbit_hide" },
	}
})

minetest.register_craft({
	output = "mcl_mobitems:blaze_powder 2",
	recipe = {{"mcl_mobitems:blaze_rod"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "mcl_mobitems:magma_cream",
	recipe = {"mcl_mobitems:blaze_powder", "mesecons_materials:glue"},
})

minetest.register_craft({
	type = "cooking",
	output = "mcl_mobitems:cooked_mutton",
	recipe = "mcl_mobitems:mutton",
	cooktime = 10,
})

minetest.register_craft({
	type = "cooking",
	output = "mcl_mobitems:cooked_rabbit",
	recipe = "mcl_mobitems:rabbit",
	cooktime = 10,
})

minetest.register_craft({
	type = "cooking",
	output = "mcl_mobitems:cooked_chicken",
	recipe = "mcl_mobitems:chicken",
	cooktime = 10,
})

minetest.register_craft({
	type = "cooking",
	output = "mcl_mobitems:cooked_beef",
	recipe = "mcl_mobitems:beef",
	cooktime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "mcl_mobitems:blaze_rod",
	burntime = 120,
})

-- Temporary helper recipes
-- TODO: Remove them
minetest.register_craft({
	type = "shapeless",
	output = "mcl_mobitems:leather",
	recipe = { "default:paper", "default:paper" },
})
minetest.register_craft({
	output = "mcl_mobitems:feather 3",
	recipe = {
		{ "flowers:oxeye_daisy" },
		{ "flowers:oxeye_daisy" },
	}
})

