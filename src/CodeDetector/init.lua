local Types = require(script.Parent.Types)

local Class = require(script.Class)
local Function = require(script.Function)
--TODO: Property, Type, Interface

local CodeDetector = {}

function CodeDetector:GetSourceCode(script: Script): Types.ScriptSource
	local source: string = script.Source
	local lines = {}
	for line: string in source:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end

	local classes: table = Class:GetClasses(lines)
	local functions: table = Function:GetFunctions(lines, classes)
	local properties = {}
	local types = {}
	local interfaces = {}

	return {
		Source = source,
		Lines = lines,
		Classes = classes,
		Functions = functions,
		Properties = properties,
		Types = types,
		Interfaces = interfaces,
	}
end

return CodeDetector
