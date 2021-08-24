
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


local modpath = core.get_modpath(core.get_current_modname())
dofile(modpath .. "/api.lua")

if core.settings:get_bool("simple_models.enable_samples", false) then
	dofile(modpath .. "/samples.lua")
end
