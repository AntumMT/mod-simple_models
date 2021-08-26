
--- Model Definitions
--
--  @topic models


--- Cube
--
--  Alias: simple_models.cube
--
--  @table simple_models.cube_1x2x1
--  @tfield string mesh simple_models_cube_1x2x1.obj
--  @tfield table box {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
simple_models.cube_1x2x1 = {
	mesh = "simple_models_cube_1x2x1.obj",
	box = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
}

--- Panel
--
--  Alias: simple_models.panel
--
--  @table simple_models.panel_1x2x1
--  @tfield string mesh simple_models_panel_1x2x1.obj
--  @tfield table box {-0.5, -0.5, -0.5, 0.5, 1.5, -0.45}
simple_models.panel_1x2x1 = {
	mesh = "simple_models_panel_1x2x1.obj",
	box = {-0.5, -0.5, -0.5, 0.5, 1.5, -0.45},
}

--- Mid panel
--
--  Alias: simple_models.panel_mid
--
--  @table simple_models.panel_mid_1x2x1
--  @tfield string mesh simple_models_panel_mid_1x2x1.obj
--  @tfield table box {-0.5, -0.5, 0.025, 0.5, 1.5, -0.025},
simple_models.panel_mid_1x2x1 = {
	mesh = "simple_models_panel_mid_1x2x1.obj",
	box = {-0.5, -0.5, 0.025, 0.5, 1.5, -0.025},
}

--- Rear panel
--
--  Alias: simple_models.panel_rear
--
--  @table simple_models.panel_rear_1x2x1
--  @tfield string mesh simple_models_panel_rear_1x2x1.obj
--  @tfield table box {-0.5, -0.5, 0.45, 0.5, 1.5, 0.5}
simple_models.panel_rear_1x2x1 = {
	mesh = "simple_models_panel_rear_1x2x1.obj",
	box = {-0.5, -0.5, 0.45, 0.5, 1.5, 0.5},
}

--- Stair
--
--  Alias: simple_models.stair_2s
--
--  @table simple_models.stair_2s_1x1x1
--  @tfield string mesh simple_models_stair_2s_1x1x1.obj
--  @tfield table box {
--    {-0.5,  0.0,  0.0, 0.5, 0.5, 0.5},
--    {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
--  }
simple_models.stair_2s_1x1x1 = {
	mesh = "simple_models_stair_2s_1x1x1.obj",
	box = {
		{-0.5,  0.0,  0.0, 0.5, 0.5, 0.5},
		{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
	},
}

--- Stair (4-steps)
--
--  Alias: simple_models.stair_4s
--
--  @table simple_models.stair_4s_1x1x1
--  @tfield string mesh simple_models_stair_4s_1x1x1.obj
--  @tfield table box {
--    {-0.5,  0.25,  0.25, 0.5,  0.5,  0.5},
--    {-0.5,  0.0,   0.0,  0.5,  0.25, 0.5},
--    {-0.5, -0.25, -0.25, 0.5,  0.0,  0.5},
--    {-0.5, -0.5,  -0.5,  0.5, -0.25, 0.5},
--  }
simple_models.stair_4s_1x1x1 = {
	mesh = "simple_models_stair_4s_1x1x1.obj",
	box = {
		{-0.5,  0.25,  0.25, 0.5,  0.5,  0.5},
		{-0.5,  0.0,   0.0,  0.5,  0.25, 0.5},
		{-0.5, -0.25, -0.25, 0.5,  0.0,  0.5},
		{-0.5, -0.5,  -0.5,  0.5, -0.25, 0.5},
	},
}

--- Slope
--
--  Alias: simple_models.slope
--
--  @table simple_models.slope_1x1x1
--  @tfield string mesh simple_models_slope_1x1x1.obj
--  @tfield table box
simple_models.slope_1x1x1 = {
	mesh = "simple_models_slope_1x1x1.obj",
	box = {
		{-0.5, -0.5,  0.4, 0.5,  0.5, 0.5},
		{-0.5, -0.5,  0.3, 0.5,  0.4, 0.5},
		{-0.5, -0.5,  0.2, 0.5,  0.3, 0.5},
		{-0.5, -0.5,  0.1, 0.5,  0.2, 0.5},
		{-0.5, -0.5,  0.0, 0.5,  0.1, 0.5},
		{-0.5, -0.5, -0.1, 0.5,  0.0, 0.5},
		{-0.5, -0.5, -0.2, 0.5, -0.1, 0.5},
		{-0.5, -0.5, -0.3, 0.5, -0.2, 0.5},
		{-0.5, -0.5, -0.4, 0.5, -0.3, 0.5},
		{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
	},
}

--- Long Slope
--
--  Alias: simple_models.slope_long
--
--  @table simple_models.slope_1x1x2
--  @tfield string mesh simple_models_slope_1x1x2.obj
--  @tfield table box
simple_models.slope_1x1x2 = {
	mesh = "simple_models_slope_1x1x2.obj",
	box = {
		{-0.5, -0.5,  0.3, 0.5,  0.5, 0.5},
		{-0.5, -0.5,  0.1, 0.5,  0.4, 0.5},
		{-0.5, -0.5, -0.1, 0.5,  0.3, 0.5},
		{-0.5, -0.5, -0.3, 0.5,  0.2, 0.5},
		{-0.5, -0.5, -0.5, 0.5,  0.1, 0.5},
		{-0.5, -0.5, -0.7, 0.5,  0.0, 0.5},
		{-0.5, -0.5, -0.9, 0.5, -0.1, 0.5},
		{-0.5, -0.5, -1.1, 0.5, -0.2, 0.5},
		{-0.5, -0.5, -1.3, 0.5, -0.3, 0.5},
		{-0.5, -0.5, -1.5, 0.5, -0.4, 0.5},
	},
}


-- aliases

simple_models.cube = simple_models.cube_1x2x1
simple_models.panel = simple_models.panel_1x2x1
simple_models.panel_mid = simple_models.panel_mid_1x2x1
simple_models.panel_rear = simple_models.panel_rear_1x2x1
simple_models.stair_2s = simple_models.stair_2s_1x1x1
simple_models.stair_4s = simple_models.stair_4s_1x1x1
simple_models.slope = simple_models.slope_1x1x1
simple_models.slope_long = simple_models.slope_1x1x2
