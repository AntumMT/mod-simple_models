
--- Model Definitions
--
--  @topic models


--- Global table.
--
--  @table simple_models
simple_models = {
	--- Cube
	--
	--  Alias: simple_models.cube
	--
	--  @table simple_models.cube_1x2x1
	--  @tfield string mesh simple_models_cube_1x2x1.obj
	--  @tfield table box {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
	cube_1x2x1 = {
		mesh = "simple_models_cube_1x2x1.obj",
		box = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
	},

	--- Panel
	--
	--  Alias: simple_models.panel
	--
	--  @table simple_models.panel_1x2x1
	--  @tfield string mesh simple_models_panel_1x2x1.obj
	--  @tfield table box {-0.5, -0.5, -0.5, 0.5, 1.5, -0.45}
	panel_1x2x1 = {
		mesh = "simple_models_panel_1x2x1.obj",
		box = {-0.5, -0.5, -0.5, 0.5, 1.5, -0.45},
	},

	--- Rear panel
	--
	--  Alias: simple_models.panel_rear
	--
	--  @table simple_models.panel_rear_1x2x1
	--  @tfield string mesh simple_models_panel_rear_1x2x1.obj
	--  @tfield table box {-0.5, -0.5, 0.45, 0.5, 1.5, 0.5}
	panel_rear_1x2x1 = {
		mesh = "simple_models_panel_rear_1x2x1.obj",
		box = {-0.5, -0.5, 0.45, 0.5, 1.5, 0.5},
	},
}

simple_models.cube = simple_models.cube_1x2x1
simple_models.panel = simple_models.panel_1x2x1
simple_models.panel_rear = simple_models.panel_rear_1x2x1

--- Global table.
--
--  Alias of `simple_models`
--
--  @table smodel
if not core.global_exists("smodel") then
	smodel = simple_models
end


--- Helper method for inward opening door-like nodes.
--
--  @function simple_models:door_inward_open
--  @tparam vector pos Position of node.
--  @tparam string new_node Technical name of node replacement.
simple_models.door_inward_open = function(self, pos, new_node)
	local node = core.get_node_or_nil(pos)
	if not node then return end

	local rot = node.param2-1
	if rot < 0 then
		rot = 3
	end
	core.swap_node(pos, {
		name = new_node,
		param1 = node.param1,
		param2 = rot,
	})
end

--- Helper method for inward closing door-like nodes.
--
--  @function simple_models:door_inward_close
--  @tparam vector pos Position of node.
--  @tparam string new_node Technical name of node replacement.
simple_models.door_inward_close = function(self, pos, new_node)
	local node = core.get_node_or_nil(pos)
	if not node then return end

	local rot = node.param2+1
	if rot > 3 then
		rot = 0
	end
	core.swap_node(pos, {
		name = "simple_models:door",
		param1 = node.param1,
		param2 = rot,
	})
end


if core.settings:get_bool("simple_models.enable_samples", false) then
	dofile(core.get_modpath(core.get_current_modname()) .. "/samples.lua")
end
