
simple_models = {}

local modpath = core.get_modpath(core.get_current_modname())

local scripts = {
	"defs",
	"api",
}

for _, script in ipairs(scripts) do
	dofile(modpath .. "/" .. script .. ".lua")
end

if core.settings:get_bool("simple_models.enable_samples", false) then
	dofile(modpath .. "/samples.lua")
end
