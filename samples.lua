
local smodel = simple_models


-- cubes

core.register_node("simple_models:node_tall", {
	description = "Tall Node",
	drawtype = "mesh",
	mesh = smodel.cube.mesh,
	tiles = {"simple_models_sample_cube_1x2x1_map.png"},
	collision_box = {
		type = "fixed",
		fixed = smodel.cube.box,
	},
	selection_box = {
		type = "fixed",
		fixed = smodel.cube.box,
	},
	paramtype2 = "colorfacedir",
	palette = "simple_models_sample_palette.png",
	groups = {oddly_breakable_by_hand=1},
})


-- panels

core.register_node("simple_models:panel", {
	description = "Front Panel",
	drawtype = "mesh",
	tiles = {"simple_models_sample_panel_1x2x1_map.png"},
	mesh = smodel.panel.mesh,
	collision_box = {
		type = "fixed",
		fixed = smodel.panel.box,
	},
	selection_box = {
		type = "fixed",
		fixed = smodel.panel.box,
	},
	paramtype2 = "colorfacedir",
	palette = "simple_models_sample_palette.png",
	groups = {oddly_breakable_by_hand=1},

	on_rightclick = function(pos, node, clicker, stack, pointed_thing)
		core.swap_node(pos, {
			name = "simple_models:panel_mid",
			param1 = node.param1,
			param2 = node.param2,
		})
		if core.global_exists("sounds") and sounds.woosh then
			sounds.woosh()
		end

		return stack
	end,
})

core.register_node("simple_models:panel_mid", {
	description = "Mid Panel",
	drawtype = "mesh",
	tiles = {"simple_models_sample_panel_1x2x1_map.png"},
	mesh = smodel.panel_mid.mesh,
	collision_box = {
		type = "fixed",
		fixed = smodel.panel_mid.box,
	},
	selection_box = {
		type = "fixed",
		fixed = smodel.panel_mid.box,
	},
	paramtype2 = "colorfacedir",
	palette = "simple_models_sample_palette.png",
	groups = {oddly_breakable_by_hand=1},

	on_rightclick = function(pos, node, clicker, stack, pointed_thing)
		core.swap_node(pos, {
			name = "simple_models:panel_rear",
			param1 = node.param1,
			param2 = node.param2,
		})
		if core.global_exists("sounds") and sounds.woosh then
			sounds.woosh()
		end

		return stack
	end,
})

core.register_node("simple_models:panel_rear", {
	description = "Rear Panel",
	drawtype = "mesh",
	tiles = {"simple_models_sample_panel_1x2x1_map.png"},
	mesh = smodel.panel_rear.mesh,
	collision_box = {
		type = "fixed",
		fixed = smodel.panel_rear.box,
	},
	selection_box = {
		type = "fixed",
		fixed = smodel.panel_rear.box,
	},
	paramtype2 = "colorfacedir",
	palette = "simple_models_sample_palette.png",
	groups = {oddly_breakable_by_hand=1},

	on_rightclick = function(pos, node, clicker, stack, pointed_thing)
		core.swap_node(pos, {
			name="simple_models:panel",
			param1 = node.param1,
			param2 = node.param2,
		})
		if core.global_exists("sounds") and sounds.woosh then
			sounds.woosh()
		end

		return stack
	end,
})


-- doors

local door_def = {
	base = {
		drawtype = "mesh",
		tiles = {"simple_models_sample_panel_1x2x1_map.png"},
		mesh = smodel.panel.mesh,
		collision_box = {
			type = "fixed",
			fixed = smodel.panel.box,
		},
		selection_box = {
			type = "fixed",
			fixed = smodel.panel.box,
		},
		paramtype2 = "colorfacedir",
		palette = "simple_models_sample_palette.png",
		groups = {oddly_breakable_by_hand=1},
	},

	["in"] = {
		desc = "inward",
		func = {
			closed = smodel.door_inward_open,
			open = smodel.door_inward_close,
		},
	},

	["out"] = {
		desc = "outward",
		func = {
			closed = smodel.door_outward_open,
			open = smodel.door_outward_close,
		},
	},
}

door_def.base_alt = table.copy(door_def.base)
door_def.base_alt.mesh = smodel.panel_rear.mesh
door_def.base_alt.collision_box.fixed = smodel.panel_rear.box
door_def.base_alt.selection_box.fixed = smodel.panel_rear.box

for _, dir in ipairs({"l", "r"}) do
	for _, swing in ipairs({"in", "out"}) do
		for _, state in ipairs({"closed", "open"}) do
			local door_base
			if swing == "in" and state == "open" then
				door_base = table.copy(door_def.base_alt)
			else
				door_base = table.copy(door_def.base)
			end

			local door_aux = door_def[swing]
			local door_name = "simple_models:door_" .. dir .. "_" .. swing .. "_" .. state
			local invert = dir == "r"

			door_base.description = "Door "
			if dir == "l" then
				door_base.description = door_base.description .. "L"
			else
				door_base.description = door_base.description .. "R"
			end
			door_base.description = door_base.description .. " (" .. door_aux.desc .. " opening)"

			if state == "closed" then
				door_base.on_rightclick = function(pos, node, clicker, stack, pointed_thing)
					door_aux.func[state](smodel, pos,
						"simple_models:door_" .. dir .. "_" .. swing .. "_open", invert)
					if core.global_exists("sounds") and sounds.door_open then
						sounds.door_open()
					end

					return stack
				end

				door_base.after_place_node = function(pos, placer, stack, pointed_thing)
					local node = core.get_node(pos)
					node.param2 = node.param2 + (3 * 32)
					core.swap_node(pos, {name=node.name, param1=node.param1, param2=node.param2})
				end
			else
				door_base.drop = "simple_models:door_" .. dir .. "_" .. swing .. "_closed"
				door_base.groups.not_in_creative_inventory = 1

				door_base.on_rightclick = function(pos, node, clicker, stack, pointed_thing)
					door_aux.func[state](smodel, pos, door_base.drop, invert)
					if core.global_exists("sounds") and sounds.door_close then
						sounds.door_close()
					end

					return stack
				end

				door_base.after_place_node = function(pos, placer, stack, pointed_thing)
					local node = core.get_node(pos)
					core.swap_node(pos, {
						name = door_base.drop,
						param1 = node.param1,
						param2 = node.param2,
					})
				end
			end

			core.register_node(door_name, door_base)
		end
	end
end


-- stairs

core.register_node("simple_models:stair", {
	description = "Stair",
	drawtype = "mesh",
	tiles = {"simple_models_sample_stair_1x1x1_map.png"},
	mesh = smodel.stair.mesh,
	collision_box = {
		type = "fixed",
		fixed = smodel.stair.box,
	},
	selection_box = {
		type = "fixed",
		fixed = smodel.stair.box,
	},
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=1, stair=1},
})


-- slopes

core.register_node("simple_models:slope", {
	description = "Slope",
	drawtype = "mesh",
	tiles = {"simple_models_sample_slope_1x1x1_map.png"},
	mesh = smodel.slope.mesh,
	collision_box = {
		type = "fixed",
		fixed = smodel.slope.box,
	},
	selection_box = {
		type = "fixed",
		fixed = smodel.slope.box,
	},
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=1, slope=1},
})

core.register_node("simple_models:slope_long", {
	description = "Long Slope",
	drawtype = "mesh",
	tiles = {"simple_models_sample_slope_1x1x1_map.png"},
	mesh = smodel.slope_long.mesh,
	collision_box = {
		type = "fixed",
		fixed = smodel.slope_long.box,
	},
	selection_box = {
		type = "fixed",
		fixed = smodel.slope_long.box,
	},
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=1, slope=1},
})
