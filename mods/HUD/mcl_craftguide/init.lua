mcl_craftguide = {}

local craftguide, datas, mt = {}, {}, minetest
local progressive_mode = mt.setting_getbool("craftguide_progressive_mode")
local get_recipe = mt.get_craft_recipe
local get_result, show_formspec = mt.get_craft_result, mt.show_formspec
local reg_items = mt.registered_items

local get_recipes = function(query_item)
	local recipes = mt.get_all_craft_recipes(query_item)

	-- Manually add repairing recipes (workaround, because get_all_craft_recipes
	-- doesn't return repairing recipes)
	if minetest.get_modpath("mcl_core") then
		local def = minetest.registered_items[query_item]
		if def.type == "tool" then
			if recipes == nil then
				recipes = {}
			end
			table.insert(recipes, {
				type = "normal",
				width = 0,
				items = { [1] = query_item, [2] = query_item },
				output = query_item,
				-- Special marker for repairing recipes
				_is_toolrepair = true,
			})
		end
	end
	return recipes
end

-- Lua 5.3 removed `table.maxn`, use this alternative in case of breakage:
-- https://github.com/kilbith/xdecor/blob/master/handlers/helpers.lua#L1
local remove, maxn, sort = table.remove, table.maxn, table.sort
local min, max, floor, ceil = math.min, math.max, math.floor, math.ceil

local group_stereotypes = {
	wool	     = "mcl_wool:white",
	carpet       = "mcl_wool:white_carpet",
	dye	     = "mcl_dye:white",
	water_bucket = "bucket:bucket_water",
	flower	     = "mcl_flowers:dandelion",
	mushroom     = "mcl_farming:mushroom_brown",
	wood_slab    = "stairs:slab_wood",
	wood_stairs  = "stairs:stairs_wood",
	coal         = "mcl_core:coal_lump",
	shulker_box  = "mcl_chests:violet_shulker_box",
	quartz_block = "mcl_nether:quartz_block",
	mesecon_conductor_craftable = "mesecons:wire_00000000_off",
}

local group_names = {
	shulker_box = "Any shulker box",
	wool = "Any wool",
	wood = "Any wood planks",
	tree = "Any wood",
	sand = "Any sand",
	sandstone = "Any sandstone (yellow)",
	redsandstone = "Any red sandstone",
	carpet = "Any carpet",
	dye = "Any dye",
	water_bucket = "Any water bucket",
	flower = "Any flower",
	mushroom = "Any mushroom",
	wood_slab = "Any wooden slab",
	wood_stairs = "Any wooden stairs",
	coal = "Any coal",
	quartz_block = "Any kind of quartz block",
	stonebrick = "Any stone bricks"
}

function craftguide:group_to_item(item)
	if item:sub(1,6) == "group:" then
		local itemsub = item:sub(7)
		if group_stereotypes[itemsub] then
			item = group_stereotypes[itemsub]
		elseif reg_items["mcl_core:"..itemsub] then
			item = item:gsub("group:", "mcl_core:")
		else
			for name, def in pairs(reg_items) do
				if def.groups[item:match("[^,:]+$")] then
					item = name
				end
			end
		end
	end
	return item:sub(1,6) == "group:" and "" or item
end

local function extract_groups(str)
	if str:sub(1,6) ~= "group:" then return end
	return str:sub(7):split(",")
end

local function colorize(str)
	-- If client <= 0.4.14, don't colorize for compatibility.
	return mt.colorize and mt.colorize("#FFFF00", str) or str
end

local function get_fueltime(item)
	return get_result({method="fuel", width=1, items={item}}).time
end

function craftguide:get_tooltip(item, recipe_type, cooktime, groups)
	local raw = self:get_tooltip_raw(item, recipe_type, cooktime, groups)
	if raw == "" then
		return raw
	else
		local tooltip = "tooltip["..item..";"
		tooltip = tooltip .. raw
		tooltip = tooltip .. "]"
		return tooltip
	end
end

function craftguide:get_tooltip_raw(item, recipe_type, cooktime, groups)
	local tooltip, item_desc  = "", ""
	local fueltime = get_fueltime(item)
	local has_extras = groups or recipe_type == "cooking" or fueltime > 0

	if reg_items[item] then
		if not groups then
			item_desc = reg_items[item].description
		end
	else
		return tooltip.."Unknown Item ("..item..")]"
	end
	if groups then
		local gcol = "#FFAAFF"
		local groupstr
		if #groups == 1 then
			if group_names[groups[1]] then
				groupstr = group_names[groups[1]]
			else
				groupstr = "Any item belonging to the " .. groups[1] .. " group"
			end
		else
			groupstr = "Any item belonging to the following groups: "
			for i=1, #groups do
				groupstr = groupstr .. groups[i]..
				(groups[i+1] and " and " or "")
			end
		end
		tooltip = tooltip..core.colorize(gcol, groupstr)
	end
	tooltip = tooltip .. item_desc
	if recipe_type == "cooking" then
		tooltip = tooltip.."\nCooking time: "..
			colorize(cooktime)
	end
	if fueltime > 0 and not groups then
		tooltip = tooltip.."\nBurning time: "..
			colorize(fueltime)
	end

	return tooltip
end

function craftguide:get_recipe(iY, xoffset, tooltip_raw, item, recipe_num, recipes)
	local formspec, recipes_total = "", #recipes
	if recipes_total > 1 then
		formspec = formspec..
			"button[0,"..(iY+3)..";2,1;alternate;Alternate]"..
			"label[0,"..(iY+2)..".5;Recipe "..
				recipe_num.." of "..recipes_total.."]"
	end
	local recipe_type = recipes[recipe_num].type

	local items = recipes[recipe_num].items
	local width = recipes[recipe_num].width
	local cooking_time = 10
	local is_shapeless = false
	if recipe_type == "normal" and width == 0 then
		is_shapeless = true
		if #items <= 4 then
			width = 2
		else
			width = min(3, #items)
		end
	end

	if recipe_type == "cooking" then
		cooking_time = width
		width = 1
		formspec = formspec..
			"image["..(xoffset-0.8)..","..(iY+1)..
				".5;0.5,0.5;default_furnace_front_active.png]"
	elseif is_shapeless then
		formspec = formspec..
			"image["..(xoffset-0.8)..","..(iY+1)..
			".5;0.5,0.5;craftguide_shapeless.png]"
	end

	local rows = ceil(maxn(items) / width)
	local btn_size, craftgrid_limit = 1, 5

	if recipe_type == "normal" and
			width > craftgrid_limit or rows > craftgrid_limit then
		formspec = formspec..
			"label["..xoffset..","..(iY+2)..
				";Recipe is too big to\nbe displayed ("..
				width.."x"..rows..")]"
	else
		for i, v in pairs(items) do
			local X = (i-1) % width + xoffset - 4 + (3 - max(1, width))
			local Y = ceil(i / width + iY+2 - min(2, rows))

			if recipe_type == "normal" and
					width > 3 or rows > 3 then
				btn_size = width > 3 and 3 / width or 3 / rows
				X = btn_size * (i % width) + xoffset - 4 + (3 - max(1, width))

				Y = btn_size * floor((i-1) / width) + iY+3 -
					min(2, rows)
			end

			local groups = extract_groups(v)
			local label = groups and "\nG" or ""
			local item_r = self:group_to_item(v)
			local tltip = self:get_tooltip(
					item_r, recipe_type, cooking_time, groups)

			formspec = formspec..
				"item_image_button["..X..","..Y..";"..
					btn_size..","..btn_size..";"..item_r..
					";"..item_r..";"..label.."]"..tltip
		end
	end
	local output = recipes[recipe_num].output
	local label = ""
	if recipes[recipe_num]._is_toolrepair then
		tooltip_raw = tooltip_raw .. "\n" .. core.colorize("#00FF00", string.format("Repaired by %.0f%%", (mcl_core.repair*100)))
		label = "\nR"
	end
	return formspec..
		"image["..(xoffset-1)..","..(iY+2)..
			".12;0.9,0.7;craftguide_arrow.png]"..
		"item_image_button["..(xoffset)..","..(iY+2)..";1,1;"..
			output..";"..item.."_out"..";"..label.."]".."tooltip["..item.."_out"..";"..minetest.formspec_escape(tooltip_raw).."]"
end

function craftguide:get_formspec(player_name, is_fuel)
	local data = datas[player_name]
	local iY = data.iX - 5
	local ipp = data.iX * iY

	if not data.items then
		data.items = datas.init_items
	end
	data.pagemax = max(1, ceil(#data.items / ipp))

	local formspec = "size["..data.iX..","..(iY+3)..".6;]"..
			mcl_vars.gui_slots ..
			mcl_vars.gui_bg ..
			[=[background[1,1;1,1;craftguide_bg.png;true]
			button[2.4,0.21;0.8,0.5;search;?]
			button[3.05,0.21;0.8,0.5;clear;X]
			tooltip[search;Search]
			tooltip[clear;Reset]
			tooltip[size_inc;Increase window size]
			tooltip[size_dec;Decrease window size]
			field_close_on_enter[filter;false]]=]..
			"button["..(data.iX/2)..",-0.02;0.7,1;size_inc;+]"..
			"button["..((data.iX/2) + 0.5)..
				",-0.02;0.7,1;size_dec;-]"..
			"button["..(data.iX-3)..".4,0;0.8,0.95;prev;<]"..
			"label["..(data.iX-2)..".1,0.18;"..
				colorize(data.pagenum).." / "..data.pagemax.."]"..
			"button["..(data.iX-1)..".2,0;0.8,0.95;next;>]"..
			"field[0.3,0.32;2.5,1;filter;;"..
				mt.formspec_escape(data.filter).."]"

	local even_num = data.iX % 2 == 0
	local xoffset = data.iX / 2 + (even_num and 0.5 or 0) + 2

	if not next(data.items) then
		formspec = formspec..
			"label["..(xoffset - (even_num and 1.5 or 1))..
				",2;No item to show]"
	end

	local first_item = (data.pagenum - 1) * ipp
	for i = first_item, first_item + ipp - 1 do
		local name = data.items[i+1]
		if not name then break end
		local X = i % data.iX
		local Y = (i % ipp - X) / data.iX + 1

		formspec = formspec..
			"item_image_button["..X..","..Y..";1,1;"..
				name..";"..name.."_inv;]"
	end

	if data.item and reg_items[data.item] then
		local tooltip_raw = self:get_tooltip_raw(data.item)
		local tooltip = ""
		if tooltip_raw ~= "" then
			tooltip = "tooltip["..data.item..";"..minetest.formspec_escape(tooltip_raw).."]"
		end
		if not data.recipes_item or (is_fuel and not
				get_recipe(data.item).items) then
			formspec = formspec..
				"image["..(xoffset-1)..","..(iY+2)..
					".12;0.9,0.7;craftguide_arrow.png]"..
				"item_image_button["..(xoffset-2)..","..(iY+2)..
					";1,1;"..data.item..";"..data.item..";]"..
				tooltip..
				"image["..(xoffset)..","..
					(iY+1.98)..";1,1;craftguide_fire.png]"
		else
			formspec = formspec..self:get_recipe(
					iY, xoffset, tooltip_raw, data.item,
					data.recipe_num, data.recipes_item)
		end
	end

	data.formspec = formspec
	show_formspec(player_name, "craftguide", formspec)
end

local function player_has_item(T)
	for i=1, #T do
		if T[i] then return true end
	end
end

local function group_to_items(group)
	local items_with_group, counter = {}, 0
	for name, def in pairs(reg_items) do
		if def.groups[group:sub(7)] then
			counter = counter + 1
			items_with_group[counter] = name
		end
	end
	return items_with_group
end

local function item_in_inv(inv, item)
	return inv:contains_item("main", item)
end

function craftguide:recipe_in_inv(inv, item_name, recipes_f)
	local recipes = recipes_f or get_recipes(item_name) or {}
	local show_item_recipes = {}

	for i=1, #recipes do
		show_item_recipes[i] = true
		for _, item in pairs(recipes[i].items) do
			local group_in_inv = false
			if item:sub(1,6) == "group:" then
				local groups = group_to_items(item)
				for j=1, #groups do
					if item_in_inv(inv, groups[j]) then
						group_in_inv = true
					end
				end
			end
			if not group_in_inv and not item_in_inv(inv, item) then
				show_item_recipes[i] = false
			end
		end
	end
	for i=#show_item_recipes, 1, -1 do
		if not show_item_recipes[i] then
			remove(recipes, i)
		end
	end

	return recipes, player_has_item(show_item_recipes)
end

function craftguide:get_init_items()
	local items_list, counter = {}, 0
	for name, def in pairs(reg_items) do
		local is_fuel = get_fueltime(name) > 0
		local is_tool = def.type == "tool"
		if (not def.groups.not_in_craft_guide or def.groups.not_in_craft_guide == 0)
				and (get_recipe(name).items or is_fuel or is_tool)
				and def.description and def.description ~= "" then
			counter = counter + 1
			items_list[counter] = name
		end
	end

	sort(items_list)
	datas.init_items = items_list
end

function craftguide:get_filter_items(data, player)
	local filter = data.filter
	local items_list = progressive_mode and data.init_filter_items or
		datas.init_items
	local inv = player:get_inventory()
	local filtered_list, counter = {}, 0

	for i=1, #items_list do
		local item = items_list[i]
		local item_desc = reg_items[item].description:lower()

		if filter ~= "" then
			if item:find(filter, 1, true) or
					item_desc:find(filter, 1, true) then
				counter = counter + 1
				filtered_list[counter] = item
			end
		elseif progressive_mode then
			local _, has_item = self:recipe_in_inv(inv, item)
			if has_item then
				counter = counter + 1
				filtered_list[counter] = item
			end
		end
	end

	if progressive_mode and not data.items then
		data.init_filter_items = filtered_list
	end
	data.items = filtered_list
end

mt.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "craftguide" then return end
	local player_name = player:get_player_name()
	local data = datas[player_name]

	if fields.clear then
		data.filter, data.item, data.pagenum, data.recipe_num =
			"", nil, 1, 1
		data.items = progressive_mode and data.init_filter_items or
			datas.init_items
		craftguide:get_formspec(player_name)
	elseif fields.alternate then
		local recipe = data.recipes_item[data.recipe_num + 1]
		data.recipe_num = recipe and data.recipe_num + 1 or 1
		craftguide:get_formspec(player_name)
	elseif (fields.key_enter_field == "filter" or fields.search) and
			fields.filter ~= "" then
		data.filter = fields.filter:lower()
		data.pagenum = 1
		craftguide:get_filter_items(data, player)
		craftguide:get_formspec(player_name)
	elseif fields.prev or fields.next then
		data.pagenum = data.pagenum - (fields.prev and 1 or -1)
		if data.pagenum > data.pagemax then
			data.pagenum = 1
		elseif data.pagenum == 0 then
			data.pagenum = data.pagemax
		end
		craftguide:get_formspec(player_name)
	elseif (fields.size_inc and data.iX < 12) or
			(fields.size_dec and data.iX > 8) then
		data.pagenum = 1
		data.iX = data.iX - (fields.size_dec and 1 or -1)
		craftguide:get_formspec(player_name)
	else
		for item in pairs(fields) do
		if item:find(":") then
			if item:sub(-4) == "_inv" or item:sub(-4) == "_out" then
				item = item:sub(1,-5)
			end

			local is_fuel = get_fueltime(item) > 0
			local recipes = get_recipes(item)
			if not recipes and not is_fuel then return end

			if item == data.item then
				if data.recipes_item and #data.recipes_item >= 2 then
					local recipe = data.recipes_item[data.recipe_num + 1]
					data.recipe_num = recipe and data.recipe_num + 1 or 1
					craftguide:get_formspec(player_name)
				end
			else

				if progressive_mode then
					local inv = player:get_inventory()
					local _, has_item =
						craftguide:recipe_in_inv(inv, item)

					if not has_item then return end
					recipes = craftguide:recipe_in_inv(
								inv, item, recipes)
				end

				data.item = item
				data.recipe_num = 1
				data.recipes_item = recipes

				craftguide:get_formspec(player_name, is_fuel)
			end
		end
		end
	end
end)

function craftguide:on_use(user)
	if not datas.init_items then
		craftguide:get_init_items()
	end

	local player_name = user:get_player_name()
	local data = datas[player_name]

	if progressive_mode or not data then
		datas[player_name] = {filter="", pagenum=1, iX=9}
		if progressive_mode then
			craftguide:get_filter_items(
					datas[player_name], user)
		end
		craftguide:get_formspec(player_name)
	else
		show_formspec(player_name, "craftguide", data.formspec)
	end
end

mcl_craftguide.show_craftguide = function(player)
	craftguide:on_use(player)
end

mt.register_on_player_receive_fields(function(player, formname, fields)
	if fields.__mcl_craftguide then
		craftguide:on_use(player)
	end
end)
