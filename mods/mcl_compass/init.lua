
local default_spawn_settings = minetest.setting_get("static_spawnpoint")

minetest.register_globalstep(function(dtime)
	local players  = minetest.get_connected_players()
	for i,player in ipairs(players) do
		local function has_compass(player)
			for _,stack in ipairs(player:get_inventory():get_list("main")) do
				if minetest.get_item_group(stack:get_name(), "compass") ~= 0 then
					return true
				end
			end
			return false
		end
		if has_compass(player) then
			local spawn = beds_player_spawns[player:get_player_name()] or
			              minetest.setting_get("static_spawnpoint") or
			              {x=0,y=0,z=0}
			pos = player:getpos()
			dir = player:get_look_yaw()
			local angle_north = math.deg(math.atan2(spawn.x - pos.x, spawn.z - pos.z))
			if angle_north < 0 then angle_north = angle_north + 360 end
			angle_dir = 90 - math.deg(dir)
			local angle_relative = (angle_north - angle_dir + 180) % 360
			local compass_image = math.floor((angle_relative/11.25) + 0.5)%32

			for j,stack in ipairs(player:get_inventory():get_list("main")) do
				if minetest.get_item_group(stack:get_name(), "compass") ~= 0 and
						minetest.get_item_group(stack:get_name(), "compass")-1 ~= compass_image then
					player:get_inventory():set_stack("main", j, "mcl_compass:"..compass_image)
				end
			end
		end
	end
end)

local images = {}
for frame=0,31 do
	table.insert(images, "mcl_compass_compass.png^[verticalframe:32:"..frame)
end

local i
for i,img in ipairs(images) do
	local inv = 1
	if i == 1 then
		inv = 0
	end
	minetest.register_tool("mcl_compass:"..(i-1), {
		description = "Compass",
		inventory_image = img,
		wield_image = img,
		stack_max = 1,
		groups = {not_in_creative_inventory=inv,compass=i}
	})
end

minetest.register_craft({
	output = 'mcl_compass:1',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'mesecons:redstone_dust', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''}
	}
})