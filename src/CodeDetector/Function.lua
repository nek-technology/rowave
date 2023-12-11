local Types = require(script.Parent.Parent.Types)
local Moonwave = require(script.Parent.Moonwave)

local Funtion = {}


function Funtion:GetFunctions(source: table, classes: table): table
    local functions = {}
	local function_ = {}
	local inFunction = false

	for index, line in ipairs(source) do
		if line:match("^function") then
            -- check if we are in a function
            if inFunction then
                warn("Function started before previous function ended. Function: " .. function_.Name .. " Line: " .. index .. ". Skipping function.")
                function_ = {}
            end
			inFunction = true

            -- get class from classes table
            for _, class in ipairs(classes) do
                if class.StartLine < index and class.EndLine > index then
                    function_.Class = class
                end
            end

            -- if no class, skip function
            if not function_.Class then
                inFunction = false
                continue
            end

            -- set function properties
			function_.Name = line:gsub("^function ", "")
			function_.StartLine = index

            -- Find moonwave comment for this function
            local moonwaveComment: Types.MoonwaveComment = Moonwave:GetMoonwaveCommentsForLine(source, index)

            -- if there is a moonwave comment, parse it
            if moonwaveComment then
                function_.Description = moonwaveComment.Description
                function_.Method = moonwaveComment.Method
                function_.Yielding = moonwaveComment.Yielding
                function_.Errors = moonwaveComment.Errors
                function_.Params = moonwaveComment.Params
                function_.Return = moonwaveComment.Return
            else
                --TODO: Auto Detect
            end
		elseif line:match("end") then
			inFunction = false
			function_.EndLine = index
			table.insert(functions, function_)
			function_ = {}
		end
	end

	return functions
end

return Funtion