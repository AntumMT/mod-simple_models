
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
	description = "Panel",
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
	description = "Panel",
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

core.register_node("simple_models:door", {
	description = "Door",
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
		local rot = node.param2-1
		if rot < 0 then
			rot = 3
		end
		core.swap_node(pos, {
			name = "simple_models:door_open",
			param1 = node.param1,
			param2 = rot,
		})
		if core.global_exists("sounds") and sounds.door_open then
			sounds.door_open()
		end

		return stack
	end,
})

core.register_node("simple_models:door_open", {
	description = "Door",
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
		local rot = node.param2+1
		if rot > 3 then
			rot = 0
		end
		core.swap_node(pos, {
			name = "simple_models:door",
			param1 = node.param1,
			param2 = rot,
		})
		if core.global_exists("sounds") and sounds.door_open then
			sounds.door_open()
		end

		return stack
	end,
})
