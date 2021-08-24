
--- API Methods
--
--  @topic api


--- Helper method for inward opening door-like nodes.
--
--  @function simple_models:door_inward_open
--  @tparam vector pos Position of node.
--  @tparam string new_node Technical name of node replacement.
--  @tparam bool invert If `true`, door swings in opposite direction (right instead of left).
simple_models.door_inward_open = function(self, pos, new_node, invert)
	local node = core.get_node_or_nil(pos)
	if not node then return end

	local rot
	if not invert then
		rot = node.param2-1
		if rot < 0 then
			rot = 3
		end
	else
		rot = node.param2+1
		if rot > 3 then
			rot = 0
		end
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
--  @tparam bool invert If `true`, door swings in opposite direction (right instead of left).
simple_models.door_inward_close = function(self, pos, new_node, invert)
	local node = core.get_node_or_nil(pos)
	if not node then return end

	local rot
	if not invert then
		rot = node.param2+1
		if rot > 3 then
			rot = 0
		end
	else
		rot = node.param2-1
		if rot < 0 then
			rot = 3
		end
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

local get_pos_behind = function(pos, param2, invert)
	local new_pos = table.copy(pos)

	local addto = 1
	if invert then
		addto = -addto
	end

	if param2 == 0 then
		new_pos.x = new_pos.x - addto
	elseif param2 == 2 then
		new_pos.x = new_pos.x + addto
	elseif param2 == 1 then
		new_pos.z = new_pos.z + addto
	elseif param2 == 3 then
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

	local new_pos = get_pos_front(pos, node.param2)

	local blocker = core.get_node(new_pos)
	-- something is blocking door or new_pos is same as old
	if blocker and blocker.name ~= "air" then return end

	local rot
	if not invert then
		rot = node.param2+1
		if rot > 3 then
			rot = 0
		end
	else
		rot = node.param2-1
		if rot < 0 then
			rot = 3
		end
	end

	local old_meta_table = core.get_meta(pos):to_table()
	core.remove_node(pos)
	core.set_node(new_pos, {
		name = new_node,
		param1 = node.param1,
		param2 = rot,
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

	local new_pos = get_pos_behind(pos, node.param2, invert)

	local blocker = core.get_node(new_pos)
	-- something is blocking door or new_pos is same as old
	if blocker and blocker.name ~= "air" then return end

	local rot
	if not invert then
		rot = node.param2-1
		if rot < 0 then
			rot = 3
		end
	else
		rot = node.param2+1
		if rot > 3 then
			rot = 0
		end
	end

	local old_meta_table = core.get_meta(pos):to_table()
	core.remove_node(pos)
	core.set_node(new_pos, {
		name = new_node,
		param1 = node.param1,
		param2 = rot,
	})

	-- transfer meta to new pos
	core.get_meta(new_pos):from_table(old_meta_table)
end
