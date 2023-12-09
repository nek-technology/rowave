local Types = require(script.Parent.Parent.Types)

local Moonwave = {}

function Moonwave:GetMoonwaveCommentsForLine(source: table, line: number): Types.MoonwaveComment?
	--TODO: Get the moonwave comment from the line that was provided
	return nil
end

function Moonwave:GetMoonwaveComments(source: table): table
	-- Get all moonwave comments in the source
	local comments = {}
	local comment: Types.MoonwaveComment = {}
	local inComment = false

	-- TODO: Need to get both block and single line comments
	-- TODO: Split this code into smaller functions
	-- TODO: TEST THIS CODE LOL
	for index, line in ipairs(source) do
		if line:match("^%-%-%[%[") or line:match("^-%-%-%-") then
			inComment = true
			comment = {
				StartLine = index,
				EndLine = nil,
				Description = "",
				Method = false,
				Yielding = false,
				Errors = {},
				Params = {},
				Return = nil,
			}

			-- Check if everything is on one line
			if line:match("%]%]") then
				-- TODO: Parse the moonwave comment

				comment.EndLine = index
				table.insert(comments, comment)
				comment = {}
				inComment = false
			end

		-- Find moonwave tags
		elseif line:match("^@") then
			local tagType = line:gsub("^@", "")
			local tagValue = ""
			local tagDescription = ""

			if tagType == "method" then
				comment.Method = true
			elseif tagType == "yielding" then
				comment.Yielding = true
			elseif tagType == "param" then
				table.insert(comment.Params, { 
					Name = tagType,
					Value = tagValue,
					Description = tagDescription,
				})
			elseif tagType == "return" then
				comment.Return = { 
					Name = tagType,
					Value = tagValue,
					Description = tagDescription,
				}
			elseif tagType == "error" then
				table.insert(comment.Errors, { 
					Name = tagType,
					Value = tagValue,
					Description = tagDescription,
				})
			end

		-- End of moonwave comment
		elseif line:match("%]%]") then
			comment.EndLine = index
			table.insert(comments, comment)
			comment = {}
			inComment = false

		-- The line is part of the moonwave comment so add it to the description
		elseif inComment then
			comment.Description = comment.Description .. line .. "\n"
		end
	end

	return comments
end

function Moonwave:GetMoonwaveTags(source: table): table
	-- Get all moonwave tags in the source
	local tags = {}
	local tag: Types.Tag = {}
	local inTag = false

end

return Moonwave