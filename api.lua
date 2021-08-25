
--- API Methods
--
--  @topic api


--- Get new rotation for that is opened or closed.
--
--  @local
--  @tparam int old_rot Previous node rotation.
--  @tparam string paramtype2 Node paramtype2.
--  @tparam[opt] bool open Whether door is being opened or closed (default: true).
--  @tparam[opt] bool inward Whether door opens inward or outward (default: true).
--  @tparam[opt] bool invert If `true`, door swings in opposite direction.
--  @treturn int New rotation.
local get_door_rotation = function(old_rot, paramtype2, open, inward, invert)
	-- only facedir is supported
	if not string.find(paramtype2, "facedir") then return end
	local color_info = core.strip_param2_color(old_rot, paramtype2)
	if color_info then
		old_rot = old_rot - color_info
	end

	open = open ~= false
	inward = inward ~= false
	invert = invert == true

	local new_rot = old_rot
	if (not invert and ((open and inward) or (not open and not inward))) or
			(invert and ((not open and inward) or (open and not inward))) then
		new_rot = new_rot-1
		if new_rot < 0 then
			new_rot = 3
		end
	else
		new_rot = new_rot+1
		if new_rot > 3 then
			new_rot = 0
		end
	end

	if color_info then
		new_rot = new_rot + color_info
	end

	return new_rot
end

local get_paramtype2 = function(node)
	local node_def = core.registered_nodes[node.name]
	if node_def then
		return node_def.paramtype2
	end
end


--- Helper method for inward opening door-like nodes.
--
--  @function simple_models:door_inward_open
--  @tparam vector pos Position of node.
--  @tparam string new_node Technical name of node replacement.
--  @tparam bool invert If `true`, door swings in opposite direction (right instead of left).
simple_models.door_inward_open = function(self, pos, new_node, invert)
	local node = core.get_node_or_nil(pos)
	if not node then return end

	local new_rot = get_door_rotation(node.param2, get_paramtype2(node), true, true, invert)
	if not new_rot then return end

	core.swap_node(pos, {
		name = new_node,
		param1 = node.param1,
		param2 = new_rot,
	})
end

--- Helper method for inward closing door-like nodes.
--
--  @function simple_models:door_inward_close
--  @tparam vector pos Position of node.
--  @tparam string new_node Technical name of node replacement.
--  @tparam bool invert If `true`, door swings in opposite direction (right instead of left).
simple_models.door_inward_close = function(self, pos, new_node, invert)
	local node = core.get_node_or_nil(pos)
	if not node then return end

	local new_rot = get_door_rotation(node.param2, get_paramtype2(node), false, true, invert)
	if not new_rot then return end

	core.swap_node(pos, {
		name = new_node,
		param1 = node.param1,
		param2 = new_rot,
	})
end

local get_pos_front = function(pos, param2, paramtype2)
	local new_pos = table.copy(pos)

	local rot = param2
	local color_info = core.strip_param2_color(param2, paramtype2)
	if color_info then
		rot = rot - color_info
	end

	if rot == 0 then
		new_pos.z = new_pos.z-1
	elseif rot == 2 then
		new_pos.z = new_pos.z+1
	elseif rot == 1 then
		new_pos.x = new_pos.x-1
	elseif rot == 3 then
		new_pos.x = new_pos.x+1
	end

	return new_pos
end

local get_pos_behind = function(pos, param2, paramtype2, invert)
	local new_pos = table.copy(pos)

	local rot = param2
	local color_info = core.strip_param2_color(param2, paramtype2)
	if color_info then
		rot = rot - color_info
	end

	local addto = 1
	if invert then
		addto = -addto
	end

	if rot == 0 then
		new_pos.x = new_pos.x - addto
	elseif rot == 2 then
		new_pos.x = new_pos.x + addto
	elseif rot == 1 then
		new_pos.z = new_pos.z + addto
	elseif rot == 3 then
		new_pos.z = new_pos.z - addto
	end

	return new_pos
end

--- Helper method for outward opening door-like nodes.
--
--  @function simple_models:door_outward_open
--  @tparam vector pos Position of node.
--  @tparam string new_node Technical name of node replacement.
--  @tparam bool invert If `true`, door swings in opposite direction (right instead of left).
simple_models.door_outward_open = function(self, pos, new_node, invert)
	local node = core.get_node_or_nil(pos)
	if not node then return end

	local paramtype2 = get_paramtype2(node)
	local new_pos = get_pos_front(pos, node.param2, paramtype2)

	local blocker = core.get_node(new_pos)
	-- something is blocking door or new_pos is same as old
	if blocker and blocker.name ~= "air" then return end

	local new_rot = get_door_rotation(node.param2, paramtype2, true, false, invert)
	if not new_rot then return end

	local old_meta_table = core.get_meta(pos):to_table()
	core.remove_node(pos)
	core.set_node(new_pos, {
		name = new_node,
		param1 = node.param1,
		param2 = new_rot,
	})

	-- transfer meta to new pos
	core.get_meta(new_pos):from_table(old_meta_table)
end

--- Helper method for outward closing door-like nodes.
--
--  @function simple_models:door_outward_close
--  @tparam vector pos Position of node.
--  @tparam string new_node Technical name of node replacement.
--  @tparam bool invert If `true`, door swings in opposite direction (right instead of left).
simple_models.door_outward_close = function(self, pos, new_node, invert)
	local node = core.get_node_or_nil(pos)
	if not node then return end

	local paramtype2 = get_paramtype2(node)
	local new_pos = get_pos_behind(pos, node.param2, paramtype2, invert)

	local blocker = core.get_node(new_pos)
	-- something is blocking door or new_pos is same as old
	if blocker and blocker.name ~= "air" then return end

	local new_rot = get_door_rotation(node.param2, paramtype2, false, false, invert)
	if not new_rot then return end

	local old_meta_table = core.get_meta(pos):to_table()
	core.remove_node(pos)
	core.set_node(new_pos, {
		name = new_node,
		param1 = node.param1,
		param2 = new_rot,
	})

	-- transfer meta to new pos
	core.get_meta(new_pos):from_table(old_meta_table)
end
