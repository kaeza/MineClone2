--[[ This mod registers 3 nodes:
- One node for the horizontal-facing dispensers (mcl_dispensers:dispenser)
- One node for the upwards-facing dispensers (mcl_dispenser:dispenser_up)
- One node for the downwards-facing dispensers (mcl_dispenser:dispenser_down)

3 node definitions are needed because of the way the textures are defined.
All node definitions share a lot of code, so this is the reason why there
are so many weird tables below.
]]

-- For after_place_node
local setup_dispenser = function(pos)
	-- Set formspec and inventory
	local form = "size[9,8.75]"..
	"background[-0.19,-0.25;9.41,9.49;crafting_inventory_9_slots.png]"..
	mcl_vars.inventory_header..
	"image[3,-0.2;5,0.75;mcl_dispensers_fnt_dispenser.png]"..
	"list[current_player;main;0,4.5;9,3;9]"..
	"list[current_player;main;0,7.74;9,1;]"..
	"list[current_name;main;3,0.5;3,3;]"..
	"listring[current_name;main]"..
	"listring[current_player;main]"
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec", form)
	local inv = meta:get_inventory()
	inv:set_size("main", 9)
end

-- Shared core definition table
local dispenserdef = {
	is_ground_content = false,
	sounds = mcl_sounds.node_sound_stone_defaults(),
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local meta = minetest.get_meta(pos)
		local meta2 = meta
		meta:from_table(oldmetadata)
		local inv = meta:get_inventory()
		for i=1, inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				local p = {x=pos.x+math.random(0, 10)/10-0.5, y=pos.y, z=pos.z+math.random(0, 10)/10-0.5}
				minetest.add_item(p, stack)
			end
		end
		meta:from_table(meta2:to_table())
	end,
	mesecons = {effector = {
		-- Dispense random item when triggered
		action_on = function (pos, node)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local droppos, dropdir
			if node.name == "mcl_dispensers:dispenser" then
				dropdir = vector.multiply(minetest.facedir_to_dir(node.param2), -1)
				droppos = vector.add(pos, dropdir)
			elseif node.name == "mcl_dispensers:dispenser_up" then
				dropdir = {x=0, y=1, z=0}
				droppos  = {x=pos.x, y=pos.y+1, z=pos.z}
			elseif node.name == "mcl_dispensers:dispenser_down" then
				dropdir = {x=0, y=-1, z=0}
				droppos  = {x=pos.x, y=pos.y-1, z=pos.z}
			end
			local dropnode = minetest.get_node(droppos)
			-- Do not dispense into solid nodes
			local dropnodedef = minetest.registered_nodes[dropnode.name]
			if dropnodedef.walkable then
				return
			end
			local stacks = {}
			for i=1,inv:get_size("main") do
				local stack = inv:get_stack("main", i)
				if not stack:is_empty() then
					table.insert(stacks, {stack = stack, stackpos = i})
				end
			end
			if #stacks >= 1 then
				local r = math.random(1, #stacks)
				local stack = stacks[r].stack
				local dropitem = ItemStack(stack:get_name())
				local stack_id = stacks[r].stackpos
				local iname = stack:get_name()
				local igroups = minetest.registered_items[iname].groups

				--[===[ Dispense item ]===]
				if iname == "mcl_throwing:arrow" then
					-- Shoot arrow
					local shootpos = vector.add(pos, vector.multiply(dropdir, 0.51))
					local yaw = math.atan2(dropdir.z, dropdir.x) + math.pi/2
					mcl_throwing.shoot_arrow(iname, shootpos, dropdir, yaw, nil)

					stack:take_item()
					inv:set_stack("main", stack_id, stack)

				elseif iname == "mcl_throwing:egg" or iname == "mcl_throwing:snowball" then
					-- Throw egg or snowball
					local shootpos = vector.add(pos, vector.multiply(dropdir, 0.51))
					mcl_throwing.throw(iname, shootpos, dropdir)

					stack:take_item()
					inv:set_stack("main", stack_id, stack)

				elseif iname == "mcl_fire:fire_charge" then
					-- Throw fire charge
					local shootpos = vector.add(pos, vector.multiply(dropdir, 0.51))
					local fireball = minetest.add_entity(shootpos, "mobs_mc:blaze_fireball")
					local ent = fireball:get_luaentity()
					local v = ent.velocity or 1
					fireball:setvelocity(vector.multiply(dropdir, v))
					ent.switch = 1

					stack:take_item()
					inv:set_stack("main", stack_id, stack)

				elseif iname == "mcl_fire:flint_and_steel" then
					-- Ignite air or fire
					if dropnode.name == "air" then
						minetest.add_node(droppos, {name="mcl_fire:basic_flame"})
						if not minetest.setting_getbool("creative_mode") then
							stack:add_wear(65535/65) -- 65 uses
						end
					elseif dropnode.name == "mcl_tnt:tnt" then
						tnt.ignite(droppos)
						if not minetest.setting_getbool("creative_mode") then
							stack:add_wear(65535/65) -- 65 uses
						end
					end

					inv:set_stack("main", stack_id, stack)
				elseif iname == "mcl_tnt:tnt" then
					-- Place and ignite TNT
					if dropnodedef.buildable_to then
						minetest.set_node(droppos, {name = iname})
						tnt.ignite(droppos)

						stack:take_item()
						inv:set_stack("main", stack_id, stack)
					end
				elseif iname == "bucket:bucket_empty" then
					-- Fill empty bucket with liquid or drop bucket if no liquid
					local collect_liquid = false
					local bucket_id
					if dropnode.name == "mcl_core:water_source" then
						collect_liquid = true
						bucket_id = "bucket:bucket_water"
					elseif dropnode.name == "mcl_core:lava_source" then
						collect_liquid = true
						bucket_id = "bucket:bucket_lava"
					end
					if collect_liquid then
						minetest.set_node(droppos, {name="air"})

						-- Fill bucket with liquid and put it back into inventory
						-- if there's still space. If not, drop it.
						stack:take_item()
						inv:set_stack("main", stack_id, stack)

						local new_bucket = ItemStack(bucket_id)
						if inv:room_for_item("main", new_bucket) then
							inv:add_item("main", new_bucket)
						else
							minetest.add_item(droppos, dropitem)
						end
					else
						-- No liquid found: Drop empty bucket
						minetest.add_item(droppos, dropitem)

						stack:take_item()
						inv:set_stack("main", stack_id, stack)
					end
				elseif iname == "bucket:bucket_water" or iname == "bucket:bucket_lava" then
					-- Place water/lava source
					if dropnodedef.buildable_to then
						if iname == "bucket:bucket_water" then
							minetest.set_node(droppos, {name = "mcl_core:water_source"})
						elseif iname == "bucket:bucket_lava" then
							minetest.set_node(droppos, {name = "mcl_core:lava_source"})
						end

						stack:take_item()
						inv:set_stack("main", stack_id, stack)

						if inv:room_for_item("main", "bucket:bucket_empty") then
							inv:add_item("main", "bucket:bucket_empty")
						else
							minetest.add_item(droppos, dropitem)
						end
					end

				elseif igroups.head or igroups.shulker_box or iname == "mcl_farming:pumpkin_face" then
					-- Place head, shulker box, or pumpkin
					if dropnodedef.buildable_to then
						minetest.set_node(droppos, {name = iname, param2 = node.param2})

						stack:take_item()
						inv:set_stack("main", stack_id, stack)
					end

				elseif iname == "mcl_dye:white" then
					-- Apply bone meal, if possible
					if dropnode.name == "air" then
						pointed_thing = { above = droppos, under = { x=droppos.x, y=droppos.y-1, z=droppos.z } }
					else
						pointed_thing = { above = pos, under = droppos }
					end
					local success = mcl_dye.apply_bone_meal(pointed_thing)
					if success then
						stack:take_item()
						inv:set_stack("main", stack_id, stack)
					end

				elseif iname == "mcl_minecarts:minecart" then
					-- Place minecart as entity on rail
					if dropnodedef.groups.rail then
						minetest.add_entity(droppos, "mcl_minecarts:minecart")

					else
						-- Drop item
						minetest.add_item(droppos, dropitem)

					end

					stack:take_item()
					inv:set_stack("main", stack_id, stack)

				elseif igroups.boat then
					local below = {x=droppos.x, y=droppos.y-1, z=droppos.z}
					local belownode = minetest.get_node(below)
					-- Place boat as entity on or in water
					if dropnodedef.groups.water or (dropnode.name == "air" and minetest.registered_nodes[belownode.name].groups.water) then
						minetest.add_entity(droppos, "mcl_boats:boat")
					else
						minetest.add_item(droppos, dropitem)
					end

					stack:take_item()
					inv:set_stack("main", stack_id, stack)

				elseif igroups.armor_head or igroups.armor_torso or igroups.armor_legs or igroups.armor_feet then
					local armor_type, armor_slot
					if igroups.armor_head then
						armor_type = "armor_head"
						armor_slot = 2
					elseif igroups.armor_torso then
						armor_type = "armor_torso"
						armor_slot = 3
					elseif igroups.armor_legs then
						armor_type = "armor_legs"
						armor_slot = 4
					elseif igroups.armor_feet then
						armor_type = "armor_feet"
						armor_slot = 5
					end

					local droppos_below = {x=droppos.x, y=droppos.y-1, z=droppos.z}
					local dropnode_below = minetest.get_node(droppos_below)
					-- Put armor on player or armor stand
					local standpos
					if dropnode.name == "3d_armor_stand:armor_stand" then
						standpos = droppos
					elseif dropnode_below.name == "3d_armor_stand:armor_stand" then
						standpos = droppos_below
					end
					if standpos then
						local dropmeta = minetest.get_meta(standpos)
						local dropinv = dropmeta:get_inventory()
						if dropinv:room_for_item(armor_type, dropitem) then
							dropinv:add_item(armor_type, dropitem)
							--[[ FIXME: For some reason, this function is not called after calling add_item,
							so we call it manually to update the armor stand entity.
							This may need investigation and the following line may be a small hack. ]]
							minetest.registered_nodes["3d_armor_stand:armor_stand"].on_metadata_inventory_put(standpos)
							stack:take_item()
							inv:set_stack("main", stack_id, stack)
						end
					else
						-- Put armor on nearby player
						-- First search for player in front of dispenser (check 2 nodes)
						local objs1 = minetest.get_objects_inside_radius(droppos, 1)
						local objs2 = minetest.get_objects_inside_radius(droppos_below, 1)
						local objs_table = {objs1, objs2}
						local player
						for oi=1, #objs_table do
							local objs_inner = objs_table[oi]
							for o=1, #objs_inner do
								--[[ First player in list is the lucky one. The other player get nothing :-(
								If multiple players are close to the dispenser, it can be a bit
								-- unpredictable on who gets the armor. ]]
								if objs_inner[o]:is_player() then
									player = objs_inner[o]
									break
								end
							end
							if player then
								break
							end
						end
						-- If player found, add armor
						if player then
							local ainv = minetest.get_inventory({type="detached", name=player:get_player_name().."_armor"})
							local pinv = player:get_inventory()
							if ainv:get_stack("armor", armor_slot):is_empty() and pinv:get_stack("armor", armor_slot):is_empty() then
								ainv:set_stack("armor", armor_slot, dropitem)
								pinv:set_stack("armor", armor_slot, dropitem)
								armor:set_player_armor(player)
								armor:update_inventory(player)

								stack:take_item()
								inv:set_stack("main", stack_id, stack)
							end
						end
					end

				elseif igroups.spawn_egg then
					-- Place spawn egg
					if not dropnodedef.walkable then
						pointed_thing = { above = droppos, under = { x=droppos.x, y=droppos.y-1, z=droppos.z } }

						minetest.registered_items[iname].on_place(ItemStack(iname), nil, pointed_thing)

						stack:take_item()
						inv:set_stack("main", stack_id, stack)
					end

				-- TODO: Many other dispenser actions
				else
					-- Drop item
					minetest.add_item(droppos, dropitem)
	
					stack:take_item()
					inv:set_stack("main", stack_id, stack)
				end
			end
		end
	}}
}

-- Horizontal dispenser

local horizontal_def = table.copy(dispenserdef)
horizontal_def.description = "Dispenser"
horizontal_def.after_place_node = function(pos, placer, itemstack, pointed_thing)
	setup_dispenser(pos)

	-- When placed up and down, convert node to up/down dispenser
	if pointed_thing.above.y < pointed_thing.under.y then
		minetest.swap_node(pos, {name = "mcl_dispensers:dispenser_down"})
	elseif pointed_thing.above.y > pointed_thing.under.y then
		minetest.swap_node(pos, {name = "mcl_dispensers:dispenser_up"})
	end

	-- Else, the normal facedir logic applies
end
horizontal_def.tiles = {
	"default_furnace_top.png", "default_furnace_bottom.png",
	"default_furnace_side.png", "default_furnace_side.png",
	"default_furnace_side.png", "mcl_dispensers_dispenser_front_horizontal.png"
}
horizontal_def.paramtype2 = "facedir"
horizontal_def.groups = {cracky=2,container=2}

minetest.register_node("mcl_dispensers:dispenser", horizontal_def)

-- Down dispenser
local down_def = table.copy(dispenserdef)
down_def.description = "Downwards-Facing Dispenser"
down_def.after_place_node = setup_dispenser
down_def.tiles = {
	"default_furnace_top.png", "mcl_dispensers_dispenser_front_vertical.png",
	"default_furnace_side.png", "default_furnace_side.png",
	"default_furnace_side.png", "default_furnace_side.png"
}
down_def.groups = {cracky=2,container=2,not_in_creative_inventory=1}
down_def.drop = "mcl_dispensers:dispenser"
minetest.register_node("mcl_dispensers:dispenser_down", down_def)

-- Up dispenser
-- The up dispenser is almost identical to the down dispenser , it only differs in textures
up_def = table.copy(down_def)
up_def.description = "Upwards-Facing Dispenser"
up_def.tiles = {
	"mcl_dispensers_dispenser_front_vertical.png", "default_furnace_bottom.png",
	"default_furnace_side.png", "default_furnace_side.png",
	"default_furnace_side.png", "default_furnace_side.png"
}
minetest.register_node("mcl_dispensers:dispenser_up", up_def)


minetest.register_craft({
	output = 'mcl_dispensers:dispenser',
	recipe = {
		{"mcl_core:cobble", "mcl_core:cobble", "mcl_core:cobble",},
		{"mcl_core:cobble", "mcl_throwing:bow", "mcl_core:cobble",},
		{"mcl_core:cobble", "mesecons:redstone", "mcl_core:cobble",},
	}
})

-- Only allow crafting if the bow is intact
local check_craft = function(itemstack, player, old_craft_grid, craft_inv)
	if itemstack:get_name() == "mcl_dispensers:dispenser" then
		local bow, id
		for i=1, craft_inv:get_size("craft") do
			local item = craft_inv:get_stack("craft", i)
			if item:get_name() == "mcl_throwing:bow" then
				bow = item
				id = i
				break
			end
		end
		if bow and bow:get_wear() ~= 0 then
			return ""
		end
	end
	return nil
end

minetest.register_on_craft(check_craft)
minetest.register_craft_predict(check_craft)
