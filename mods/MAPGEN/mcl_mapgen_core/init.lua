--
-- Aliases for map generator outputs
--

mcl_mapgen_core = {}

minetest.register_alias("mapgen_air", "air")
minetest.register_alias("mapgen_stone", "mcl_core:stone")
minetest.register_alias("mapgen_tree", "mcl_core:tree")
minetest.register_alias("mapgen_leaves", "mcl_core:leaves")
minetest.register_alias("mapgen_jungletree", "mcl_core:jungletree")
minetest.register_alias("mapgen_jungleleaves", "mcl_core:jungleleaves")
minetest.register_alias("mapgen_pine_tree", "mcl_core:darktree")
minetest.register_alias("mapgen_pine_needles", "mcl_core:darkleaves")

minetest.register_alias("mapgen_apple", "mcl_core:leaves")
minetest.register_alias("mapgen_water_source", "mcl_core:water_source")
minetest.register_alias("mapgen_dirt", "mcl_core:dirt")
minetest.register_alias("mapgen_dirt_with_grass", "mcl_core:dirt_with_grass")
minetest.register_alias("mapgen_dirt_with_snow", "mcl_core:dirt_with_snow")
minetest.register_alias("mapgen_sand", "mcl_core:sand")
minetest.register_alias("mapgen_gravel", "mcl_core:gravel")
minetest.register_alias("mapgen_clay", "mcl_core:clay")
minetest.register_alias("mapgen_lava_source", "mcl_core:lava_source")
minetest.register_alias("mapgen_cobble", "mcl_core:cobble")
minetest.register_alias("mapgen_mossycobble", "mcl_core:mossycobble")
minetest.register_alias("mapgen_junglegrass", "mcl_core:tallgrass")
minetest.register_alias("mapgen_stone_with_coal", "mcl_core:stone_with_coal")
minetest.register_alias("mapgen_stone_with_iron", "mcl_core:stone_with_iron")
minetest.register_alias("mapgen_desert_sand", "mcl_core:sand")
minetest.register_alias("mapgen_desert_stone", "mcl_core:sandstone")
minetest.register_alias("mapgen_sandstone", "mcl_core:sandstone")
minetest.register_alias("mapgen_river_water_source", "mcl_core:water_source")
minetest.register_alias("mapgen_snow", "mcl_core:snow")
minetest.register_alias("mapgen_snowblock", "mcl_core:snowblock")
minetest.register_alias("mapgen_ice", "mcl_core:ice")

minetest.register_alias("mapgen_stair_cobble", "stairs:stair_cobble")
minetest.register_alias("mapgen_sandstonebrick", "mcl_core:sandstonesmooth")
minetest.register_alias("mapgen_stair_sandstonebrick", "stairs:stair_sandstone")

--
-- Ore generation
--

-- Gravel
minetest.register_ore({
	ore_type       = "blob",
	ore            = "mcl_core:gravel",
	wherein        = {"mcl_core:stone"},
	clust_scarcity = 14*14*14,
	clust_num_ores = 33,
	clust_size     = 5,
	y_min          = -90,
	y_max          = 90,
})

--
-- Coal
--
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_coal",
	wherein        = "mcl_core:stone",
	clust_scarcity = 500,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min          = 13,
	y_max          = 31000,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_coal",
	wherein        = "mcl_core:stone",
	clust_scarcity = 500,
	clust_num_ores = 8,
	clust_size     = 3,
	y_min          = 12,
	y_max          = -12,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_coal",
	wherein        = "mcl_core:stone",
	clust_scarcity = 1000,
	clust_num_ores = 6,
	clust_size     = 3,
	y_min          = -11,
	y_max          = 64,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_coal",
	wherein        = "mcl_core:stone",
	clust_scarcity = 5000,
	clust_num_ores = 4,
	clust_size     = 2,
	y_min          = 65,
	y_max          = 67,
})

--
-- Iron
--
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_iron",
	wherein        = "mcl_core:stone",
	clust_scarcity = 830,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min          = -127,
	y_max          = -10,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_iron",
	wherein        = "mcl_core:stone",
	clust_scarcity = 1660,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min          = -9,
	y_max          = 1,
})

--
-- Gold
--
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_gold",
	wherein        = "mcl_core:stone",
	clust_scarcity = 5000,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min          = -59,
	y_max          = -35,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_gold",
	wherein        = "mcl_core:stone",
	clust_scarcity = 10000,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min          = -35,
	y_max          = -33,
})

--
-- Diamond
--
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_diamond",
	wherein        = "mcl_core:stone",
	clust_scarcity = 10000,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min          = -59,
	y_max          = -48,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_diamond",
	wherein        = "mcl_core:stone",
	clust_scarcity = 5000,
	clust_num_ores = 2,
	clust_size     = 2,
	y_min          = -59,
	y_max          = -48,
})
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_diamond",
	wherein        = "mcl_core:stone",
	clust_scarcity = 10000,
	clust_num_ores = 8,
	clust_size     = 3,
	y_min          = -55,
	y_max          = -52,
})

--
-- Redstone
--

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_redstone",
	wherein        = "mcl_core:stone",
	clust_scarcity = 10000,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min          = -59,
	y_max          = -48,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_redstone",
	wherein        = "mcl_core:stone",
	clust_scarcity = 10000,
	clust_num_ores = 10,
	clust_size     = 4,
	y_min          = -59,
	y_max          = -48,
})

--
-- Emerald
--

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_emerald",
	wherein        = "mcl_core:stone",
	clust_scarcity = 10000,
	clust_num_ores = 1,
	clust_size     = 2,
	y_min          = -59,
	y_max          = -35,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_emerald",
	wherein        = "mcl_core:stone",
	clust_scarcity = 50000,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min          = -59,
	y_max          = -35,
})

--
-- Lapis Lazuli
--

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_lapis",
	wherein        = "mcl_core:stone",
	clust_scarcity = 10000,
	clust_num_ores = 7,
	clust_size     = 4,
	y_min          = -50,
	y_max          = -46,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "mcl_core:stone_with_lapis",
	wherein        = "mcl_core:stone",
	clust_scarcity = 10000,
	clust_num_ores = 5,
	clust_size     = 4,
	y_min          = -59,
	y_max          = -50,
})

local function register_mgv6_decorations()
	minetest.clear_registered_decorations()

	-- Sugar canes

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"mcl_core:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 100, y = 100, z = 100},
			seed = 2,
			octaves = 3,
			persist = 0.7
		},
		y_min = 1,
		y_max = 1,
		decoration = "mcl_core:reeds",
		height = 2,
		height_max = 4,
		spawn_by = "mcl_core:water_source",
		num_spawn_by = 1,
	})

	-- Cacti

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"mcl_core:sand", "mcl_core:redsand"},
		sidelen = 16,
		noise_params = {
			offset = -0.012,
			scale = 0.024,
			spread = {x = 100, y = 100, z = 100},
			seed = 257,
			octaves = 3,
			persist = 0.6
		},
		y_min = 3,
		y_max = 30,
		decoration = "mcl_core:cactus",
		height = 1,
	        height_max = 3,
	})

	-- Tall grasses

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"mcl_core:dirt_with_grass"},
		sidelen = 8,
		noise_params = {
			offset = 0,
			scale = 0.05,
			spread = {x = 50, y = 50, z = 50},
			seed = 420,
			octaves = 2,
			persist = 0.6
		},
		y_min = 1,
		y_max = 30,
		decoration = "mcl_core:tallgrass",
	})

	-- Dead bushes

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"mcl_core:sand", "mcl_core:redsand", "mcl_core:podzol", "mcl_core:coarse_dirt", "mcl_colorblocks:hardened_clay"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.035,
			spread = {x = 100, y = 100, z = 100},
			seed = 1972,
			octaves = 3,
			persist = 0.6
		},
		y_min = 3,
		y_max = 50,
		decoration = "mcl_core:deadbush",
	})

end

register_mgv6_decorations()


minetest.register_on_generated(function(minp, maxp, seed)
	if maxp.y >= 2 and minp.y <= 0 then
		-- Generate clay
		-- Assume X and Z lengths are equal
		local divlen = 4
		local divs = (maxp.x-minp.x)/divlen+1;
		for divx=0+1,divs-1-1 do
		for divz=0+1,divs-1-1 do
			local cx = minp.x + math.floor((divx+0.5)*divlen)
			local cz = minp.z + math.floor((divz+0.5)*divlen)
			if minetest.get_node({x=cx,y=1,z=cz}).name == "mcl_core:water_source" and
					minetest.get_node({x=cx,y=0,z=cz}).name == "mcl_core:sand" then
				local is_shallow = true
				local num_water_around = 0
				if minetest.get_node({x=cx-divlen*2,y=1,z=cz+0}).name == "mcl_core:water_source" then
					num_water_around = num_water_around + 1 end
				if minetest.get_node({x=cx+divlen*2,y=1,z=cz+0}).name == "mcl_core:water_source" then
					num_water_around = num_water_around + 1 end
				if minetest.get_node({x=cx+0,y=1,z=cz-divlen*2}).name == "mcl_core:water_source" then
					num_water_around = num_water_around + 1 end
				if minetest.get_node({x=cx+0,y=1,z=cz+divlen*2}).name == "mcl_core:water_source" then
					num_water_around = num_water_around + 1 end
				if num_water_around >= 2 then
					is_shallow = false
				end	
				if is_shallow then
					for x1=-divlen,divlen do
					for z1=-divlen,divlen do
						if minetest.get_node({x=cx+x1,y=0,z=cz+z1}).name == "mcl_core:sand" or minetest.get_node({x=cx+x1,y=0,z=cz+z1}).name == "mcl_core:sandstone" then
							minetest.set_node({x=cx+x1,y=0,z=cz+z1}, {name="mcl_core:clay"})
						end
					end
					end
				end
			end
		end
		end
		-- Generate reeds
		local perlin1 = minetest.get_perlin(354, 3, 0.7, 100)
		-- Assume X and Z lengths are equal
		local divlen = 8
		local divs = (maxp.x-minp.x)/divlen+1;
		for divx=0,divs-1 do
		for divz=0,divs-1 do
			local x0 = minp.x + math.floor((divx+0)*divlen)
			local z0 = minp.z + math.floor((divz+0)*divlen)
			local x1 = minp.x + math.floor((divx+1)*divlen)
			local z1 = minp.z + math.floor((divz+1)*divlen)
			-- Determine reeds amount from perlin noise
			local reeds_amount = math.floor(perlin1:get2d({x=x0, y=z0}) * 45 - 20)
			-- Find random positions for reeds based on this random
			local pr = PseudoRandom(seed+1)
			for i=0,reeds_amount do
				local x = pr:next(x0, x1)
				local z = pr:next(z0, z1)
				local p = {x=x,y=1,z=z}
				if minetest.get_node(p).name == "mcl_core:sand" then
					if math.random(0,1000) == 1 then -- 0,12000
						-- Spawn sand temple
						random_struct.call_struct(p,2)
					end
				end

			end
		end
		end
		-- Generate grass
		local perlin1 = minetest.get_perlin(329, 3, 0.6, 100)
		-- Assume X and Z lengths are equal
		local divlen = 5
		local divs = (maxp.x-minp.x)/divlen+1;
		for divx=0,divs-1 do
		for divz=0,divs-1 do
			local x0 = minp.x + math.floor((divx+0)*divlen)
			local z0 = minp.z + math.floor((divz+0)*divlen)
			local x1 = minp.x + math.floor((divx+1)*divlen)
			local z1 = minp.z + math.floor((divz+1)*divlen)
			-- Determine grass amount from perlin noise
			local grass_amount = math.floor(perlin1:get2d({x=x0, y=z0}) * 9)
			-- Find random positions for grass based on this random
			local pr = PseudoRandom(seed+1)
			for i=0,grass_amount do
				local x = pr:next(x0, x1)
				local z = pr:next(z0, z1)
				-- Find ground level (0...15)
				local ground_y = nil
				for y=30,0,-1 do
					if minetest.get_node({x=x,y=y,z=z}).name ~= "air" then
						ground_y = y
						break
					end
				end
				
				if ground_y then
					local p = {x=x,y=ground_y+1,z=z}
					local nn = minetest.get_node(p).name
					-- Check if the node can be replaced
					if minetest.registered_nodes[nn] and
						minetest.registered_nodes[nn].buildable_to then
						nn = minetest.get_node({x=x,y=ground_y,z=z}).name
						if nn == "mcl_core:dirt_with_grass" then
							if math.random(0,12000) == 1 then 
								-- Spawn town
								-- TODO: Re-enable random_struct
								-- Towns often float around in air which doesn't look nice
								--random_struct.call_struct(p,1)
							end
						end
					end
				end
				
			end
		end
		end
	end
end)

local function replace(old, new, min, max)
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = new,
		wherein        = old,
		clust_scarcity = 1,
		clust_num_ores = 1,
		clust_size     = 1,
		y_min          = min,
		y_max          = max,
	})
end
replace("air", "mcl_core:bedrock", -90, -80)
replace("air", "mcl_core:lava_source", -80, -70)
replace("mcl_core:stone", "mcl_core:bedrock", -90, -80)
replace("mcl_core:gravel", "mcl_core:bedrock", -90, -80)
replace("mcl_core:dirt", "mcl_core:bedrock", -90, -80)
replace("mcl_core:sand", "mcl_core:bedrock", -90, -80)
replace("mcl_core:cobble", "mcl_core:bedrock", -90, -80)
replace("mcl_core:mossycobble", "mcl_core:bedrock", -90, -80)
replace("stairs:stair_cobble", "mcl_core:bedrock", -90, -80)
replace("mcl_core:lava_source", "mcl_core:bedrock", -90, -80)
replace("mcl_core:lava_flowing", "mcl_core:bedrock", -90, -80)
replace("mcl_core:water_source", "mcl_core:bedrock", -90, -80)
replace("mcl_core:water_flowing", "mcl_core:bedrock", -90, -80)

local function bedrock(old)
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "mcl_core:bedrock",
		wherein        = old,
		clust_scarcity = 5,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -64,
		y_max          = -60,
	})
end
bedrock("air")
bedrock("mcl_core:stone")
bedrock("mcl_core:gravel")
bedrock("mcl_core:dirt")
bedrock("mcl_core:sand")
bedrock("mcl_core:cobble")
bedrock("mcl_core:mossycobble")
bedrock("stairs:stair_cobble")
bedrock("mcl_core:lava_source")
bedrock("mcl_core:lava_flowing")
bedrock("mcl_core:water_source")
bedrock("mcl_core:water_flowing")

