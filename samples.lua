
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


-- inward opening doors

core.register_node("simple_models:door", {
	description = "Closed Door (inward opening)",
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
		smodel:door_inward_open(pos, "simple_models:door_open")
		if core.global_exists("sounds") and sounds.door_open then
			sounds.door_open()
		end

		return stack
	end,
})

core.register_node("simple_models:door_open", {
	description = "Open Door (inward opening)",
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
	drop = "simple_models:door",

	on_rightclick = function(pos, node, clicker, stack, pointed_thing)
		smodel:door_inward_close(pos, "simple_models:door")
		if core.global_exists("sounds") and sounds.door_close then
			sounds.door_close()
		end

		return stack
	end,

	after_place_node = function(pos, placer, stack, pointed_thing)
		local node = core.get_node(pos)
		core.swap_node(pos, {
			name = "simple_models:door",
			param1 = node.param1,
			param2 = node.param2,
		})
	end,
})


-- outward opening doors

local door_outward_def = {
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
}

for _, state in ipairs({"closed", "open"}) do
	local door_name = "simple_models:door2"
	if state == "open" then
		door_name = door_name .. "_open"
	end

	local door_def = table.copy(door_outward_def)

	if state == "closed" then
		door_def.description = "Closed Door (outward opening)"

		door_def.on_rightclick = function(pos, node, clicker, stack, pointed_thing)
			smodel:door_outward_open(pos, "simple_models:door2_open")
			if core.global_exists("sounds") and sounds.door_open then
				sounds.door_open()
			end

			return stack
		end
	else
		door_def.description = "Open Door (outward opening)"
		door_def.drop = "simple_models:door2"

		door_def.on_rightclick = function(pos, node, clicker, stack, pointed_thing)
			smodel:door_outward_close(pos, "simple_models:door2")
			if core.global_exists("sounds") and sounds.door_close then
				sounds.door_close()
			end

			return stack
		end

		door_def.after_place_node = function(pos, placer, stack, pointed_thing)
			local node = core.get_node(pos)
			core.swap_node(pos, {
				name = "simple_models:door2",
				param1 = node.param1,
				param2 = node.param2,
			})
		end
	end

	core.register_node(door_name, door_def)
end
