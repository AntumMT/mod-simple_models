
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

	--- Mid panel
	--
	--  Alias: simple_models.panel_mid
	--
	--  @table simple_models.panel_mid_1x2x1
	--  @tfield string mesh simple_models_panel_mid_1x2x1.obj
	--  @tfield table box {-0.5, -0.5, 0.025, 0.5, 1.5, -0.025},
	panel_mid_1x2x1 = {
		mesh = "simple_models_panel_mid_1x2x1.obj",
		box = {-0.5, -0.5, 0.025, 0.5, 1.5, -0.025},
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
simple_models.panel_mid = simple_models.panel_mid_1x2x1
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
		name = new_node,
		param1 = node.param1,
		param2 = rot,
	})
end

local get_pos_front = function(pos, param2)
	local new_pos = table.copy(pos)

	if param2 == 0 then
		new_pos.z = new_pos.z-1
	elseif param2 == 2 then
		new_pos.z = new_pos.z+1
	elseif param2 == 1 then
		new_pos.x = new_pos.x-1
	elseif param2 == 3 then
		new_pos.x = new_pos.x+1
	end

	return new_pos
end

local get_pos_behind = function(pos, param2)
	local new_pos = table.copy(pos)

	if param2 == 0 then
		new_pos.x = new_pos.x-1
	elseif param2 == 2 then
		new_pos.x = new_pos.x+1
	elseif param2 == 1 then
		new_pos.z = new_pos.z+1
	elseif param2 == 3 then
		new_pos.z = new_pos.z-1
	end

	return new_pos
end

--- Helper method for outward opening door-like nodes.
--
--  @function simple_models:door_outward_open
--  @tparam vector pos Position of node.
--  @tparam string new_node Technical name of node replacement.
simple_models.door_outward_open = function(self, pos, new_node)
	local node = core.get_node_or_nil(pos)
	if not node then return end

	local new_pos = get_pos_front(pos, node.param2)

	local blocker = core.get_node(new_pos)
	-- something is blocking door or new_pos is same as old
	if blocker and blocker.name ~= "air" then return end

	local rot = node.param2+1
	if rot > 3 then
		rot = 0
	end
	core.remove_node(pos)
	core.set_node(new_pos, {
		name = new_node,
		param1 = node.param1,
		param2 = rot,
	})
end

--- Helper method for outward closing door-like nodes.
--
--  @function simple_models:door_outward_close
--  @tparam vector pos Position of node.
--  @tparam string new_node Technical name of node replacement.
simple_models.door_outward_close = function(self, pos, new_node)
	local node = core.get_node_or_nil(pos)
	if not node then return end

	local new_pos = get_pos_behind(pos, node.param2)

	local blocker = core.get_node(new_pos)
	-- something is blocking door or new_pos is same as old
	if blocker and blocker.name ~= "air" then return end

	local rot = node.param2-1
	if rot < 0 then
		rot = 3
	end
	core.remove_node(pos)
	core.set_node(new_pos, {
		name = new_node,
		param1 = node.param1,
		param2 = rot,
	})
end


if core.settings:get_bool("simple_models.enable_samples", false) then
	dofile(core.get_modpath(core.get_current_modname()) .. "/samples.lua")
end
