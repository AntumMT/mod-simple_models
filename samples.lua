
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
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=1},
})

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
	paramtype2 = "facedir",
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
	paramtype2 = "facedir",
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
	paramtype2 = "facedir",
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
		paramtype2 = "facedir",
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

for _, swing in ipairs({"in", "out"}) do
	for _, state in ipairs({"closed", "open"}) do
		local door_name = "simple_models:door_l_" .. swing .. "_" .. state
		local door_base, door_aux = table.copy(door_def.base), door_def[swing]
		door_base.description = "Door L (" .. door_aux.desc .. " opening)"

		if state == "closed" then
			door_base.on_rightclick = function(pos, node, clicker, stack, pointed_thing)
				door_aux.func[state](smodel, pos, "simple_models:door_l_" .. swing .. "_open")
				if core.global_exists("sounds") and sounds.door_open then
					sounds.door_open()
				end

				return stack
			end
		else
			door_base.drop = "simple_models:door_l_" .. swing .. "_closed"
			door_base.groups.not_in_creative_inventory = 1

			door_base.on_rightclick = function(pos, node, clicker, stack, pointed_thing)
				door_aux.func[state](smodel, pos, door_base.drop)
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
