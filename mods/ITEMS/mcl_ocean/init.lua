-- Nodes

minetest.register_node("mcl_ocean:sea_lantern", {
	description = "Sea Lantern",
	paramtype2 = "facedir",
	is_ground_content = false,
	stack_max = 64,
	-- Real light level: 15 (but Minetest caps at 14)
	light_source = 14,
	drop = {
		max_items = 1,
		items = {
			{ items = {'mcl_ocean:prismarine_crystals 3'}, rarity = 2 },
			{ items = {'mcl_ocean:prismarine_crystals 2'}}
		}
	},
	tiles = {{name="mcl_ocean_sea_lantern.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=1.25}}},
	groups = {oddly_breakable_by_hand=3, building_block=1},
	sounds = mcl_sounds.node_sound_glass_defaults(),
})

minetest.register_node("mcl_ocean:prismarine", {
	description = "Prismarine",
	stack_max = 64,
	is_ground_content = false,
	tiles = {{name="mcl_ocean_prismarine_anim.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=45.0}}},
	groups = {cracky=3, building_block=1},
	sounds = mcl_sounds.node_sound_stone_defaults(),
})

minetest.register_node("mcl_ocean:prismarine_brick", {
	description = "Prismarine Bricks",
	stack_max = 64,
	is_ground_content = false,
	tiles = {"mcl_ocean_prismarine_bricks.png"},
	groups = {cracky=2, building_block=1},
	sounds = mcl_sounds.node_sound_stone_defaults(),
})

minetest.register_node("mcl_ocean:prismarine_dark", {
	description = "Dark Prismarine",
	stack_max = 64,
	is_ground_content = false,
	tiles = {"mcl_ocean_prismarine_dark.png"},
	groups = {cracky=2, building_block=1},
	sounds = mcl_sounds.node_sound_stone_defaults(),
})

-- Craftitems

minetest.register_craftitem("mcl_ocean:prismarine_crystals", {
	description = "Prismarine Crystals",
	inventory_image = "mcl_ocean_prismarine_crystals.png",
	stack_max = 64,
	groups = { craftitem = 1 },
})

minetest.register_craftitem("mcl_ocean:prismarine_shard", {
	description = "Prismarine Shard",
	inventory_image = "mcl_ocean_prismarine_shard.png",
	stack_max = 64,
	groups = { craftitem = 1 },
})

-- Crafting

minetest.register_craft({
	output = 'mcl_ocean:sea_lantern',
	recipe = {
		{'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_crystals', 'mcl_ocean:prismarine_shard'},
		{'mcl_ocean:prismarine_crystals', 'mcl_ocean:prismarine_crystals', 'mcl_ocean:prismarine_crystals'},
		{'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_crystals', 'mcl_ocean:prismarine_shard'},
	}
})

minetest.register_craft({
	output = 'mcl_ocean:prismarine',
	recipe = {
		{'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard'},
		{'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard'},
	}
})

minetest.register_craft({
	output = 'mcl_ocean:prismarine_brick',
	recipe = {
		{'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard'},
		{'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard'},
		{'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard'},
	}
})

minetest.register_craft({
	output = 'mcl_ocean:prismarine_dark',
	recipe = {
		{'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard'},
		{'mcl_ocean:prismarine_shard', 'mcl_dye:black', 'mcl_ocean:prismarine_shard'},
		{'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard', 'mcl_ocean:prismarine_shard'},
	}
})

